-- Export a vim-dadbod (dbui) result buffer to a CSV/JSON file.
--
-- Adapted from a coworker's scratch-buffer exporter. Differences:
--   * writes to a real file on disk (prompts for a path) instead of a scratch tab
--   * skips the psql "(N rows)" / mysql "N rows in set" footer lines
--   * ships a `setup()` that registers :DBTableExport and a buffer-local keymap
--
-- It works by scraping the rendered result buffer, so it is adapter-agnostic
-- (handles your Redshift `---+---` rulers and MySQL `+---+` box rulers alike).
-- Caveat: dadbod renders psql with `-P columns=&columns`, so very wide rows can
-- be wrapped/truncated before we ever see them. For lossless Redshift exports,
-- `\pset format csv` + `\o /path/file.csv` in the query buffer is the safe route.

local M = {}

-- ---------- ruler-based parsing ----------
local function is_ruler(line)
  if not line or line == "" then return false end
  -- Supports both plain dashed rulers and MySQL box rulers (+-----+)
  local trimmed = vim.trim(line)
  if not trimmed:find("%-") then return false end
  return trimmed:match("^[%-%s|+]+$") ~= nil
end

-- psql footer "(123 rows)" / "(1 row)" and mysql footer "123 rows in set (...)".
-- These are non-empty, non-ruler lines, so without this they parse as data rows.
local function is_footer(line)
  local t = vim.trim(line or "")
  if t:match("^%(%d+ rows?%)$") then return true end
  if t:match("^%d+ rows? in set") then return true end
  if t:match("^Empty set") then return true end
  return false
end

local function find_header_and_ruler(lines)
  -- Strategy A (MySQL-style): ruler, header, ruler
  for i = 1, #lines - 2 do
    local a = vim.trim(lines[i] or "")
    local b = vim.trim(lines[i + 1] or "")
    local c = vim.trim(lines[i + 2] or "")
    if a ~= "" and b ~= "" and c ~= "" and is_ruler(lines[i]) and not is_ruler(lines[i + 1]) and is_ruler(lines[i + 2]) then
      return i + 1, i + 2
    end
  end

  -- Strategy B (plain fixed-width): header then ruler
  local header_idx, ruler_idx
  for i = 1, #lines do
    local t = vim.trim(lines[i] or "")
    if t ~= "" then
      header_idx = i
      for j = i + 1, #lines do
        local tj = vim.trim(lines[j] or "")
        if tj ~= "" then
          if is_ruler(lines[j]) then ruler_idx = j end
          break
        end
      end
      break
    end
  end
  return header_idx, ruler_idx
end

local function column_spans_from_ruler(ruler)
  local spans = {}
  local i, n = 1, #ruler
  while i <= n do
    if ruler:sub(i, i) == "-" then
      local s = i
      repeat i = i + 1 until i > n or ruler:sub(i, i) ~= "-"
      table.insert(spans, { s, i - 1 })
    else
      i = i + 1
    end
  end
  return spans
end

local function slice_fixed(line, s, e)
  local n = #line
  if s > n then return "" end
  if e > n then e = n end
  return vim.trim(line:sub(s, e))
end

local function dedupe_headers(headers)
  local seen, out = {}, {}
  for i, h in ipairs(headers) do
    local key = (h == "" and ("col_" .. i)) or h
    local base, k = key, key
    local idx = 2
    while seen[k] do
      k = base .. "_" .. idx
      idx = idx + 1
    end
    seen[k] = true
    table.insert(out, k)
  end
  return out
end

local function parse_with_ruler(lines)
  local header_idx, ruler_idx = find_header_and_ruler(lines)
  if not header_idx or not ruler_idx then return {}, {} end

  local spans = column_spans_from_ruler(lines[ruler_idx])
  if #spans == 0 then return {}, {} end

  local raw_header = {}
  for _, span in ipairs(spans) do
    table.insert(raw_header, slice_fixed(lines[header_idx], span[1], span[2]))
  end
  local header = dedupe_headers(raw_header)

  local rows = {}
  for i = ruler_idx + 1, #lines do
    local line = lines[i]
    if line and vim.trim(line) ~= "" and not is_ruler(line) and not is_footer(line) then
      local row = {}
      for ci, span in ipairs(spans) do
        row[ci] = slice_fixed(line, span[1], span[2])
      end
      table.insert(rows, row)
    end
  end

  return header, rows
end

local function csv_escape(cell)
  if cell:find('[,"\n]') then
    cell = '"' .. cell:gsub('"', '""') .. '"'
  end
  return cell
end

local function to_csv(header, rows)
  local out = {}
  local h = {}
  for _, k in ipairs(header) do table.insert(h, csv_escape(k)) end
  table.insert(out, table.concat(h, ","))

  for _, r in ipairs(rows) do
    local line = {}
    for i = 1, #header do
      table.insert(line, csv_escape(tostring(r[i] or "")))
    end
    table.insert(out, table.concat(line, ","))
  end

  return table.concat(out, "\n")
end

local function infer_primitive(s)
  if s == nil then return vim.NIL end
  local trimmed = vim.trim(s)
  if trimmed == "" then return vim.NIL end
  if trimmed:match("^[Tt][Rr][Uu][Ee]$") then return true end
  if trimmed:match("^[Ff][Aa][Ll][Ss][Ee]$") then return false end
  if trimmed:match("^%-?%d+$") then
    local n = tonumber(trimmed)
    if n then return n end
  end
  if trimmed:match("^%-?%d+%.%d+$") or trimmed:match("^%-?%d+%.?%d*[eE][%+%-]?%d+$") then
    local n = tonumber(trimmed)
    if n then return n end
  end
  return trimmed
end

local function json_escape_string(s)
  return (s
    :gsub("\\", "\\\\")
    :gsub('"', '\\"')
    :gsub("\b", "\\b")
    :gsub("\f", "\\f")
    :gsub("\n", "\\n")
    :gsub("\r", "\\r")
    :gsub("\t", "\\t"))
end

local function to_json_value(v)
  local t = type(v)
  if v == vim.NIL then
    return "null"
  elseif t == "number" then
    return tostring(v)
  elseif t == "boolean" then
    return v and "true" or "false"
  else
    return '"' .. json_escape_string(tostring(v)) .. '"'
  end
end

local function to_json(header, rows)
  local pieces = { "[" }
  for ri, r in ipairs(rows) do
    local fields = {}
    for i = 1, #header do
      local key = json_escape_string(header[i] or ("col_" .. i))
      local val = infer_primitive(r[i])
      table.insert(fields, string.format('  "%s": %s', key, to_json_value(val)))
    end
    local obj = "{\n" .. table.concat(fields, ",\n") .. "\n}"
    if ri < #rows then obj = obj .. "," end
    table.insert(pieces, obj)
  end
  table.insert(pieces, "]")
  return table.concat(pieces, "\n")
end

-- Expand ~, $VARS, and relative paths into an absolute path.
local function resolve_path(path)
  path = vim.fn.expand(path)
  return vim.fn.fnamemodify(path, ":p")
end

local function write_to_file(text, path)
  local abs = resolve_path(path)
  local dir = vim.fn.fnamemodify(abs, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
  -- writefile takes a list of lines; trailing newline is added per line.
  vim.fn.writefile(vim.split(text, "\n", { plain = true }), abs)
  return abs
end

-- format: "csv" | "json"; path: optional. Prompts for a path when omitted.
function M.export(format, path)
  format = (format or ""):lower()
  if format == "" then format = "csv" end
  if format ~= "csv" and format ~= "json" then
    vim.notify("DBTableExport: specify 'csv' or 'json'", vim.log.levels.ERROR)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local header, rows = parse_with_ruler(lines)
  if #header == 0 then
    vim.notify("DBTableExport: could not detect a result table in this buffer", vim.log.levels.ERROR)
    return
  end

  local text = (format == "csv") and to_csv(header, rows) or to_json(header, rows)

  local function finish(target)
    if not target or vim.trim(target) == "" then return end -- cancelled
    local ok, abs = pcall(write_to_file, text, target)
    if not ok then
      vim.notify("DBTableExport: write failed: " .. tostring(abs), vim.log.levels.ERROR)
      return
    end
    vim.notify(string.format("DBTableExport: wrote %d rows -> %s", #rows, abs), vim.log.levels.INFO)
  end

  if path and vim.trim(path) ~= "" then
    finish(path)
  else
    local default = vim.fn.expand("~/Downloads") .. "/query-" .. os.date("%Y%m%d-%H%M%S") .. "." .. format
    vim.ui.input({ prompt = "Export " .. format:upper() .. " to: ", default = default, completion = "file" }, finish)
  end
end

function M.setup()
  pcall(vim.api.nvim_del_user_command, "DBTableExport")

  -- :DBTableExport [csv|json] [path]
  vim.api.nvim_create_user_command("DBTableExport", function(opts)
    M.export(opts.fargs[1], opts.fargs[2])
  end, {
    nargs = "*",
    complete = function(arglead, cmdline)
      -- first arg: format; second arg: file path
      if #vim.split(vim.trim(cmdline), "%s+") <= 2 and not cmdline:match("%s$") then
        return vim.tbl_filter(function(f) return f:find("^" .. vim.pesc(arglead)) end, { "csv", "json" })
      end
      return vim.fn.getcompletion(arglead, "file")
    end,
  })

  -- Buffer-local keymap in dadbod result buffers: <leader>de -> export CSV (prompts for path)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dbout",
    group = vim.api.nvim_create_augroup("DBTableExport", { clear = true }),
    callback = function(args)
      vim.keymap.set("n", "<leader>de", function() M.export("csv") end,
        { buffer = args.buf, desc = "export dbout result to CSV file" })
    end,
  })
end

return M

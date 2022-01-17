local cmp = require("cmp")
local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspkind = require("lspkind")

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    }),
    formatting = {
        format = lspkind.cmp_format()
    },
})

local map = function(bufnr, mode, lhs, rhs, noremap, expr)
    if noremap == nil then
        noremap = true
    end
    if expr == nil then
        expr = false
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, {noremap = noremap, silent = false, expr = expr})
end

local on_attach = function(client, bufnr)
    client.capabilities = cmp_capabilities

    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspDiagnosticsNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspDiagnosticsPrev lua vim.diagnostic.goto_prev()")

    map(bufnr, "n", "gd", ":LspDef<CR>")
    map(bufnr, "n", "vr", ":LspRename<CR>")
    map(bufnr, "n", "gt", ":LspTypeDef<CR>")
    map(bufnr, "n", "K",  ":LspHover<CR>")
    map(bufnr, "n", "<C-n>", ":LspDiagnosticsNext<CR>")
    map(bufnr, "n", "<C-p>", ":LspDiagnosticsPrev<CR>")

    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
end

local lspconfig = require("lspconfig")

lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        on_attach(client, bufnr)
    end,
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.prettier,
    },
    on_attach = on_attach,
})

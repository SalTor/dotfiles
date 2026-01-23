local nmap = require('saltor').nmap

vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
}

-- Spell check
vim.lsp.config('harper_ls', {
  filetypes = { 'jjdescription', 'gitcommit' },
  settings = {
    ['harper-ls'] = {
      enabled = false,
      dialect = 'American',
      linters = {
        SpellCheck = true,
        SpelledNumbers = false,
        AnA = true,
        SentenceCapitalization = true,
        UnclosedQuotes = true,
        WrongQuotes = false,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        Matcher = true,
        CorrectNumberSuffix = true,
      },
      codeActions = {
        ForceStable = true,
      },
      markdown = {
        IgnoreLinkTitle = false,
      },
      diagnosticSeverity = 'hint',
      isolateEnglish = true,
      maxFileLength = 120000,
      ignoredLintsPath = {},
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local telescopeBuiltin = require 'telescope.builtin'

    nmap('gd', vim.lsp.buf.definition, 'LSP: [G]oto [D]efinition')
    nmap('gy', vim.lsp.buf.type_definition, 'LSP: [G]oto t[y]pe definition')
    nmap('grn', vim.lsp.buf.rename, 'LSP: [R]e[n]ame')
    nmap('gra', vim.lsp.buf.code_action, 'LSP: [C]ode [A]ction')
    nmap('grr', telescopeBuiltin.lsp_references, 'LSP: [G]oto [R]eferences')
    nmap('gri', vim.lsp.buf.implementation, 'LSP: [G]oto [I]mplementation')
    nmap('g0', vim.lsp.buf.document_symbol, 'LSP: Document Symbol')

    nmap('<leader>D', vim.lsp.buf.type_definition, 'LSP: Type [D]efinition')
    nmap('<leader>ws', telescopeBuiltin.lsp_dynamic_workspace_symbols, 'LSP: [W]orkspace [S]ymbols')
    -- nmap('<leader>,', telescopeBuiltin.git_files, 'File finder')
    -- nmap('<leader>/', telescopeBuiltin.buffers, 'Buffers')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'LSP: Hover Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, 'LSP: [G]oto [D]eclaration')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    nmap('<leader>ff', ':Format<CR>', 'Format buffer')
  end,
})

vim.lsp.config('ts_ls', {
  settings = {
    -- handlers = {},
  },
})

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindcss = {
      tailwindCSS = {
        classFunctions = { 'cva', 'tv', 'cn' },
        experimental = {
          classRegex = {
            -- { '(["\'`][^"\'`]*.*?["\'`])', '["\'`]([^"\'`]*).*?["\'`]' }, -- e.g., all strings
            -- { 'cn\\(([^)]*)\\)', '["\'`]([^"\'`]+)["\'`]' }, -- e.g., cn("...")
            -- { 'tv\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' }, -- e.g., tv("...")
            { 'Styles \\=([^;]*);', "'([^']*)'" }, -- e.g. const nameStyles = '...'
            { 'Styles \\=([^;]*);', '"([^"]*)"' }, -- e.g. const nameStyles = "..."
            { 'Styles \\=([^;]*);', '\\`([^\\`]*)\\`' }, -- e.g. const nameStyles = `...`
            -- { 'lassName\\=([^;]*);', '"([^"]*)"' }, -- e.g., <MyDiv nameClassName="..." />
          },
        },
      },
    },
  },
})

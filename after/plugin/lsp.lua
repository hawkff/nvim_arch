local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')
----------------------------------------------------------------------
lsp_zero.on_attach(function(client, bufnr)         -- it is called for each attached buffer
    local opts = { buffer = bufnr, remap = false } -- bufnr is the buffer where the client is attached

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts, { desc = "Go to definition" })
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts, { desc = "Show hover information" })
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts,
        { desc = "Search for symbol in workspace" })
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts,
        { desc = "Open diagnostic float" })
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts, { desc = "Go to next diagnostic" })
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts, { desc = "Go to previous diagnostic" })
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts, { desc = "Show code actions" })
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts, { desc = "Show references" })
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts,
        { desc = "Rename symbol under cursor across the workspace" })
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts, { desc = "Show signature help" })
end)

----------------------------------------------------------------------
local diagnostic_config = {
    -- Configuration for virtual text
    virtual_text = {
        prefix = '★', -- Symbol for diagnostics
        spacing = 0, -- Adjust spacing if needed
        format = function(diagnostic)
            return '' -- Return empty string to not display the diagnostic text inline
        end,
    },
    -- Configuration for the floating window
    float = {
        source = "always",    -- Always show the source in hover windows
        border = 'rounded',   -- Use rounded borders for a softer look
        focusable = false,    -- Make the window non-focusable
        style = 'minimal',    -- Minimal style for less distraction
        header = '',          -- No header for a cleaner look
        prefix = '',          -- No prefix for diagnostics in the float
    },
    signs = true,             -- Enable diagnostic signs in the sign column
    underline = true,         -- Enable underlining of the text where diagnostics occur
    update_in_insert = false, -- Disable updates in insert mode for performance
    severity_sort = true,     -- Sort diagnostics by severity
}
vim.diagnostic.config(diagnostic_config)

-- Place the color customization here
local function set_highlight(group, properties)
    vim.api.nvim_set_hl(0, group, properties)
end

-- Set custom colors for virtual text diagnostics
-- set_highlight('DiagnosticVirtualTextError', { fg = '' }) -- error color
-- set_highlight('DiagnosticVirtualTextWarn',  { fg = '' }) -- warn color
-- set_highlight('DiagnosticVirtualTextInfo',  { fg = '' }) -- info color
set_highlight('DiagnosticVirtualTextHint', { fg = '#00ffae' })  -- hint color
set_highlight('DiagnosticSignHint', { fg = '#00ffae' })         -- sign for hints



-- Custom handler for hover documentation
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded", -- Match the border style with diagnostic float
        focusable = false,  -- Make the hover window non-focusable
        style = 'minimal',  -- Maintain minimal style for hover as well
    }
)

----------------------------------------------------------------------
-- Hyprlang LSP
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
		pattern = {"*.hl", "hypr*.conf"},
		callback = function(event)
				print(string.format("starting hyprls for %s", vim.inspect(event)))
				vim.lsp.start {
						name = "hyprlang",
						cmd = {"hyprls"},
						root_dir = vim.fn.getcwd(),
				}
		end
})
----------------------------------------------------------------------

-- an attempt to install OpenGL LSP
require('lspconfig').glsl_analyzer.setup {}


----------------------------------------------------------------------

--require('lspconfig').sourcekit.setup{
--  cmd = { "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp" };
---- exclude c and cpp
--    filetypes = {"swift", "objective-c", "objective-cpp"},
----
--  root_dir = function(fname)
--        -- Try to find the default root
--        local default_root = lspconfig.util.root_pattern('.git', 'compile_commands.json', 'compile_flags.txt')(fname)
--        -- If a root is found, use it. Otherwise, use the directory of the current file.
--        return default_root or vim.fn.fnamemodify(fname, ':p:h')
--    end;
--}

----------------------------------------------------------------------
-- lspconfig.sourcekit.setup({
--     -- capabilities = capabilities,
--     -- on_attach = on_attach,
--     cmd = {
--         "/path/to/directory",
--     },
--     filetypes = { "swift", "objective-c", "objective-cpp" },
--     root_dir = function(filename, _)
--         local util = require("lspconfig.util")
--         -- Try to find the root based on several criteria, with a fallback to the directory of the current file
--         return util.root_pattern("buildServer.json")(filename) -- xcode-build-server have to be installed
--             or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
--             or util.find_git_ancestor(filename)
--             or util.root_pattern("Package.swift")(filename)
--             or util.root_pattern('.git', 'compile_commands.json', 'compile_flags.txt')(filename)
--             or vim.fn.fnamemodify(filename, ':p:h') -- Fallback from your original script
--     end,
-- })
----------------------------------------------------------------------
-- Set up clangd with Homebrew's path
-- require('lspconfig').clangd.setup{
--   cmd = { "/opt/homebrew/opt/llvm/bin/clangd" },
--   root_dir = function(fname)
--         -- Try to find the default root
--         local default_root = lspconfig.util.root_pattern('.git', 'compile_commands.json', 'compile_flags.txt')(fname)
--         -- If a root is found, use it. Otherwise, use the directory of the current file.
--         return default_root or vim.fn.fnamemodify(fname, ':p:h')
--   end;
-- }
----------------------------------------------------------------------
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        -- 'lua_ls',        --1
        -- 'clangd',        --2
        -- 'cmake',         --3
        -- 'rust_analyzer', --4
        -- 'gopls',         --5
        -- 'html',          --6
        -- 'htmx',          --7
        -- -- 'jq',             --8
        -- 'tsserver',      --9
        -- 'cssls',         --10

    },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

----------------------------------------------------------------------

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local lspkind = require("lspkind")
local luasnip = require 'luasnip'
-- local cmp_format = require('lsp-zero').cmp_format()

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'luasnip' },
    },
    formatting = {
        format = lspkind.cmp_format({
            maxwidth = 40,
            ellipsis_char = "...",
            with_text = true, -- Show text alongside icons
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                nvim_lua = "[Lua]",
                spell = "[Spell]",
            }
        })
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-b>'] = cmp.mapping.complete(), -- show completion suggestions
        ['<C-q>'] = cmp.mapping.abort(),    -- close completion window
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        --------------------------------------------------------------
        -- ["<C-b>"] = cmp.mapping(function(fallback)
        --     if luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
        -- ["<C-f>"] = cmp.mapping(function(fallback)
        --     if luasnip.jumpable(1) then
        --         luasnip.jump(1)
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
        --------------------------------------------------------------
    }),
})

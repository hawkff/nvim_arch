require('copilot').setup({
    panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
        },
        layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            -- accept = "<C-CR>",
            accept = "<C-j>",
            -- accept_word = "<C-;>",
            accept_word = "<C-w>",
            accept_line = "<C-L>",
            next = "<C-N>",
            prev = "<C-P>",
            -- dismiss = "<C-'>",
            dismiss = "<C-c>",
        },
    },
    filetypes = {
        yaml = true,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
    copilot_node_command = 'node', -- Node.js version must be > 18.x
    server_opts_overrides = {},
})

vim.api.nvim_create_augroup('copilot_autostart', {})
vim.api.nvim_create_autocmd('BufEnter', {
    group = 'copilot_autostart',
    pattern = '*',
    command = 'Copilot enable',
})

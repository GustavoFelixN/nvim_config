return {
    'https://github.com/neovim/nvim-lspconfig',

    dependencies = {
        {
            'j-hui/fidget.nvim',
            opts = {},
        },
        'saghen/blink.cmp',
        {
            'SmiteshP/nvim-navbuddy',
            dependencies = {
                'SmiteshP/nvim-navic',
                'MunifTanjim/nui.nvim',
            },
            opts = { lsp = { auto_attach = true } },
        },
    },

    config = function()
        -- Options
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end
                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
                map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                vim.diagnostic.config({
                    severity_sort = true,
                    float = { border = 'rounded', source = 'if_many' },
                    underline = { severity = vim.diagnostic.severity.ERROR },
                    signs = vim.g.have_nerd_font and {
                        text = {
                            [vim.diagnostic.severity.ERROR] = '󰅚 ',
                            [vim.diagnostic.severity.WARN] = '󰀪 ',
                            [vim.diagnostic.severity.INFO] = '󰋽 ',
                            [vim.diagnostic.severity.HINT] = '󰌶 ',
                        },
                    } or {},
                    virtual_text = {
                        source = 'if_many',
                        spacing = 2,
                        format = function(diagnostic)
                            local diagnostic_message = {
                                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                                [vim.diagnostic.severity.WARN] = diagnostic.message,
                                [vim.diagnostic.severity.INFO] = diagnostic.message,
                                [vim.diagnostic.severity.HINT] = diagnostic.message,
                            }
                            return diagnostic_message[diagnostic.severity]
                        end,
                    },
                })

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
                then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
                        end,
                    })
                end

                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })
        -- Servers
        vim.lsp.config['luals'] = {
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    worskpace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                    },
                    runtime = {
                        version = 'LuaJIT',
                    },
                },
            },
        }

        vim.lsp.config['clangd'] = {
            settings = { init_options = {
                fallbackFlags = { '--std=c++20' },
            } },
        }

        vim.lsp.enable('luals')
        vim.lsp.enable('ts_ls')
        vim.lsp.enable('java_language_server')
        vim.lsp.enable('clangd')
    end,
}

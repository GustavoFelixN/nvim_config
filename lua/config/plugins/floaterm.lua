return {
    'nvzone/floaterm',
    dependencies = 'nvzone/volt',
    opts = {
        terminals = {
            { name = 'build' },
            { name = 'git', cmd = 'lazygit' },
        },
    },
    cmd = 'FloatermToggle',
}

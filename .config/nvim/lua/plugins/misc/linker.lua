return {
    'ruifm/gitlinker.nvim',
    requires = {
        {'nvim-lua/plenary.nvim'}
    },
    config = function ()
        require("gitlinker").setup({
            callbacks = {
                ["typeform.github.com"] = function(url_data)
                    url_data.host = "github.com"
                    return require("gitlinker.hosts").get_github_type_url(url_data)
                end
            }
        })
    end
}

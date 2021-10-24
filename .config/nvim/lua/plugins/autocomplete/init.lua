return {
  'hrsh7th/nvim-cmp',
  requires = {
    {'L3MON4D3/LuaSnip'},
    {'onsails/lspkind-nvim'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-buffer'},
    {'saadparwaiz1/cmp_luasnip'},
  },
  config = function()
    vim.o.completeopt = "menuone,noinsert,noselect"

    local cmp = require('cmp')

    local check_back_space = function()
      local col = vim.fn.col '.' - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
    end

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    cmp.setup({
      formatting = {
        format = require('lspkind').cmp_format({with_text = false, maxwidth = 50})
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'calc' },
      }, {
        { name = 'buffer' },
      })
    })
  end
}

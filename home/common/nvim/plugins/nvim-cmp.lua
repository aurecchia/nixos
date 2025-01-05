-- Set up nvim-cmp.
local cmp = require('cmp')
local lspkind = require("lspkind")

local select_next_item = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

local select_prev_item = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  window = {
    completion = {
      col_offset = -3,
      side_padding = 0,
    },
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    -- Combine cmp_format with an aditiona symbol on the left
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "   [" .. (strings[2] or "") .. "]"
      return kind
    end,
  },

  mapping = {
    ['<Down>'] = cmp.mapping(select_next_item),
    ['<Up>'] = cmp.mapping(select_next_item),
    ['<C-n>'] = cmp.mapping(select_next_item),
    ['<C-p>'] = cmp.mapping(select_next_item),

    ['<C-u>'] = cmp.mapping.scroll_docs(-5),
    ['<C-d>'] = cmp.mapping.scroll_docs(5),

    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          end
          cmp.confirm()
        else
          fallback()
        end
      end, { "i", "s", "c" }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'emoji' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  })

})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
    { name = 'buffer' },
  }, {
    { name = 'buffer' },
  })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ['<C-u>'] = cmp.mapping.scroll_docs(-5),
    ['<C-d>'] = cmp.mapping.scroll_docs(5),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-c>'] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          end
          cmp.confirm()
        else
          fallback()
        end
      end, { "i", "s", "c" }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Set `select` to `false` to only confirm explicitly selected items.
  }),

  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig').vimls.setup {
  capabilities = capabilities
}


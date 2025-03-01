# Namu.nvim

🌿 Jump to symbols in your code with live preview, built-in fuzzy finding, and other modules.
Inspired by Zed, it preserves symbol order while guiding you through your codebase.

“Namu” means “tree🌳” in Korean—just like how it helps you navigate the structure of your code.

> [!WARNING]
> 🚧 **Beta Status**: This plugin is currently in beta. While it's functional, you may encounter breaking changes as we improve and refine the architecture. Your feedback and contributions are welcome!

https://github.com/user-attachments/assets/a28a43d9-a477-4b92-89f3-c40479c7801b





## What Makes It Special

- 🔍 **Live Preview**: See exactly where you'll land before you jump
- 🌳 **Order Preservation**: Maintains symbol order as they appear in your code, even after filtering
- 📐 **Smart Auto-resize**: Window adapts to your content in real-time as you type and filter, no need for a big window with only a couple of items
- 🚀 **Zero Dependencies**: Works with any LSP-supported language out of the box
- 🎯 **Context Aware**: Always shows your current location in the codebase
- 🌑 **Initially Hidden Mode**: Start with an empty list and populate it dynamically as you type, just like the command palette in Zed and VS Code
- ⚡ **Powerful Filtering**:
  - Built-in fuzzy finding that understands code structure
  - Filter by symbol types (functions, classes, methods)
  - Use regex patterns (e.g., `^__` to filter out Python's `__init__` methods)
- 🎨 **Quality of Life**:
  - Auto-select when only one match remains
  - Remembers cursor position when you cancel
  - Customizable window style and behavior
- ✂️  **Multi-Action Workflow**: Perform multiple operations while Namu is open (or close it after, you choose!):
  - Delete, yank, and add to CodeCompanion chat (more plugins coming soon)
  - Works with both single and multiple selected symbols

## 🧩 Other Built-in Modules

Namu is powered by Selecta, a minimal and flexible fuzzy finder that's also used by:
- 🎨 **Colorscheme Picker**: Live preview with your code and switch themes with persistence
- 🔄 **vim.ui.select**: Enhanced wrapper for Vim's built-in selector
- 📦 More modules coming soon, including buffers and diagnostics!

## ⚡ Requirements
- Neovim >= 0.10.0
- Configured LSP server for your language (Treesitter fallback coming soon)
- Treesitter (for live preview functionality)

## Installation

### Lazy.nvim

Using [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
  "bassamsdata/namu.nvim",
  config = function()
    require("namu").setup({
      -- Enable the modules you want
      namu_symbols = {
        enable = true,
        options = {}, -- here you can configure namu
      },
      -- Optional: Enable other modules if needed
      ui_select = { enable = false }, -- vim.ui.select() wrapper
      colorscheme = {
        enable = false,
        options = {
          -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
          persist = true, -- very efficient mechanism to Remember selected colorscheme
          write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
        },
      },
    })
    -- === Suggested Keymaps: ===
    vim.keymap.set("n", "<leader>ss",":Namu symbols<cr>" , {
      desc = "Jump to LSP symbol",
      silent = true,
    })
    vim.keymap.set("n", "<leader>th", ":Namu colorscheme<cr>", {
      desc = "Colorscheme Picker",
      silent = true,
    })
  end,
}
```

<details>
  <summary>📦 Paq.nvim</summary>

  ```lua
  require "paq" {
    "bassamsdata/namu.nvim"
  }
  ```

</details>

<details>
  <summary>📦 Mini.deps</summary>

  ```lua
  require("mini.deps").add("bassamsdata/namu.nvim")
  ```

</details>

### Keymaps

<details>
<summary>Default keymaps are:</summary>

#### Navigation Keymaps
| Key | Action |
|-----|--------|
| `<CR>` | Select item |
| `<Esc>` | Close picker |
| `<C-n>` | Next item |
| `<Down>` | Next item |
| `<C-p>` | Previous item |
| `<Up>` | Previous item |
| `q` | Close help |



#### Multiselect
| Key | Action |
|-----|--------|
| `<Tab>` | Toggle |
| `<C-a>` | Select all |
| `<C-l>` | Clear all |
| `<S-Tab>` | Untoggle |

#### Custom Actions
| Key | Action |
|-----|--------|
| `<C-y>` | Yank symbol/concatenate selected symbols and yank |
| `<C-d>` | Delete symbol/concatenate selected symbols and delete |
| `<C-v>` | Open symbol buffer on vertical split |
| `<C-h>` | Open symbol buffer on horizontal split |
| `<C-o>` | Add symbol/concatenate selected symbols and add them to codecompanion chat buffer |

</details>

### Change Keymaps:

<details>
<summary>change the default keymaps:</summary>

```lua
-- in namu_symbols.options
  movement = {
    next = { "<C-n>", "<DOWN>" }, -- Support multiple keys
    previous = { "<C-p>", "<UP>" }, -- Support multiple keys
    close = { "<ESC>" }, -- close mapping
    select = { "<CR>" }, -- select mapping
    delete_word = {}, -- delete word mapping
    clear_line = {}, -- clear line mapping
  },
  multiselect = {
    enabled = false,
    indicator = "●", -- or "✓"◉
    keymaps = {
      toggle = "<Tab>",
      select_all = "<C-a>",
      clear_all = "<C-l>",
      untoggle = "<S-Tab>",
    },
    max_items = nil, -- No limit by default
  },
  custom_keymaps = {
    yank = {
      keys = { "<C-y>" }, -- yank symbol text
    },
    delete = {
      keys = { "<C-d>" }, -- delete symbol text
    },
    vertical_split = {
      keys = { "<C-v>" }, -- open in vertical split
    },
    horizontal_split = {
      keys = { "<C-h>" }, -- open in horizontal split
    },
    codecompanion = {
      keys = "<C-o>", -- Add symbols to CodeCompanion
    },
    avante = {
      keys = "<C-t>", -- Add symbol to Avante
    },
  },
```

</details>

## Commands

The `Namu` command provides several subcommands with autocomplete:

- **symbols**: Symbols Navigator
- **colorscheme**: Select and apply a colorscheme.
- **help**: Display help for all commands.

To use the `Namu` command, enter the following in command mode:

```lua
:Namu <subcommand>
```

## Make It Yours

You can check the [configuration documentation](https://github.com/bassamsdata/namu.nvim/tree/main/docs/Namu_config.md) for details on each option.
<details>
  <summary>Here's the full setup with defaults:</summary>

```lua
{ -- Those are the default options
  "bassamsdata/namu.nvim",
  config = function()
    require("namu").setup({
      -- Enable symbols navigator which is the default
      namu_symbols = {
        enable = true,
        ---@type NamuConfig
        options = {
          AllowKinds = {
            default = {
              "Function",
              "Method",
              "Class",
              "Module",
              "Property",
              "Variable",
              -- "Constant",
              -- "Enum",
              -- "Interface",
              -- "Field",
              -- "Struct",
            },
            go = {
              "Function",
              "Method",
              "Struct", -- For struct definitions
              "Field", -- For struct fields
              "Interface",
              "Constant",
              -- "Variable",
              "Property",
              -- "TypeParameter", -- For type parameters if using generics
            },
            lua = { "Function", "Method", "Table", "Module" },
            python = { "Function", "Class", "Method" },
            -- Filetype specific
            yaml = { "Object", "Array" },
            json = { "Module" },
            toml = { "Object" },
            markdown = { "String" },
          },
          BlockList = {
            default = {},
            -- Filetype-specific
            lua = {
              "^vim%.", -- anonymous functions passed to nvim api
              "%.%.%. :", -- vim.iter functions
              ":gsub", -- lua string.gsub
              "^callback$", -- nvim autocmds
              "^filter$",
              "^map$", -- nvim keymaps
            },
            -- another example:
            -- python = { "^__" }, -- ignore __init__ functions
          },
          display = {
            mode = "icon", -- "icon" or "raw"
            padding = 2,
          },
          -- This is a preset that let's set window without really get into the hassle of tuning window options
          -- top10 meaning top 10% of the window
          row_position = "top10", -- options: "center"|"top10"|"top10_right"|"center_right"|"bottom",
          preview = {
            highlight_on_move = true, -- Whether to highlight symbols as you move through them
            -- still needs implmenting, keep it always now
            highlight_mode = "always", -- "always" | "select" (only highlight when selecting)
          },
          window = {
            auto_size = true,
            min_height = 1,
            min_width = 20,
            max_width = 120,
            max_height = 30,
            padding = 2,
            border = "rounded",
            title_pos = "left",
            show_footer = true,
            footer_pos = "right",
            relative = "editor",
            style = "minimal",
            width_ratio = 0.6,
            height_ratio = 0.6,
            title_prefix = "󱠦 ",
          },
          debug = false,
          focus_current_symbol = true,
          auto_select = false,
          initially_hidden = false,
          multiselect = {
            enabled = true,
            indicator = "✓", -- or "✓"●
            keymaps = {
              toggle = "<Tab>",
              untoggle = "<S-Tab>",
              select_all = "<C-a>",
              clear_all = "<C-l>",
            },
            max_items = nil, -- No limit by default
          },
          actions = {
            close_on_yank = false, -- Whether to close picker after yanking
            close_on_delete = true, -- Whether to close picker after deleting
          },
          movement = {-- Support multiple keys
            next = { "<C-n>", "<DOWN>" },
            previous = { "<C-p>", "<UP>" },
            close = { "<ESC>" }, -- "<C-c>" can be added as well
            select = { "<CR>" },
            delete_word = {}, -- it can assign "<C-w>"
            clear_line = {}, -- it can be "<C-u>"
          },
          custom_keymaps = {
            yank = {
              keys = { "<C-y>" },
              desc = "Yank symbol text",
            },
            delete = {
              keys = { "<C-d>" },
              desc = "Delete symbol text",
            },
            vertical_split = {
              keys = { "<C-v>" },
              desc = "Open in vertical split",
            },
            horizontal_split = {
              keys = { "<C-h>" },
              desc = "Open in horizontal split",
            },
            codecompanion = {
              keys = "<C-o>",
              desc = "Add symbol to CodeCompanion",
            },
            avante = {
              keys = "<C-t>",
              desc = "Add symbol to Avante",
            },
          },
          icon = "󱠦", -- 󱠦 -  -  -- 󰚟
          kindText = {
            Function = "function",
            Class = "class",
            Module = "module",
            Constructor = "constructor",
            Interface = "interface",
            Property = "property",
            Field = "field",
            Enum = "enum",
            Constant = "constant",
            Variable = "variable",
          },
          kindIcons = {
            File = "󰈙",
            Module = "󰏗",
            Namespace = "󰌗",
            Package = "󰏖",
            Class = "󰌗",
            Method = "󰆧",
            Property = "󰜢",
            Field = "󰜢",
            Constructor = "󰆧",
            Enum = "󰒻",
            Interface = "󰕘",
            Function = "󰊕",
            Variable = "󰀫",
            Constant = "󰏿",
            String = "󰀬",
            Number = "󰎠",
            Boolean = "󰨙",
            Array = "󰅪",
            Object = "󰅩",
            Key = "󰌋",
            Null = "󰟢",
            EnumMember = "󰒻",
            Struct = "󰌗",
            Event = "󰉁",
            Operator = "󰆕",
            TypeParameter = "󰊄",
          },
          highlight = "NamuPreview",
          highlights = {
            parent = "NamuParent",
            nested = "NamuNested",
            style = "NamuStyle",
          },
          kinds = {
            prefix_kind_colors = true,
            enable_highlights = true,
            highlights = {
              PrefixSymbol = "NamuPrefixSymbol",
              Function = "NamuSymbolFunction",
              Method = "NamuSymbolMethod",
              Class = "NamuSymbolClass",
              Interface = "NamuSymbolInterface",
              Variable = "NamuSymbolVariable",
              Constant = "NamuSymbolConstant",
              Property = "NamuSymbolProperty",
              Field = "NamuSymbolField",
              Enum = "NamuSymbolEnum",
              Module = "NamuSymbolModule",
            },
          },
        }
      }
      colorscheme = {
        enable = false,
        options = {
          -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
          persist = true, -- very efficient mechanism to Remember selected colorscheme
          write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
          excluded_schemes = {}, -- exclude any colorscheme from the list
          -- it accept the same row_position and movement keys as the one in namy symbols
        },
      },
      ui_select = { enable = false }, -- vim.ui.select() wrapper
    })
  end,
}
```

</details>


## Tips

- Type to filter symbols - it's fuzzy, so no need to be exact, though it prioritizes exact words first
- Use regex patterns for precise filtering (e.g., `^test_` for test functions)
- Press `<CR>` to jump, `<Esc>` to cancel

## Feature Demos

<details>
  <summary>🌳 Order Preservation</summary>
Maintains symbol order as they appear in your code, even after filtering


https://github.com/user-attachments/assets/2f84f1b0-3fb7-4d69-81ea-8ec70acb5b80


</details>

<details>
  <summary>🌑 Initially Hidden Mode</summary>
Start with an empty list and populate it dynamically as you type, just like the command palette in Zed and VS Code


https://github.com/user-attachments/assets/e279b785-5fcf-4c2c-8cb5-b0467d850dd0


</details>

<details>
  <summary>🔍 Live Preview & Context Aware</summary>
focus on the current location in the codebase when open so you know where you are in the code

https://github.com/user-attachments/assets/292a94f3-264a-4ffa-9203-407bd101e35c


</details>

<details>
  <summary>⚡ Auto-select</summary>
if only one match remains, automatically select it. In the video I didn't press enter, yet the jump was done automatically.

https://github.com/user-attachments/assets/a8768aae-e190-4707-989a-0ee909380a5d


</details>

## Contributing

I made this plugin for fun at first and didn't know I could replicate what Zed has, and to be independent and free from any pickers.
Pull requests are welcome! Just please be kind and respectful.
Any suggestions to improve and integrate with other plugins are also welcome.

## Credits & Acknowledgements

- [Zed](https://zed.dev) editor for the idea.
- [Mini.pick](https://github.com/echasnovski/mini.nvim) @echasnovski for the idea of `getchar()`, without which this plugin wouldn't exist.
- Magnet module (couldn’t find it anymore on GitHub, sorry!), which intrigued me a lot.
- @folke for handling multiple versions of Neovim LSP requests in [Snacks.nvim](https://github.com/folke/snacks.nvim).
- tests and ci structure, thanks to @Oli [CodeCompanion](https://github.com/olimorris/codecompanion.nvim)
- A simple mechanism to persist the colorscheme, thanks to this [Reddit comment](https://www.reddit.com/r/neovim/comments/1edwhk8/comment/lfb1m2f/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button).

{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      settings = {
        delay = 500;
        icons = {
          breadcrumb = "»";
          group = "+";
          separator = ""; # ➜
          mappings = false;
        };
        spec = [
          # General Mappings
          {
            __unkeyed-1 = "<leader>u";
            mode = "n";
            group = "+ui";
          }
          {
            __unkeyed-1 = "<leader>w";
            mode = "n";
            group = "+windows";
          }
          {
            __unkeyed-1 = "<leader>c";
            mode = "n";
            group = "+copilot";
          }
        ];
        win = {
          border = "rounded";
          wo.winblend = 0;
        };
      };
    };

    keymaps = [
      # General Mappings
      {
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash";
      }
      {
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        options.desc = "LSP Hover";
      }
      {
        key = "<C-tab>";
        action = "<cmd>bnext<cr>";
        options.desc = "Next Buffer";
      }

      # Tmux
      {
        key = "<C-h>";
        action = "<cmd>TmuxNavigateLeft<cr>";
      }
      {
        key = "<C-j>";
        action = "<cmd>TmuxNavigateDown<cr>";
      }
      {
        key = "<C-k>";
        action = "<cmd>TmuxNavigateUp<cr>";
      }
      {
        key = "<C-l>";
        action = "<cmd>TmuxNavigateRight<cr>";
      }

      # Disable Arrow Keys in Normal Mode
      {
        key = "<Up>";
        action = "<Nop>";
        options.desc = "Disable Up Arrow";
      }
      {
        key = "<Down>";
        action = "<Nop>";
        options.desc = "Disable Down Arrow";
      }
      {
        key = "<Left>";
        action = "<Nop>";
        options.desc = "Disable Left Arrow";
      }
      {
        key = "<Right>";
        action = "<Nop>";
        options.desc = "Disable Right Arrow";
      }

      # UI
      {
        key = "<leader>uw";
        action = "<cmd>set wrap!<cr>";
        options.desc = "Toggle word wrapping";
      }
      {
        key = "<leader>ul";
        action = "<cmd>set linebreak!<cr>";
        options.desc = "Toggle linebreak";
      }
      {
        key = "<leader>us";
        action = "<cmd>set spell!<cr>";
        options.desc = "Toggle spellLazyGitcheck";
      }
      {
        key = "<leader>uc";
        action = "<cmd>set cursorline!<cr>";
        options.desc = "Toggle cursorline";
      }
      {
        key = "<leader>un";
        action = "<cmd>set number!<cr>";
        options.desc = "Toggle line numbers";
      }
      {
        key = "<leader>ur";
        action = "<cmd>set relativenumber!<cr>";
        options.desc = "Toggle relative line numbers";
      }
      {
        key = "<leader>ut";
        action = "<cmd>set showtabline=2<cr>";
        options.desc = "Show tabline";
      }
      {
        key = "<leader>uT";
        action = "<cmd>set showtabline=0<cr>";
        options.desc = "Hide tabline";
      }

      # Windows
      {
        key = "<leader>ws";
        action = "<cmd>split<cr>";
        options.desc = "Split";
      }
      {
        key = "<leader>wv";
        action = "<cmd>vsplit<cr>";
        options.desc = "VSplit";
      }
      {
        key = "<leader>wd";
        action = "<cmd>close<cr>";
        options.desc = "Close";
      }

      # copilot
      {
        key = "<leader>ce";
        action = "<cmd>Copilot enable<cr>";
        options.desc = "Enable";
      }
      {
        key = "<leader>cd";
        action = "<cmd>Copilot disable<cr>";
        options.desc = "Disable";
      }
      {
        key = "<leader>cs";
        action = "<cmd>Copilot status<cr>";
        options.desc = "Status";
      }
      {
        key = "<leader>cp";
        action = "<cmd>Copilot<cr>";
        options.desc = "Completions for current buffer";
      }
      {
        key = "<leader>ca";
        action = "<cmd>Copilot auth<cr>";
        options.desc = "Authenticate Copilot";
      }
      {
        key = "<leader>cr";
        action = "<cmd>Copilot restart<cr>";
        options.desc = "Restart";
      }
      {
        key = "<leader>cl";
        action = "<cmd>Copilot log<cr>";
        options.desc = "Logs";
      }
      {
        key = "<leader>ch";
        action = "<cmd>Copilot help<cr>";
        options.desc = "Help";
      }
      {
        key = "<leader>cv";
        action = "<cmd>Copilot version<cr>";
        options.desc = "Version";
      }
    ];
  };
}

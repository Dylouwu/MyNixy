{ config, lib, pkgs, ... }: {
  programs.nixvim = {
    nixpkgs.config.allowUnfree = true; # For copilot
    highlightOverride = {
      WhichKeySeparator.bg = "#${config.lib.stylix.colors.base00}";
    };
    plugins = {
      bufferline = {
        enable = true;
        settings = { options = { always_show_bufferline = false; }; };
      };
      copilot-vim = {
        enable = true;
        settings.node_command = lib.getExe pkgs.nodejs_20;
      };
      flash.enable = true;
      tmux-navigator.enable = true;
      todo-comments.enable = true;
      lualine = {
        enable = true;
        settings = {
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "filename" ];
            lualine_c = [ "" ];
            lualine_x = [ "" ];
            lualine_y = [ "encoding" "filetype" ];
            lualine_z =
              [ { __unkeyed-1 = "location"; } { __unkeyed-1 = "%L"; } ];
          };

        };

      };
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          ensure_installed = "all";
          indent.enable = true;
          highlight.enable = true;
        };
      };
    };
  };
}

_: {
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        icons = { };
        bracketed = { };
        git = { };
        diff = { };
        starter = { };
        pairs = { };
        notify = { lsp_progress.enable = false; };
        indentscope = { };
        cursorword = { };
        comment = { };
        starter = { };
      };
    };
  };
}

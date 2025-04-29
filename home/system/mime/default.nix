# Mime allows us to configure the default applications for each file type
{
  xdg = {
    enable = true;
    mime.enable = true;
    userDirs.enable = true;
    portal.xdgOpenUsePortal = true;
    configFile."mimeapps.list".force =
      true; # don't error when mimeapps.list is replaced, it gets replaced often
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/markdown" = "org.gnome.TextEditor.desktop";
        "text/plain" = "org.gnome.TextEditor.desktop";
        "text/x-shellscript" = "org.gnome.TextEditor.desktop";
        "text/x-python" = "org.gnome.TextEditor.desktop";
        "text/x-go" = "org.gnome.TextEditor.desktop";
        "text/css" = "org.gnome.TextEditor.desktop";
        "text/javascript" = "org.gnome.TextEditor.desktop";
        "text/x-c" = "org.gnome.TextEditor.desktop";
        "text/x-c++" = "org.gnome.TextEditor.desktop";
        "text/x-java" = "org.gnome.TextEditor.desktop";
        "text/x-rust" = "org.gnome.TextEditor.desktop";
        "text/x-yaml" = "org.gnome.TextEditor.desktop";
        "text/x-toml" = "org.gnome.TextEditor.desktop";
        "text/x-dockerfile" = "org.gnome.TextEditor.desktop";
        "text/x-xml" = "org.gnome.TextEditor.desktop";
        "text/x-php" = "org.gnome.TextEditor.desktop";
        "image/jpeg" = "imv.desktop";
        "image/jpg" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/gif" = "zen.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "text/html" = "zen.desktop";
        "inode/directory" = "thunar.desktop";
        "application/zip" = "xarchiver.desktop";
        "application/pdf" = "zathura.desktop";
        "image/png" = "imv-dir.desktop";
        "x-scheme-handler/chrome" = "zen.desktop";
        "application/x-extension-htm" = "zen.desktop";
        "application/x-extension-html" = "zen.desktop";
        "application/x-extension-shtml" = "zen.desktop";
        "application/xhtml+xml" = "zen.desktop";
        "application/x-extension-xhtml" = "zen.desktop";
        "application/x-extension-xht" = "zen.desktop";
      };
    };
  };
}

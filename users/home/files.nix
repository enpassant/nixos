{ pkgs, config, ... }:

{
  # Place Files Inside Home Directory
  # home.file.".emoji".source = ./files/emoji;
  home.file.".vimrc".source = ./files/.vimrc;
  home.file.".tmux.conf".source = ./files/.tmux.conf;
  home.file.".vim" = {
    source = ./files/.vim;
    recursive = true;
  };
  home.file.".config/tmux" = {
    source = ./files/tmux;
    recursive = true;
  };
}


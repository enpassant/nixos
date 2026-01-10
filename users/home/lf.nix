{ pkgs, config, lib, userSet, ... }:

let
 inherit (userSet) wallpaperDir screenshotDir flakeDire;
in {
  programs.lf = {
    enable = true;
    settings = {
      #preview = true;
      shell = "zsh";
      shellopts = "-euy";
      ifs = "\n";
      scrolloff = 10;
      previewer = "~/.config/lf/preview";
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
      sixel = true;
    };
    commands = {
      unarchive = ''%{{
        case "$f" in
          *.zip) unzip "$f" ;;
          *.tar.gz) tar -xzvf "$f" ;;
          *.tar.bz2) tar -xjvf "$f" ;;
          *.tar) tar -xvf "$f" ;;
          *) echo "Unsupported format" ;;
        esac
      }}'';
      mkdir = ''%{{
        set -f
        printf "Directory name: "
        read newd
        mkdir -p -- "$newd"
        mv -- $fs "$newd"
      }}'';
      mkfile = ''''${{
        printf "File name: "
        read filename
        $EDITOR $filename
      }}'';
      open = ''''$sh ~/.config/lf/opener $fx'';
      eval = ''&{{
        cmd="send $id"
        for arg; do
            cmd="$cmd $(eval "printf '%q' \"$arg\"")"
        done
        lf -remote "$cmd"
      }}'';
    };

    keybindings = {
      au = "unarchive";
      m = "";
      ms = "mark-save";
      md = "mkdir";
      mf = "mkfile";

      x = "cut";
      d = "";
      dd = "delete";

      gh = "cd";
      gc = "cd ~/.config";
      gd = ''$lf -remote "send $id cd $(xdg-user-dir DOWNLOAD)"'';
      gD = ''$lf -remote "send $id cd $(xdg-user-dir DOCUMENTS)"'';
      gm = ''$lf -remote "send $id cd $(xdg-user-dir MUSIC)"'';
      gp = ''$lf -remote "send $id cd $(xdg-user-dir PICTURES)"'';
      gv = ''$lf -remote "send $id cd $(xdg-user-dir VIDEOS)"'';
      "<enter>" = "shell";

      i = ''$LESSOPEN='| ˜/.config/lf/preview %s' less -R $f'';
      SP = ''$if test -f /tmp/text-preview; then rm /tmp/text-preview; else touch /tmp/text-preview; fi; lf -remote "send $id reload"'';
      SB = ''$~/bin/show_bg.sh $f'';
    };
  };

  home.file.".config/lf/colors".source = ./files/lf/colors;
  home.file.".config/lf/icons".source = ./files/lf/icons;
  home.file.".config/lf/preview".source = ./files/lf/preview;
  home.file.".config/lf/opener".source = ./files/lf/opener;
}

{ config, pkgs, ... }:

let
  theme = config.ricos.theme;

  toSpan = icon: color: "<span color='#${color}' size='11pt'>${icon}</span>";
in {

  home-manager.users.rico.programs.waybar.settings.bar = {
    "custom/os-icon" = {
      format = "󱄅";
      tooltip = false;
    };

    "hyprland/workspaces" = {
      format = "{id} {windows}";
      window-rewrite-default = "󰘔";
      window-rewrite = {
        alacritty = "󰆍";
        coolercontrol = "󰄪";
        firefox = "󰈹";
        spotify = "󰓇";
        "title<steam>" = "󰓓";
      };
      tooltip = false;
    };

    "hyprland/submap" = {
      format = "{}";
      tooltip = false;
    };

    "custom/playerctl-info" = {
      exec = pkgs.writeShellScript "playerctl-info" ''
        [[ $(playerctl status) == "Playing" ]] && \
          playerctl metadata -f "{{artist}} - {{title}}"
      '';
      interval = 1;
      format = "${toSpan "󰝚" theme.green} {}";
    };

    "custom/shutdowntime" = {
      exec = pkgs.writeShellScript "shutdowntime" ''
        shutdown --show 2>&1 | grep -Eo "[0-9]{2}:[0-9]{2}"
      '';
      interval = 1;
      format = "{} 󱫌";
    };

    pulseaudio = {
      format = "{volume}% ${toSpan "{icon}" theme.blue}";
      format-muted = "${toSpan "󰝟" theme.blue}";
      format-icons = [ "󰕿" "󰖀" "󰕾" ];
      tooltip = false;
    };

    disk = {
    format = "{percentage_used}% ${toSpan "󰋊" theme.blue}";
    path = "/";
      interval = 1;
      tooltip = false;
    };

    memory = {
      format = "{used}GB ${toSpan "󰘚" theme.blue}";
      interval = 1;
      tooltip = false;
      };

    cpu = {
      format = "{usage}% ${toSpan "󰍛" theme.blue}";
      interval = 1;
      tooltip = false;
    };

    "custom/gpu-info" = {
      exec = pkgs.writeShellScript "gpu-info" ''
        radeontop -b 3 -d - -l 1 | \
          grep -Eo "gpu [0-9]+\." | \
          sed -e "s/gpu //" -e "s/\./%/"
      '';
      interval = 1;
      format = "{} ${toSpan "󰾲" theme.blue}";
    };

    battery = {
      states = { low = 20; };
      format = "{capacity}% ${toSpan "{icon}" theme.blue}";
      format-low = "{capacity}% ${toSpan "󰂃" theme.red}";
      format-charging = "{capacity}% ${toSpan "󰂄" theme.green}";
      format-icons = [ "󰁼" "󰁾" "󰂀" "󰂂" ];
      interval = 1;
      tooltip = false;
    };

    clock = {
      format = "{:%H:%M}";
      tooltip-format = "{:%d/%m/%Y}";
      interval = 1;
    };
  };
}

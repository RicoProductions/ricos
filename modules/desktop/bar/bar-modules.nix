{ config, ... }:

let
  theme = config.ricos.theme;
  toSpan = icon: color: "<span color='#${color}' size='11pt'>${icon}</span>";
in {

  home-manager.users.rico.programs.waybar.settings.bar = {
    "custom/os-icon" = {
      format = "󱄅";
    };

    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        terminal = "󰆍";
        browser = "󰈹";
      };
    };

    pulseaudio = {
      format = "{volume}% ${toSpan "{icon}" theme.blue}";
      format-muted = "${toSpan "󰝟" theme.blue}";
      format-icons = [
        "󰕿"
        "󰖀"
        "󰕾"
      ];
    };

    disk = {
      format = "{percentage_used}% ${toSpan "󰋊" theme.blue}";
      path = "/";
    };

    memory = {
      format = "{used}GB ${toSpan "󰘚" theme.blue}";
      interval = 1;
    };

    cpu = {
      format = "{usage}% ${toSpan "󰍛" theme.blue}";
      interval = 1;
    };

    battery = {
      states = {
        low = 20;
      };
      format = "{capacity}% ${toSpan "{icon}" theme.blue}";
      format-low = "{capacity}% ${toSpan "󰂃" theme.red}";
      format-charging = "{capacity}% ${toSpan "󰂄" theme.green}";
      format-icons = [
        "󰁼"
        "󰁾"
        "󰂀"
        "󰂂"
      ];
      interval = 3;
    };

    clock = {
      format = " {:%T\n%d/%m/%Y}";
      interval = 1;
    };
  };
}
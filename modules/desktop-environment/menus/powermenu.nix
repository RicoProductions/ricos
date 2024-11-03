# ------------------------------------------------------------------------------
# Powermenu script
# ------------------------------------------------------------------------------
{ flags }: { config, lib, pkgs, ... }:

let
  menuOptions = lib.concatStringsSep "\n" [
    "󰤁 Poweroff"
    "󰔛 Timer"
    "󰤄 Suspend"
    "󰜉 Reboot"
    "󱑡 Reboot into firmware"
    "󰖳 Reboot into windows"
  ];

  timePresets = lib.concatStringsSep "\n" [
    "󰔟 3 minutes"
    "󰔟 10 minutes"
    "󰔟 30 minutes"
    "󰔟 1 houre"
    "󱫧 Cancel"
  ];

  powermenuScript = pkgs.writeShellScriptBin "powermenu" ''
    # Main powermenu
    function runMenu {
      selection=$(
        echo -e "${menuOptions}" | \
          bemenu -p "󰐥" ${flags}
      )

      case $selection in
        "󰤁 Poweroff")
          systemctl poweroff;;
        "󰔛 Timer")
          setTimer;;
        "󰤄 Suspend")
          systemctl suspend;;
        "󰜉 Reboot")
          systemctl reboot;;
        "󱑡 Reboot into firmware")
          systemctl reboot --firmware-setup;;
        "󰖳 Reboot inot windows")
          grub-reboot 2 && systemctl reboot;;
        *)
          ;;
      esac
    }

    # Timer preset submenu
    function setTimer {
      selection=$(
        echo -e "${timePresets}" | \
          bemenu -p "󰔛" ${flags}
      )

      case $selection in
        "󰔟 3 minutes")
          shutdown 3;;
        "󰔟 10 minutes")
          shutdown 10;;
        "󰔟 30 minutes")
          shutdown 30;;
        "󰔟 1 houre")
          shutdown 60;;
        "󱫧 Cancel")
          shutdown -c;;
        *)
          ;;
      esac
    }

    runMenu
  '';
in {

  config = lib.mkIf config.ricos.desktopEnvironment.enable {
    environment.systemPackages = [ 
      powermenuScript
    ];
  };
}

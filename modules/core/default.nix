{ hostname, lib, pkgs, username, ... }: {

  imports = [
    ./silent-boot.nix
    ./theme.nix
    ./user.nix

  ] ++ lib.optionals (hostname == "zenblade") [
    ./nvidia.nix
    ./wireless.nix

  ] ++ lib.optionals (hostname == "live-image") [
    ./wireless.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 2;
      grub = {
        enable = true;
        default = "saved";
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        splashImage = ./grub-background.png;
      };
    };
  };

  home-manager.users.${username}.home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";
  };

  services.pipewire.enable = false;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ];
}

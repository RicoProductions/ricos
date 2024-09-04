{ lib, pkgs, ... }: {

  imports = [
    ./silent-boot.nix
    ./starship.nix
    ./theme.nix
    ./user.nix
    ./zsh.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 2;
      grub = {
        enable = lib.mkDefault true;
        default = "saved";
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        splashImage = ./grub-background.png;
      };
    };
  };

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
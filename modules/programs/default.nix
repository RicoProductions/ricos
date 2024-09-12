{ hostname, lib, pkgs, ... }: {

  imports = [
    ./nvim.nix

  ] ++ lib.optionals (hostname == "silverlight") [
    ./alacritty.nix
    ./coolercontrol.nix
    ./gaming.nix
    ./image-editor.nix
    ./openrgb.nix
    ./spotify.nix
    ./virtual-machine.nix

  ] ++ lib.optionals (hostname == "zenblade") [
    ./alacritty.nix
    ./image-editor.nix
    ./spotify.nix
  ];

  environment.systemPackages = with pkgs; [
    devenv
    firefox
    gh
    git
    grub2_efi
    neofetch
    tree
  ];

  programs = {
    htop.enable = true;
  };
}

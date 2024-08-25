{ ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "silverlight";

  ricos = {
    enbaleNvidia = false;

    programs = {
      enableCoolercontrol = true;
      enableOpenrgb = true;
    };

    waybar = {
      enableVolume = false;
      enableBattery = false;
    };
  };

  system.stateVersion = "24.05";
}

{ ... }:
{
  boot = {
    # kernelParams = [ "console=tty2" ];

    loader.grub = {
      enable = true;

      useOSProber = true;
      configurationLimit = 6;

      efiSupport = true;
      efiInstallAsRemovable = true;

      device = "nodev";
      enableCryptodisk = true;
    };

    plymouth = {
      enable = true;
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];

    loader.timeout = 10;

    # Decryption password prompt
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
  };
}

{ lib, disks, ... }:
let
  mkPvs = disk: {
    name = baseNameOf disk;
    value = {
      device = disk;
      content = {
        type = "luks";
        name = "crypted-${baseNameOf disk}";
        settings = {
          keyFile = "/tmp/secret.key";
          allowDiscards = true;
        };
        content = {
          type = "lvm_pv";
          vg = "pool";
        };
      };
    };
  };
in {
  disko.devices = {
    disk = let firstDisk = builtins.head disks; in {
      "${baseNameOf firstDisk}" = {
        device = firstDisk;
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "fmask=0077" "dmask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted-${baseNameOf firstDisk}";
                settings = {
                  keyFile = "/tmp/secret.key";
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    } // builtins.listToAttrs (map mkPvs (builtins.tail disks));
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "10G";
            content = {
              type = "swap";
              randomEncryption = true;
            };
          };
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}

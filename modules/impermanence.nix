{ hm, ... }:
{
  environment.persistence."/nix/persist/system" = {
    hideMounts = true;
    
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
    
    files = [ "/etc/machine-id" ];
  };

  home.persistence."/nix/persist/home" = {
    directories = [
      ".ssh"      
      "code"
      "persist"
      "system-flake"
    ];

    files = [
      # In future, persist any file containing "history"
    ];
  };
}

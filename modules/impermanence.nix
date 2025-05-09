{ user, ... }:
{
  environment.persistence."/persist" = {
    directories = [
      "/etc/ssh"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
    files = [ "/etc/machine-id" ];
    users.${user} = {
      directories = [
        "persist"
        "dotfiles"
      ];
    };
  };
}

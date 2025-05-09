{ user, ... }:
{
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "";
  };

  services.getty.autologinUser = user;
}

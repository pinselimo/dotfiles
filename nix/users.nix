{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;
    users = {

      root.initialHashedPassword = "";

      pinselimo = {
        isNormalUser = true;
        home = "/home/pinselimo";
        description = "pinselimo";
        extraGroups = [ "wheel" "networkmanager" "video" "input" ];
        passwordFile = "/etc/passwordFile";
      };
    };
  };
}

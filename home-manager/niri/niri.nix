{ ... }: {
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  xdg.configFile."niri/scripts/startup_script.sh" = {
    source = ./scripts/startup_script.sh;
    executable = true; # This ensures the script has 'chmod +x' permissions
  };
}
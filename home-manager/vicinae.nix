{ config, pkgs, ... }:

let
  # The new official extensions repository
  extensions-src = pkgs.fetchFromGitHub {
    owner = "vicinaehq";
    repo = "extensions";
    rev = "main";
    # Use an empty hash initially to get the correct one from the error message
    hash = "sha256-LfqeVlMwclHJKsJu5jJoztjlaCeIasQsiv3P9+eKDNw=";
  };
in
{
  programs.vicinae = {
    enable = true;
    extensions = [
      # Bluetooth Extension
      (config.lib.vicinae.mkExtension {
        name = "bluetooth";
        src = "${extensions-src}/extensions/bluetooth";
      })

      # Nix Search Extension
      (config.lib.vicinae.mkExtension {
        name = "nix";
        src = "${extensions-src}/extensions/nix";
      })

      # PulseAudio Extension
      (config.lib.vicinae.mkExtension {
        name = "pulseaudio";
        src = "${extensions-src}/extensions/pulseaudio";
      })

      # AWWW Switcher (Updated path and name)
      (config.lib.vicinae.mkExtension {
        name = "awww";
        src = "${extensions-src}/extensions/awww-switcher";
      })

      # Process Manager
      (config.lib.vicinae.mkExtension {
        name = "process-manager";
        src = "${extensions-src}/extensions/process-manager";
      })
    ];
  };
}

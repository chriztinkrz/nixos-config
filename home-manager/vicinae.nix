{ config, pkgs, ... }:

let
  # Fetch the main repo once to use for multiple extensions
  vicinae-src = pkgs.fetchFromGitHub {
    owner = "vicinaehq";
    repo = "extensions";
    rev = "main";
    hash = "sha256-Dc9owWnADBcKQx0Dk0tsRICa6VHt/WsD7ew1XqwcNlc=";
  };
in
{
  programs.vicinae = {
    enable = true;
    extensions = [
      # Bluetooth Extension
      (config.lib.vicinae.mkExtension {
        name = "bluetooth";
        src = "${vicinae-src}/extensions/bluetooth";
      })

      # Nix Search Extension
      (config.lib.vicinae.mkExtension {
        name = "nix-search";
        src = "${vicinae-src}/extensions/nix-search";
      })

      # PulseAudio Extension
      (config.lib.vicinae.mkExtension {
        name = "pulseaudio";
        src = "${vicinae-src}/extensions/pulseaudio";
      })

      # AWWW Switcher (Wallpaper)
      (config.lib.vicinae.mkExtension {
        name = "awww";
        src = "${vicinae-src}/extensions/awww-switcher";
      })

      # Process Manager
      (config.lib.vicinae.mkExtension {
        name = "process-manager";
        src = "${vicinae-src}/extensions/process-manager";
      })
    ];
  };
}

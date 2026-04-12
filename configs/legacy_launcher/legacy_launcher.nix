{ pkgs }:
let
  legacyLauncher = pkgs.buildFHSEnv {
    name = "legacy-launcher";
    targetPkgs = p: with p; [
      jdk21
      jdk17
      glfw
      openal
      alsa-lib
      libjack2
      libpulseaudio
      pipewire
      libGL
      libx11
      libxcursor
      libxext
      libxrandr
      libxxf86vm
      udev
      vulkan-loader
      zlib
    ];
    runScript = "${pkgs.bash}/bin/bash ${
      pkgs.writeText "legacy-launcher-script" ''
        export XMODIFIERS="@im=null"
        java -jar -Xms256M -Xmx2048M $HOME/nixos-config/configs/legacy_launcher/LegacyLauncher.jar
      ''
    }";
  };
in [
  legacyLauncher
  (pkgs.makeDesktopItem {
    name = "legacy-launcher";
    desktopName = "Legacy Launcher";
    exec = "legacy-launcher";
    categories = [ "Game" ];
  })
]

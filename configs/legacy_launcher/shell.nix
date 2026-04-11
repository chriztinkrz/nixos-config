{ pkgs ? import <nixpkgs> {}}:
(pkgs.buildFHSEnv {
  name = "llauncher-env";
  targetPkgs = p: (with p; [
      jdk21
      jdk17
      glfw
      openal

      ## openal
      alsa-lib
      libjack2
      libpulseaudio
      pipewire

      ## glfw
      libGL
      xorg.libX11
      xorg.libXcursor
      xorg.libXext
      xorg.libXrandr
      xorg.libXxf86vm

      udev

      vulkan-loader # VulkanMod's lwjgl
  ]);

  runScript = "${pkgs.bash}/bin/bash ${
    pkgs.writeText "llauncher-env"
    ''
      export XMODIFIERS="@im=null"
      java -jar -Xms256M -Xmx2048M ./LegacyLauncher.jar
    ''
  }";
}).env

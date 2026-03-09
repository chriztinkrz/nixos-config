{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      source = "~/.config/hypr/hyprlock_colors.conf";

      general = {
        grace = 1;
        fractional_scaling = 2;
        immediate_render = false;
      };

      background = [
        {
          monitor = "";
          path = "$HOME/.cache/current_wallpaper.png";
          color = "rgb(0,0,0)";
          blur_size = 3;
          blur_passes = 2;
          noise = 0.0117;
          contrast = 1.3;
          brightness = 0.6;
          vibrancy = 0.21;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # Hours
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<b><big> $(date +'%I') </big></b>\"";
          color = "$primary";
          font_size = 112;
          font_family = "Gravitas One";
          position = "0, 220";
          halign = "center";
          valign = "center";
        }
        # Minutes
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<b><big> $(date +'%M') </big></b>\"";
          color = "$primary";
          font_size = 112;
          font_family = "Gravitas One";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        # Today (Day of week)
        {
          monitor = "";
          text = "cmd[update:18000000] echo \"<b><big> $(date +'%A') </big></b>\"";
          color = "$primary";
          font_size = 18;
          font_family = "Inter";
          position = "0, -15";
          halign = "center";
          valign = "center";
        }
        # Week (Day and Month)
        {
          monitor = "";
          text = "cmd[update:18000000] echo \"<b> $(date +'%d %b') </b>\"";
          color = "$primary";
          font_size = 14;
          font_family = "Inter";
          position = "0, -40";
          halign = "center";
          valign = "center";
        }
        # Brightness
        {
          monitor = "";
          text = "cmd[update:100] echo \" <b> ☼  $(brightnessctl -m | cut -d, -f4) </b>\"";
          color = "$primary";
          font_size = 15;
          font_family = "Inter";
          position = "0, -500";
          halign = "center";
          valign = "center";
        }
        # Volume
        {
          monitor = "";
          text = "cmd[update:100] echo \"<b>   $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%.0f%%\", $2*100}') </b>\"";
          color = "$primary";
          font_size = 15;
          font_family = "Inter";
          position = "0, -470";
          halign = "center";
          valign = "center";
        }
      ];

      "input-field" = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 0;
          dots_size = 0.28;
          dots_spacing = 0.64;
          dots_center = true;
          rounding = 20;
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "$primary";
          fade_on_empty = true;
          placeholder_text = "<i>password, bruh?</i>";
          fail_text = "<i>password, bruh?</i>";
          position = "0, 120";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
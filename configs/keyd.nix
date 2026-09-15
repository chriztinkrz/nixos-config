{ config, pkgs, ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "backspace";
            backspace = "capslock";
            rightalt = "overload(nav_layer, oneshot(custom_shift))";
            rightmeta = "overload(num_layer, rightmeta)";

            # left hand home row mods
            a = "lettermod(meta, a, 50, 175)";
            s = "lettermod(alt, s, 50, 175)";
            d = "lettermod(shift, d, 50, 175)";
            f = "lettermod(control, f, 50, 175)";

            # right hand home row mods
            j = "lettermod(control, j, 80, 175)";
            k = "lettermod(shift, k, 80, 175)";
            l = "lettermod(alt, l, 80, 175)";
            ";" = "lettermod(meta, semicolon, 80, 175)";
          };
          "custom_shift:S" = {
            tab = "clear()";
          };
          "nav_layer:C" = {
            j = "down";
            k = "up";
            l = "left";
            ";" = "right";
            i = "home";
            o = "end";
            n = "pagedown";
            p = "pageup";
            "1" = "f1";
            "2" = "f2";
            "3" = "f3";
            "4" = "f4";
            "5" = "f5";
            "6" = "f6";
            "7" = "f7";
            "8" = "f8";
            "9" = "f9";
            "0" = "f10";
            "-" = "f11";
            "=" = "f12";
            "g" = "escape";
            "d" = "enter";
          };
          "num_layer" = {
            a = "1";
            s = "2";
            d = "3";
            f = "4";
            g = "5";
            h = "6";
            j = "7";
            k = "8";
            l = "9";
            ";" = "0";
            w = "-";
            e = "=";
          };
        };
      };
    };
  };
}

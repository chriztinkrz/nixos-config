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
            "q" = "escape";
            "g" = "enter";
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
            e = "-";
            r = "=";
          };
        };
      };
    };
  };
}

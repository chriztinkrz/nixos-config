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
            leftalt = "layer(num_layer)";
            rightmeta = "overload(num_layer, rightmeta)";
            tab = "overload(func_layer, tab)";

            # left hand home row mods
            a = "lettermod(meta, a, 150, 200)";
            s = "lettermod(alt, s, 150, 200)";
            d = "lettermod(shift, d, 150, 200)";
            f = "lettermod(control, f, 150, 200)";

            # right hand home row mods
            j = "lettermod(control, j, 150, 200)";
            k = "lettermod(shift, k, 150, 200)";
            l = "lettermod(alt, l, 150, 200)";
            ";" = "lettermod(meta, semicolon, 150, 200)";
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
            "s" = "escape";
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
            "'" = "-";
            "\\" = "=";
            "q" = "!";
            "w" = "@";
            "e" = "#";
            "r" = "$";
            "t" = "%";
            "y" = "^";
            "u" = "&";
            "i" = "*";
            "o" = "(";
            "p" = ")";
            "[" = "_";
            "]" = "+";
          };

          "func_layer" = {
            q = "f1";
            w = "f2";
            e = "f3";
            r = "f4";
            t = "f5";
            y = "f6";
            u = "f7";
            i = "f8";
            o = "f9";
            p = "f10";
            "[" = "f11";
            "]" = "f12";
          };
        };
      };
    };
  };
}

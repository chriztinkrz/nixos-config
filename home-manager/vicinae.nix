{ config, pkgs, ... }:

let
  extensions-src = pkgs.fetchFromGitHub {
    owner = "vicinaehq";
    repo = "extensions";
    rev = "main";
    hash = "sha256-LfqeVlMwclHJKsJu5jJoztjlaCeIasQsiv3P9+eKDNw=";
  };

  # Use buildNpmPackage for better dependency handling
  buildVicinieExt = { name, path, npmDepsHash }: pkgs.buildNpmPackage {
    pname = "vicinae-ext-${name}";
    version = "0.1.0";

    src = "${extensions-src}/${path}";

    # This is required because the extensions don't have a lockfile in the subfolder
    # or they need to fetch remote packages during build.
    npmDepsHash = npmDepsHash;

    dontNpmBuild = false;

    installPhase = ''
      mkdir -p $out
      if [ -d ".local/share/vicinae/extensions/" ]; then
        cp -r .local/share/vicinae/extensions/*/* $out/
      else
        cp -r dist/* $out/
      fi
    '';
  };
in
{
  programs.vicinae.enable = true;

  xdg.dataFile = {
    "vicinae/extensions/bluetooth".source = buildVicinieExt {
      name = "bluetooth";
      path = "extensions/bluetooth";
      npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
    "vicinae/extensions/nix".source = buildVicinieExt {
      name = "nix";
      path = "extensions/nix";
      npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
    "vicinae/extensions/pulseaudio".source = buildVicinieExt {
      name = "pulseaudio";
      path = "extensions/pulseaudio";
      npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
    "vicinae/extensions/awww-switcher".source = buildVicinieExt {
      name = "awww";
      path = "extensions/awww-switcher";
      npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
    "vicinae/extensions/process-manager".source = buildVicinieExt {
      name = "process-manager";
      path = "extensions/process-manager";
      npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
  };
}

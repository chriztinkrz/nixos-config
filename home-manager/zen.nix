{ config, pkgs, inputs, ... }:

{

  home.username = pkgs.lib.mkDefault "chriz";
  home.homeDirectory = pkgs.lib.mkDefault "/home/${config.home.username}";
  home.stateVersion = "25.11";

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "allowed";
          allowed_types = ["extension"];
          private_browsing = true;
        };
        "@hoxx-vpn" = {
          installation_mode = "allowed";
          allowed_types = ["extension"];
          private_browsing = true;
        };
      };
    };

    profiles.${config.home.username} = {    
      id = 0;
      isDefault = true;
      
      settings = {

        # --- UI & Layout ---
        "zen.view.compact.enable-at-startup" = true;
        "zen.view.compact.show-sidebar-and-toolbar-on-hover" = false;
        "zen.tabs.show-newtab-vertical" = false;
        "zen.view.show-newtab-button-top" = false;
        "zen.urlbar.behavior" = "float";
        "zen.theme.accent-color" = "#17171a";
        "zen.theme.content-element-separation" = 0;
        "browser.zoom.fullRescale" = true;
        "toolkit.zoomManager.fallbackLocalZoom" = 133;
        "browser.zoom.siteSpecific" = false;
        "privacy.resistFingerprinting" = false;

        # --- Tab & Workspace Management ---
        "zen.workspaces.continue-where-left-off" = true;
        "zen.window-sync.sync-only-pinned-tabs" = true;
        "zen.urlbar.replace-newtab" = false;
        "zen.glance.enabled" = false;

        # --- Files & Downloads ---
        "browser.download.useDownloadDir" = false;

        # --- System & Logic ---
        "zen.welcome-screen.seen" = true;
        "zen.keyboard.shortcuts.version" = 16;
        "browser.shell.checkDefaultBrowser" = false;

      };

      keyboardShortcuts = [
        {
          id = "zen-compact-mode-toggle";
          key = "w";
          modifiers = {
            control = true;
            alt = true;
          };
        }
        {
          id = "key_quitApplication";
          disabled = true;
        }      
        {
          id = "zen-compact-mode-show-sidebar";
          key = "q";
          modifiers.control = true;
          modifiers.alt = true;
        }
        {
          id = "key_selectLastTab";
          key = "z";
          modifiers.alt = true;
        }
        {
          id = "goBackKb";
          key = "q";
          modifiers.alt = true;
        }
        {
          id = "goForwardKb";
          key = "e";
          modifiers.alt = true;
        }
        {
          id = "goHome";
          key = "x";
          modifiers.alt = true;
        }
      ];
    };
  };
}
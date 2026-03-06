{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  home.username = "chriz";
  home.homeDirectory = "/home/chriz";

  programs.zen-browser = {
    enable = true;
    suppressXdgMigrationWarning = true;

    profiles.${config.home.username} = {    
      id = 0;
      isDefault = true;
      
      settings = {
        # --- UI & Layout ---
        "zen.view.compact.enable-at-startup" = true;
        "zen.view.compact.show-sidebar-and-toolbar-on-hover" = false;
        "zen.tabs.show-newtab-vertical" = false;            # New tab button on list
        "zen.view.show-newtab-button-top" = false;          # New tab button to top
        "zen.urlbar.behavior" = "float";
        "zen.theme.accent-color" = "#17171a";
        "zen.theme.content-element-separation" = 0;
        "browser.zoom.fullRescale" = true;
        "toolkit.zoomManager.fallbackLocalZoom" = 133;
        "browser.zoom.siteSpecific" = false;

        # --- Tab & Workspace Management ---
        "zen.workspaces.continue-where-left-off" = true;
        "zen.window-sync.sync-only-pinned-tabs" = true;
        "zen.urlbar.replace-newtab" = false;
        "zen.glance.enabled" = false;

        # --- Files & Downloads ---
        "browser.download.useDownloadDir" = false;  # always ask where to save

        # --- System & Logic ---
        "zen.welcome-screen.seen" = true;
        "zen.keyboard.shortcuts.version" = 16;
        "browser.shell.checkDefaultBrowser" = false;
      };

      # --- Declarative Keyboard Shortcuts ---
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

  home.stateVersion = "25.11";

}
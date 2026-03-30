{ config, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      color.status = {
        added = "cyan bold";
        changed = "red bold";
        untracked = "magenta";
      };
      init.defaultBranch = "main";
      user.name = "chriztinkrz";
      user.email = "josechris042@gmail.com";
    };

  };
}
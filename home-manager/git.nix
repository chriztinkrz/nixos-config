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
  };
};

}
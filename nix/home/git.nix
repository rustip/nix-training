{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      fetch.prune = true;
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
    };
  };
}

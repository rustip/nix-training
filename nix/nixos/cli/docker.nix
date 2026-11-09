{ vars, ... }:
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # Lets the user run docker without sudo (root-equivalent access).
  users.extraGroups.docker.members = [ vars.username ];
}

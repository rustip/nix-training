# Terminal-only Home Manager config: safe on headless machines and the test VM.
{
  imports = [
    ./home.nix
    ./git.nix
    ./shell.nix
  ];
}

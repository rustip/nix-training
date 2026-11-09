{ pkgs, inputs, ... }:
let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages = with llm-agents; [
    claude-desktop
    chatgpt # ChatGPT + Codex desktop app
  ];
}

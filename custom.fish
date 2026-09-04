alias gst 'git status'
alias gcm 'git commit -m'
alias gp 'git push'
alias gfm 'git pull'
alias gia 'git add .'
alias gcb 'git checkout -b'
alias gcan 'git commit --amend --no-edit'
alias nrs 'sudo nixos-rebuild switch --flake path:.#'
alias zed 'zeditor'
alias fps 'flatpak search'
alias fpr 'flatpak run'
alias fpi 'flatpak install -y --user flathub'

if type -q eza
    alias l 'eza --icons=auto'
    alias ll 'eza -l --icons=auto'
    alias la 'eza -la --icons=auto'
    alias lt 'eza --tree --icons=auto'
end

if type -q starship
    starship init fish | source
end

if type -q carapace
    carapace _carapace | source
end

if type -q atuin
    atuin init fish | source
end

if type -q fzf
    fzf --fish | source
end

if type -q zoxide
    zoxide init fish | source
end

if type -q direnv
    direnv hook fish | source
end

fish_add_path -g $HOME/.local/bin $HOME/.opencode/bin $HOME/.codex/bin $HOME/.nix-config/scripts

{ ... }:

let
  # Shell aliases
  aliases = {
    ll = "ls -laF";
    la = "ls -al";
    l = "ls -CF";
    ldot = "ls -ld .*";

    ".." = "cd ..";
    "~" = "cd ~";

    sudo = "sudo ";

    pokemon = "pokemon-colorscripts -r -b";
  };
in
{
  # Let Home Manager handle Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = aliases;
    initExtra = ''
    source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
    export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \[\033[01;91m\]$(__git_ps1 "(%s)")\n\[\033[38;5;208m\]\$\[\033[00m\] '
    '';
  };
}
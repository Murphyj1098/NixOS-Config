{ ... }:

{
  programs.nano = {
    enable = true;
    nanorc = ''
      set linenumbers
      set autoindent
      set locking
      set tabsize 2
      set tabstospaces
      set breaklonglines
      '';
    syntaxHighlight = true;
  };
}
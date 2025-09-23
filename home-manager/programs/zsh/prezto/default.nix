{
  enable = true;
  prompt.theme = "pure";
  terminal.autoTitle = false;
  pmodules = [
    "completion" # slow, not needed (but seems to fix "command not found: compdef")?
    #"directory"
    #"editor"
    #"environment"
    ##"git"
    ##"history"
    #"prompt"
    "syntax-highlighting"
    "spectrum"
    #"terminal"
    #"utility"
  ];
}

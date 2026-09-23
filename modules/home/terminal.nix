{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.ghostty = {
    enable = true;
  };

  programs.zellij = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    flags = [ "--disable-ctrl-r" ];
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "com.mitchellh.ghostty.desktop" ];
    };
  };
}

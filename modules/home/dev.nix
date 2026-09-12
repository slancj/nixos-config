{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    enableBashIntegration = true;

    enableFishIntegration = true;
  };

  programs.vscode = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "TrueKing";
      email = "samuellance73@gmail.com";
    };
  };

  home.packages = with pkgs; [
    nixd
    github-cli
    neovim
    fd
    lazygit
    just
    tree-sitter
    luarocks
    python3
    uv
    gost
    nodejs_24
    bun
    rustc
    cargo
    godot_4
    git-lfs
  ];
}

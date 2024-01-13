{ pkgs }:
{
  enable = true;
  viAlias = false;
  vimAlias = true;
  defaultEditor = true;
  extraConfig = builtins.readFile (./extraConfig.vim);
  plugins = import ./plugins { inherit (pkgs) vimPlugins; };
}

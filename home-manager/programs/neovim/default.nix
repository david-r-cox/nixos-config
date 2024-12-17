{ pkgs }:
{
  enable = true;
  viAlias = false;
  vimAlias = true;
  defaultEditor = true;
  extraConfig = builtins.readFile (./extraConfig.vim);
  #extraLuaConfig = builtins.readFile (./extraLuaConfig.lua);
  plugins = import ./plugins { inherit (pkgs) vimPlugins; };
  coc.settings = {
    suggest = {
      noselect = true;
      enablePreview = true;
      enablePreselect = true;
      disableKind = true;
    };
    languageserver = {
      haskell = {
        command = "haskell-language-server-wrapper";
        args = [ "--lsp" ];
        rootPatterns = [
          "*.cabal"
          "stack.yaml"
          "cabal.project"
          "package.yaml"
          "hie.yaml"
        ];
        filetypes = [ "haskell" "lhaskell" ];
        settings = {
          haskell = {
            checkParents = "CheckOnSave";
            checkProject = true;
            maxCompletions = 40;
            formattingProvider = "ormolu";
            plugin = {
              stan = {
                globalOn = true;
              };
            };
          };
        };
      };
      nixd = {
        command = "nixd";
        rootPatterns = [ ".nixd.json" ];
        filetypes = [ "nix" ];
      };
      rust = {
        command = "rust-analyzer";
        filetypes = [ "rust" ];
        rootPatterns = [ "Cargo.toml" ];
      };
    };
    clangd.inlayHints.enable = true;
    clangd.fallbackFlags = [ "-std=c++20" ];
    semanticTokens.enable = true;
  };
}

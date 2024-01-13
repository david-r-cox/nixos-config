{
  "nvim/coc-settings.json".text = builtins.toJSON {
    "languageserver" = {
      "nixd" = {
        "command" = "nixd";
        "rootPatterns" = [ ".nixd.json" ];
        "filetypes" = [ "nix" ];
      };
      "haskell" = {
        "command" = "haskell-language-server-wrapper";
        "args" = [ "--lsp" ];
        "rootPatterns" = [
          "*.cabal"
          "stack.yaml"
          "cabal.project"
          "package.yaml"
          "hie.yaml"
        ];
        "filetypes" = [ "haskell" "lhaskell" ];
        "settings" = {
          "haskell" = {
            "checkParents" = "CheckOnSave";
            "checkProject" = true;
            "maxCompletions" = 40;
            "formattingProvider" = "ormolu";
            "plugin" = {
              "stan" = { "globalOn" = true; };
            };
          };
        };
      };

    };
    "clangd.fallbackFlags" = [ "-std=c++20" ];
    "clangd.inlayHints.enable" = false; # TODO: Not applying?
    "semanticTokens.enable" = true;
  };
}

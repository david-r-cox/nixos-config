{ pkgs }:
let
  local = "~/src/github.com/david-r-cox";
  remote = "git+ssh://git@github.com/david-r-cox/nixos-config";
  privateConfigPath = local + "/private-nixos-config";
  publicConfigPath = local + "/nixos-config";
  buildOptions = "--cores 48 --builders 12";
in
{
  enable = true;
  autocd = true;
  shellAliases = {
    cb = "cargo build";
    cdf = "cd $(dirname $(fzf))";
    clippy = "cargo clippy";
    cr = "cargo run";
    ct = "cargo test";
    ga = "git add";
    gc = "git commit";
    gd = "git diff";
    gl = "git log --all --decorate --oneline --graph --stat";
    gp = "git push";
    gs = "git status";
    hme = "vim ${publicConfigPath}/home-manager/home.nix";
    hmm = "man 5 home-configuration.nix";
    hms = "home-manager switch --flake ${publicConfigPath} " + buildOptions;
    hmsr = "home-manager switch --flake ${remote} " + buildOptions;
    ls = "lsd";
    lst = "lsd --tree";
    nb = "nom build " + buildOptions;
    nd = "nom develop " + buildOptions + " --command zsh";
    nr = "nix run";
    ns = "nix-search";
    nsn = "nix search nixpkgs";
    nxe = "vim ${privateConfigPath}/nixos/configuration.nix";
    nxs = "sudo nixos-rebuild switch --flake ${privateConfigPath} --verbose";
    nxsr = "sudo nixos-rebuild switch --flake ${remote} --verbose";
    pbcopy = "xsel --clipboard --input";
    pbpaste = "xsel --clipboard --output";
    vimf = "nvim $(fzf)";
    vim = "neovide";
    # Compute the nix hash.
    # Usage: nix-repo-hash https://github.com/cli/cli v2.20.2
    # Returns: sha256-atUC6vb/tOO2GapMjTqFi4qjDAdSf2F8v3gZuzyt+9Q=
    nix-repo-hash = "sh -c '" +
      "nix-shell -p nix-prefetch-git jq --run " +
      "\"nix hash to-sri sha256:\\$(nix-prefetch-git --url \\\"$1\\\" " +
      "--quiet --rev \\\"$2\\\" | jq -r '.sha256')\"' _";
    sign-store = "nix store sign --key-file /var/cache-priv-key.pem --all";
  };
  plugins = [
    {
      name = "wd";
      src = pkgs.fetchFromGitHub {
        owner = "mfaerevaag";
        repo = "wd";
        rev = "v0.5.2";
        sha256 = "4yJ1qhqhNULbQmt6Z9G22gURfDLe30uV1ascbzqgdhg=";
      };
    }
  ];
  history = {
    expireDuplicatesFirst = true;
    save = 100000000;
    size = 1000000000;
  };
  initExtra = ''
    setopt EXTENDED_GLOB
    # escape # for nix flakes
    setopt NO_NOMATCH
    export SHELL=$(which zsh)
    preexec() { print -Pn "\e]0;$1 %~\a" }
  '';
  prezto = import ./prezto;
}

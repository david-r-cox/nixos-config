{ lib }:

{
  types = import ./types.nix { inherit lib; };
  utils = import ./utils.nix { inherit lib; };
  options = import ./options.nix { inherit lib; };
  meta = import ./meta.nix { inherit lib; };
}

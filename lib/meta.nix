{ lib }:

{
  # Module metadata helpers
  mkModuleMeta = { maintainers, doc ? null }: {
    inherit maintainers;
    inherit (lib.meta) platforms;
  } // lib.optionalAttrs (doc != null) { inherit doc; };

  # Documentation helpers
  mkDoc = { name, description, example ? null, notes ? [], warnings ? [] }:
    let
      formatList = list: lib.concatMapStrings (s: "- ${s}\n") list;
      hasExample = example != null;
      hasNotes = notes != [];
      hasWarnings = warnings != [];
    in ''
      # ${name}

      ${description}

      ${lib.optionalString hasWarnings ''
        ## ⚠️ Warnings

      ${formatList warnings}
      ''}

      ${lib.optionalString hasExample ''
        ## Example

      ```nix
      ${example}
      ```
      ''}

      ${lib.optionalString hasNotes ''
        ## Notes

      ${formatList notes}
      ''}
    '';
}

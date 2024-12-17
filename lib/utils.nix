{ lib }:

rec {
  # String manipulation
  camelToKebab = string:
    let
      chars = lib.stringToCharacters string;
      
      process = char: prev:
        let
          isUpper = c: lib.elem c (lib.stringToCharacters "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
          shouldAddHyphen = isUpper char && prev != "-" && prev != "";
        in
        (if shouldAddHyphen then "-" else "") + (lib.toLower char);
    in
    lib.foldl (str: char: str + process char str) "" chars;

  kebabToCamel = string:
    let
      parts = lib.splitString "-" string;
      capitalized = map lib.capitalizeString (lib.tail parts);
    in
    (lib.head parts) + lib.concatStrings capitalized;

  # List manipulation
  uniqueBy = comp: list:
    lib.foldl
      (acc: x:
        if lib.any (y: comp x y) acc
        then acc
        else acc ++ [x])
      []
      list;

  # Attribute set manipulation
  recursiveMergeAttrs = sets:
    lib.foldl
      (acc: set:
        lib.recursiveUpdate acc set)
      {}
      sets;

  # Path manipulation
  relativeToAbsolute = base: path:
    if lib.hasPrefix "/" path
    then path
    else base + "/${path}";

  # Version comparison
  versionAtLeast = v1: v2:
    let
      parse = v: map lib.toInt (lib.splitString "." v);
      padZeros = l: l ++ lib.genList (_: 0) (3 - lib.length l);
      ver1 = padZeros (parse v1);
      ver2 = padZeros (parse v2);
    in
    ver1 >= ver2;

  # Object transformation
  mapAttrsRec = f: set:
    lib.mapAttrs
      (name: value:
        if lib.isAttrs value && !lib.isDerivation value
        then mapAttrsRec f value
        else f name value)
      set;

  # Functional helpers
  pipe = initial: functions:
    lib.foldl (x: f: f x) initial functions;

  whenTrue = condition: value:
    if condition then value else {};
}

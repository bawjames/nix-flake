with lib; rec {
  files = builtins.readDir ./.;
  isDir = files attrsets.filterAttrs (_: type:  type == "directory") files;
  isNix = str: strings.hasSuffix ".nix" str;
  paths = str: ./. + str;
  exclude = [ ./configuration.nix ];
  notExcluded = path: lists.elem path exclude;
}

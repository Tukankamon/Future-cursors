{
  description = "Future Cursors flake (source & binary variants)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system} = {
      # 1. Build from source
      future-cursors-source = import ./nixpkgs/sourcePackage.nix {
        inherit self;
        inherit (pkgs) lib stdenvNoCC inkscape xcursorgen coreutils;
        cursorColor = "cyan";
      };

      # 2. Prebuilt binaries (much faster and less dependencies)
      future-cursors = import ./nixpkgs/binPackage.nix {
        inherit self;
        inherit (pkgs) lib stdenvNoCC;
        inherit cursorColor; # Allows for overrides
      };

      # 3. Default package set to prebuilt binaries
      default = self.packages.${system}.future-cursors;
    };
  };
}


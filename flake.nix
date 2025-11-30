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
      source = pkgs.callPackage ./nixpkgs/sourcePackage.nix {
        inherit self;
      };

      # 3. Default package set to prebuilt binaries
      default = pkgs.callPackage ./nixpkgs/binPackage.nix {
        inherit self;
      };
    };
  };
}


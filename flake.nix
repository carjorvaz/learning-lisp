# Enter the dev shell with: nix develop

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [ rlwrap sbcl lispPackages.quicklisp ];
          shellHook = ''
              export LD_LIBRARY_PATH=${
                pkgs.lib.makeLibraryPath ([ pkgs.openssl ])
              }:${pkgs.lib.makeLibraryPath ([ pkgs.sqlite ])}
            # '';
        };
      });
}

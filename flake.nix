{
  description = "Authenticator for JLU.WIFI";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {

    packages."x86_64-linux".jlu-drcom-client = pkgs.callPackage ./jlu-drcom-client {};
    packages."x86_64-linux".default = self.packages."x86_64-linux".jlu-drcom-client;

  };
}

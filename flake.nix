rec {
  description = "Authenticator for JLU.WIFI";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {

    # packages."x86_64-linux".jlu-drcom-client = pkgs.callPackage ./jlu-drcom-client.nix {
    #   # username = "username";
    #   passwd = "passwd";
    #   ipAddr = "ip";
    #   macAddr = "mac";
    #   hostname = "mochi-melody";
    # };
    # packages."x86_64-linux".default = self.packages."x86_64-linux".jlu-drcom-client;
    nixosModules.jlu-drcom-client = { lib, pkgs, config, ... }:
    with lib;
    let
      cfg = config.services.jlu-drcom-client;
    in {
      options.services.jlu-drcom-client = {
        enable = mkEnableOption "Authenticator for JLU.WIFI";
        username = mkOption {
          type = types.str;
        };
        passwd = mkOption {
          type = types.str;
        };
        macAddr = mkOption {
          type = types.str;
        };
        ipAddr = mkOption {
          type = types.str;
        };
        user = mkOption {
          type = types.str;
        };
      };
      config = mkIf cfg.enable {
        
        systemd.services.jlu-drcom-client =
        let
          authpkg = pkgs.callPackage ./jlu-drcom-client.nix {
            inherit (cfg) username passwd macAddr ipAddr;
            hostname = config.networking.hostName;
          };
        in {
          after = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];
          description = "Authenticator for JLU.WIFI";
          serviceConfig = {
            Type = "simple";
            User = cfg.user;
            ExecStart = "${authpkg}/bin/jlu-drcom-client";
            Restart = "on-failure";
            RestartSec = 5;
          };
        };
      };
    };
  };
}

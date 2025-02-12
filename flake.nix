{
  description = "Nexus File Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      # importing package example
      # packages."x86_64-linux".default =
      #   pkgs.callPackage (import ./default.nix) {};

      devShells."x86_64-linux".default = pkgs.mkShell {

        packages = with pkgs; [
          nodejs_18
          wails
          go
          webkitgtk_4_0
          gtk3
          glib
          glib-networking
          gobject-introspection
          pkg-config
        ];

        shellHook = ''
          export LD_LIBRARY_PATH=${pkgs.webkitgtk_4_0}/lib:$LD_LIBRARY_PATH
          export GDK_BACKEND=x11  # If you're on Wayland, force X11
        '';

      };
    };
}

{
  description = "Development environments with devshells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells = {
          python-data-science = pkgs.mkShell {
            packages = with pkgs; [
              python3
              python3Packages.numpy
              python3Packages.pandas
              python3Packages.matplotlib
              python3Packages.scipy
              python3Packages.beautifulsoup4
              python3Packages.lxml
              python3Packages.selenium
              python3Packages.requests
            ];
          };

          python-fasthtml = pkgs.mkShell {
            packages = with pkgs; [
              python3
              # Assuming FastHTML is available via pip, you might need pip to install it
              python3Packages.pip
            ];

            shellHook = ''
              pip install python-fasthtml
            '';
          };

          typescript-devops = pkgs.mkShell {
            packages = with pkgs; [
              nodejs
              yarn
              terraform
              cdktf
              cdk8s
            ];
          };
        };
      });
}

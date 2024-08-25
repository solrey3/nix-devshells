{
  description = "Nix Flake for cross-platform devshells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));
    in
    {
      devShells = forAllSystems (pkgs: {
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
            # terraform
            nodePackages.cdktf-cli
            nodePackages.cdk8s-cli
          ];
        };

        github-pages = pkgs.mkShell {
          packages = with pkgs; [
            ruby
            bundler
            jekyll
          ];

          shellHook = ''
            bundle install
          '';
        };

        kali-linux = pkgs.mkShell {
          packages = with pkgs; [
            nmap
            wireshark
            john
            aircrack-ng
            # hydra
            sqlmap
            metasploit
            nikto
            gobuster
            hashcat
            # Add more tools as needed
          ];

          shellHook = ''
            echo "Kali Linux environment activated"
          '';
        };
      });
    };
}

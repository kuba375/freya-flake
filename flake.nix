{
  description = "A very basic Freya development flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: 
  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."${system}";
    libPath = with pkgs; lib.makeLibraryPath [
      libGL
      libxkbcommon
      wayland
    ];
  in
  {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [];
      
      buildInputs = with pkgs; [
        gtk3
        cmake
        clang
        openssl
        xdotool
        cargo
        rustc
        rust-analyzer
        # dioxus-cli
      ];
      
      nativeBuildInputs = with pkgs; [
        pkg-config
        makeWrapper
        libxkbcommon
        libGL
        wayland
      ];
      
      shellHook = ''
        echo "entering flake ..."
        # exec nu   # feel free to change this
      '';

      LD_LIBRARY_PATH = libPath;
    };
  };
}

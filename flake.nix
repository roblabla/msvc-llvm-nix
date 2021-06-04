{
    description = "MSVC stuff";

    inputs.flake-utils.url = "github:numtide/flake-utils";
    outputs = { self, flake-utils }: {
        overlay = self: super: {
            msvc-wine = ./msvc-wine.nix;
            fetch-msvc = ./fetch-msvc.nix;
            msvc-toolchain = ./msvc-toolchain.nix;
        };
    };
}
{
    description = "MSVC stuff";

    outputs = { self }: {
        overlay = self: super: {
            msvc-wine = super.callPackage (import ./msvc-wine.nix) {};
            fetch-msvc = super.callPackage (import ./fetch-msvc.nix) {};
            msvc-toolchain = super.callPackage (import ./msvc-toolchain.nix) {};
        };
    };
}
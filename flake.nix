{
    description = "MSVC stuff";

    outputs = { self }: {
        overlay = final: prev: {
            msvc-wine = final.callPackage ./msvc-wine.nix {};
            fetch-msvc = final.callPackage ./fetch-msvc.nix {};
            msvc-src = final.fetch-msvc {
                manifest = ./16.8.4.manifest;
                sha256 = "0lb00sc1rwqbnnyc9nfrdk451p5rspx099lj9hfbcq2jxjq8vvv0";
            };
            msvc-toolchain = final.callPackage ./msvc-toolchain.nix {};
        };
    };
}
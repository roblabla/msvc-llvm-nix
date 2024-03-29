{ lib, stdenvNoCC, fetchgit, python3Packages, writeScript, msitools, perl, llvmPackages, msvc-wine, msvc-src }:
let
    CLANG_HDR_VER = if lib.toIntBase10 (lib.versions.major (lib.getVersion llvmPackages.clang)) < 16 then
        (lib.getVersion llvmPackages.clang)
    else
        (lib.versions.major (lib.getVersion llvmPackages.clang));
in
stdenvNoCC.mkDerivation {
    name = "msvc-toolchain";
    buildInputs = [
        msitools
        msvc-wine
        python3Packages.python
        python3Packages.simplejson
        python3Packages.six
    ];

    srcs = [
        msvc-src
    ];

    builder = writeScript "build.sh" ''
        #! ${stdenvNoCC.shell}
        source $stdenv/setup

        tar xf ${msvc-src}

        python ${msvc-wine}/bin/vsdownload.py --accept-license --manifest cache/___manifest___.json --cache cache --dest $out
        ${msvc-wine}/bin/install.sh $out

        # Patch the generated paths.
        sed -i -e "s#CLANG_PATH=.*#CLANG_PATH=${llvmPackages.clang-unwrapped}/bin/clang#" $out/bin/*/clang-cl
        sed -i -e "s#LLD_PATH=.*#LLD_PATH=${llvmPackages.lld}/bin/lld#" $out/bin/*/lld-link
        sed -i -e "s#LLVM_RC=.*#LLVM_RC=${llvmPackages.llvm}/bin/llvm-rc#" $out/bin/*/llvm-rc
        sed -i -e "s#PRE_EXTRA_ARGS=.*#PRE_EXTRA_ARGS='/imsvc ${lib.getLib llvmPackages.libclang}/lib/clang/${CLANG_HDR_VER}/include'#" $out/bin/*/clang-cl
    '';
}

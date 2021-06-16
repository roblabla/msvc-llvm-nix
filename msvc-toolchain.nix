{ lib, stdenvNoCC, fetchgit, python38, python38Packages, writeScript, msitools, perl, llvmPackages, msvc-wine, msvc-src }:
stdenvNoCC.mkDerivation {
    name = "msvc-toolchain";
    buildInputs = [
        msitools
        msvc-wine
        python38
        python38Packages.simplejson
        python38Packages.six
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
        sed -i -e "s#EXTRA_ARGS=.*#EXTRA_ARGS='/imsvc ${lib.getLib llvmPackages.libclang}/lib/clang/${lib.getVersion llvmPackages.clang}/include'#" $out/bin/*/clang-cl
    '';
}
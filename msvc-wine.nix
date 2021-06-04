{ stdenvNoCC, python38, python38Packages, perl, fetchgit }:
stdenvNoCC.mkDerivation {
    name = "msvc-wine";

    src = fetchgit {
        url = "https://github.com/roblabla/msvc-wine";
        rev = "aa884f036bb30466ed98ee70fe1194647c8a213e";
        sha256 = "12n095k1adj491fh3n4v1q1ry7g94r4rjm7cwg77jzfivbaa9yzh";
    };

    buildInputs = [
        python38
        python38Packages.simplejson
        python38Packages.six
        perl
    ];

    buildPhase = "";

    installPhase = ''
        mkdir -p $out/bin
        cp -v vsdownload.py $out/bin
        cp -v install.sh $out/bin
        cp -v fixinclude $out/bin
        cp -vr wrappers $out/bin
    '';
}
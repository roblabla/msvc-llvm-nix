{ stdenvNoCC, python38, python38Packages, perl, fetchgit }:
stdenvNoCC.mkDerivation {
    name = "msvc-wine";

    src = fetchgit {
        url = "https://github.com/roblabla/msvc-wine";
        rev = "67700eb9f10109ea877c2d012a4fc025623e4fb8";
        sha256 = "1bqvyijghx4isqxhjjhn476s8d7v5z4a08shrxbmm5xbyjgi8zy3";
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
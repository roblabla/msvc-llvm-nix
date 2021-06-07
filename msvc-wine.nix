{ stdenvNoCC, python38, python38Packages, perl, fetchgit }:
stdenvNoCC.mkDerivation {
    name = "msvc-wine";

    src = fetchgit {
        url = "https://github.com/roblabla/msvc-wine";
        rev = "35fc0a1650c3d9ebc37a66fcc904f87bbaab9259";
        sha256 = "0nf89kwr1l1ja1kw0hz38pd7gv8xfxcr57y6lxfqrjw7dy8pnz7d";
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
{ stdenvNoCC, python38, python38Packages, perl, fetchgit }:
stdenvNoCC.mkDerivation {
    name = "msvc-wine";

    src = fetchgit {
        url = "https://github.com/roblabla/msvc-wine";
        rev = "ecccf184d5f79abcd554b5fc8b9b10229edf0ce6";
        sha256 = "05ywg6pmnbjmg0sxlgrdhmrsqgzqcspyd6ldpw8qj1c4yws98v1f";
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
{ stdenvNoCC, python38, python38Packages, perl, fetchgit }:
stdenvNoCC.mkDerivation {
    name = "msvc-wine";

    src = fetchgit {
        url = "https://github.com/roblabla/msvc-wine";
        rev = "612a40288cf893760e63f8de1bb449bb4690df94";
        sha256 = "sha256-xVlp/8BHXJLROXqnF0WgrWOjnAEZTD+e4EtkfFQExYA=";
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

{ stdenvNoCC, python38, python38Packages, perl, fetchgit }:
stdenvNoCC.mkDerivation {
    name = "msvc-wine";

    src = fetchgit {
        url = "https://github.com/roblabla/msvc-wine";
        rev = "1ba89100f0cba2907f35c37a3bbe62a913ff7ba7";
        sha256 = "0qryc9blrh2g9h9h47fhwq63cfcwpa1lixba8b48q1f4pdxahvsp";
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
        cp -vr wrappers $out/bin
    '';
}
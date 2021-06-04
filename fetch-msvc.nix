{ stdenvNoCC, fetchgit, python38, python38Packages, openssl, writeScript, curl, cacert, msvc-wine }:
{ manifest, outputHash ? "" }:
stdenvNoCC.mkDerivation {
    name = "src";

    inherit outputHash;

    nativeBuildInputs = [ curl cacert openssl python38 python38Packages.simplejson python38Packages.six ];

    builder = writeScript "build.sh" ''
        #! ${stdenvNoCC.shell}
        source $stdenv/setup

        curl -O https://raw.githubusercontent.com/roblabla/msvc-wine/master/vsdownload.py

        echo $SSL_CERT_FILE

        mkdir -p cache
        python vsdownload.py --accept-license --manifest ${manifest} --cache cache --only-download

        tar --sort=name --mtime="@$SOURCE_DATE_EPOCH" --owner=0 --group=0 --numeric-owner -cf $out cache
    '';

    MANIFEST = manifest;
    SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
}
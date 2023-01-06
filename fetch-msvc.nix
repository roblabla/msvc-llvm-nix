{ lib, stdenvNoCC, fetchgit, python38, python38Packages, openssl, writeScript, curl, cacert, msvc-wine }:
{
  manifest

, # SRI hash.
  hash ? ""

, # Legacy ways of specifying the hash.
  outputHash ? ""
, outputHashAlgo ? ""
, md5 ? ""
, sha1 ? ""
, sha256 ? ""
, sha512 ? "" }:

let
  hash_ =
    if hash != "" then { outputHashAlgo = null; outputHash = hash; }
    else if md5 != "" then throw "fetchurl does not support md5 anymore, please use sha256 or sha512"
    else if (outputHash != "" && outputHashAlgo != "") then { inherit outputHashAlgo outputHash; }
    else if sha512 != "" then { outputHashAlgo = "sha512"; outputHash = sha512; }
    else if sha256 != "" then { outputHashAlgo = "sha256"; outputHash = sha256; }
    else if sha1   != "" then { outputHashAlgo = "sha1";   outputHash = sha1; }
    else if cacert != null then { outputHashAlgo = "sha256"; outputHash = ""; }
    else throw "fetch-msvc requires a hash for fixed-output derivation.";
in
stdenvNoCC.mkDerivation {
    name = "src";

    inherit (hash_) outputHash outputHashAlgo;

    nativeBuildInputs = [ curl cacert openssl python38 python38Packages.simplejson python38Packages.six ];

    builder = writeScript "build.sh" ''
        #! ${stdenvNoCC.shell}
        source $stdenv/setup

        curl -O https://raw.githubusercontent.com/roblabla/msvc-wine/master/vsdownload.py

        echo $SSL_CERT_FILE

        mkdir -p cache
        python vsdownload.py --accept-license --manifest ${manifest} --cache cache --only-download
        cp ${manifest} cache/___manifest___.json

        tar --sort=name --mtime="@$SOURCE_DATE_EPOCH" --owner=0 --group=0 --numeric-owner -cf $out cache
    '';

    preferLocalBuild = true;

    MANIFEST = manifest;
    SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
}

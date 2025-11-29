# Just the package as it might be in nixpkgs. The flake is the one that allows you to download
# This version just downloads pre-compiled binaries, much faster than the other
{
    lib,
    stdenvNoCC,
    cursorColor ? "cyan",
    self
}:
stdenvNoCC.mkDerivation {
    pname = "future-cursors";
    version = "2025-11-29";

    src = self;

    installPhase = ''
        runHook preInstall

        install -dm 755 $out/share/icons/future-cursors
        cp -r dist/${cursorColor}/* $out/share/icons/future-cursors

        runHook postInstall
    '';

    meta = {
        description = "X-cursor theme inspired by macOS and based on capitaine-cursors. Options are yellow, cyan, dark (grey) or fully black";
        homepage = "https://github.com/Tukankamon/Future-cursors";
        license = lib.licenses.gpl3Only;
        platforms = lib.platforms.linux;
    };
}

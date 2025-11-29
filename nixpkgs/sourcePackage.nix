# Just the package as it might be in nixpkgs. The flake is the one that allows you to download
# It builds the xcursor from source so it needs more dependencies (mainly inkscape) and will take longer
{
    lib,
    stdenvNoCC,
    inkscape,
    xcursorgen,
    coreutils,
    cursorColor ? "cyan",
    self
}:
stdenvNoCC.mkDerivation {
    pname = "future-cursors";
    version = "2025-11-29";

    src = self;

    # Inkscape might take a while to do its thing and throw scary errors but it should be fine
    buildInputs = [ inkscape xcursorgen coreutils ];

    buildPhase = ''
        patchShebangs ./build.sh
        chmod +x build.sh
        ./build.sh svg-${cursorColor}
    '';

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

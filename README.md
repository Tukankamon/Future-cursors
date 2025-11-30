# Future cursors
This is an x-cursor theme inspired by macOS and
based on [capitaine-cursors](https://github.com/keeferrourke/capitaine-cursors).

## Installation
To install the cursor theme simply copy the compiled theme to your icons
directory. For local user installation:

```
./install.sh $COLOR
```

For system-wide installation for all users:

```
sudo ./install.sh $COLOR
```

Then set the theme with your preferred desktop tools.

## NixOS
Add this to your flake:
```nix
futureCursors = {
  url = "github:Tukankamon/Future-cursors";
  inputs.nixpkgs.follows = "nixpkgs";
};
```
Then as long as you pass Home-Manager (or normal NixOS modules) in the outputs you can do:

```nix
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package =
      inputs.futureCursors.packages."x86_64-linux".default.override
      {
        cursorColor = "yellow";
      };
    name = "future-cursors";
  };
```
Leaving cursorColor empty will default to "cyan"

The flake exposes two packages. One that builds from source and the other that uses prebuilt xcursor binaries (default)
You can choose to build from source by choosing

```nix 
inputs.futureCursors.packages."x86_64-linux".source
```


## Building from source
You'll find everything you need to build and modify this cursor set in
the `src/` directory. To build the xcursor theme from the SVG source
run:

```
./build.sh
```

This will generate the pixmaps and appropriate aliases.
The freshly compiled cursor theme will be located in `dist/`

## Preview
![Future](images/preview.png)
![Future](images/preview-1.png)

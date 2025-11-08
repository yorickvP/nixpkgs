# Using Fil-C Cross-Compilation in Nixpkgs

## What was added

1. **`lib/systems/parse.nix`** - Added `filc` ABI definition
2. **`lib/systems/examples.nix`** - Added `filc` system example

## Usage

The Fil-C cross-compilation target is recognized via the system triple `x86_64-unknown-linux-gnufilc0`.
To use it, you need to provide a custom stdenv via `config.replaceCrossStdenv`:

```nix
{
  nixpkgs = import <nixpkgs> {
    localSystem = "x86_64-linux";
    crossSystem = { config = "x86_64-unknown-linux-gnufilc0"; };
    config.replaceCrossStdenv = { buildPackages, baseStdenv }:
      baseStdenv.override { cc = filcc; };  # filcc from filnix
  };
}
```

## Current limitation

The Fil-C compiler is not yet packaged in nixpkgs. For now, you need to:
- Use filnix as a flake input to get the Fil-C toolchain
- Pass the filenv stdenv via `config.replaceCrossStdenv`

The cross-compilation target is recognized, but you must provide the Fil-C stdenv externally.

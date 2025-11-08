# Fil-C Cross-Compilation Support for Nixpkgs

This adds Fil-C (memory-safe C/C++) as a cross-compilation target for nixpkgs.

## Approach

Fil-C is treated as a new ABI variant, similar to `musl` or `gnueabi`. The system triple is `x86_64-unknown-linux-gnufilc0`.

## Implementation Files

1. `lib/systems/examples.nix` - Add Fil-C system example
2. `lib/systems/parse.nix` - Recognize `filc` ABI

## Usage

The system triple `x86_64-unknown-linux-gnufilc0` is recognized. To use it, provide a custom stdenv:

```nix
# In your flake or shell
{
  nixpkgs = import <nixpkgs> {
    crossSystem = { config = "x86_64-unknown-linux-gnufilc0"; };
    config.replaceCrossStdenv = { buildPackages, baseStdenv }:
      baseStdenv.override { cc = filcc; };  # from filnix
  };
}
```

This will rebuild all dependencies with memory safety!

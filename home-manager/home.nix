# Backward-compatible entrypoint; use ./default.nix (flake homeConfigurations import ./home-manager).
{
  ...
} @ args:
import ./default.nix args

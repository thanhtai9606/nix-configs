# Flutter (nixpkgs) + Android Studio (SDK/platforms via Studio, not nix androidenv).
{pkgs, ...}: {
  home.packages = with pkgs; [
    flutter
    android-studio
  ];

  home.sessionVariables = {
    # Default after Android Studio first-run / SDK install.
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    PUB_CACHE = "$HOME/.pub-cache";
  };
}

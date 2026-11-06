# Flutter (nixpkgs) + Android Studio (SDK/platforms via Studio, not nix androidenv).
{pkgs, ...}: {
  home.packages = with pkgs; [
    flutter
    android-studio
    jdk17
    # Faunex mobile Linux desktop (flutter_secure_storage → libsecret)
    libsecret
    gtk3
    pkg-config
  ];

  home.sessionVariables = {
    # Gradle / Android build (flutter build apk, ./gradlew signingReport).
    JAVA_HOME = "${pkgs.jdk17.home}";
    # Default after Android Studio first-run / SDK install.
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
    PUB_CACHE = "$HOME/.pub-cache";
  };
}

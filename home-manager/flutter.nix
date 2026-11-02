# Flutter via FVM (pin per project / global) + Android SDK cmdline tools (no Android Studio).
# Nixpkgs `flutter` stable often lags (e.g. 3.47.4 + Dart 3.13.3); use FVM for app SDK versions.
{pkgs, ...}: let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    includeEmulator = false;
    includeSystemImages = false;
    includeNDK = false;
    # Latest 2 API levels — enough for most apps; bump if you need older targets.
    numLatestPlatformVersions = 2;
  };

  androidSdk = androidComposition.androidsdk;
  jdk = pkgs.jdk17;
in {
  home.packages = with pkgs; [
    fvm
    unzip
    androidSdk
    androidComposition.platform-tools
    jdk
    # adb on PATH for physical devices (systemd uaccess handles USB permissions).
    android-tools
  ];

  home.sessionVariables = {
    JAVA_HOME = jdk.home;
    ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    # Flutter/Dart caches live in $HOME, not the read-only SDK store path.
    PUB_CACHE = "$HOME/.pub-cache";
  };
}

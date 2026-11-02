# Flutter + Android SDK (cmdline tools only — no Android Studio / emulator by default).
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
    flutter
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

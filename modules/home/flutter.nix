{ config, pkgs, lib, ... }:

let
  androidSdk = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "android-34" "android-33" ]; 
    buildToolsVersions = [ "34.0.0" ];
    cmdlineToolsVersion = "latest";
    includeEmulator = true;
  };

  androidSdkRoot = "${androidSdk}/libexec/android-sdk";
in
{
  home.packages = with pkgs; [
    flutter
    android-tools
    androidsdk
    sdkmanager

    cmake
    ninja
    pkg-config
  ];

  home.sessionVariables = {
    ANDROID_HOME = androidSdkRoot;
    ANDROID_SDK_ROOT = androidSdkRoot;

    PATH = [
      "${androidSdkRoot}/platform-tools"
      "${androidSdkRoot}/cmdline-tools/latest/bin"
    ] ++ config.home.sessionPath;

    GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdkRoot}/build-tools/34.0.0/aapt2";
  };
}

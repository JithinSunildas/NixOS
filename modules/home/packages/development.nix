{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Editors
    helix
    vscode
    emacs

    # Build tools
    cmake

    # Hardware design
    iverilog

    # Mobile
    flutter
    android-tools

    # Backend
    # Java/Spring Boot
    jdk21
    maven
    gradle
    spring-boot-cli

    # PHP/Laravel
    php83
    php83Extensions.pdo
    php83Extensions.mbstring
    php83Extensions.xml
    php83Extensions.curl
    php83Extensions.zip
    php83Extensions.gd

    # Databases
    mysql80
    postgresql
    dbeaver-bin
  ];

  nixpkgs.config = {
    android_sdk.accept_license = true;
  };
}

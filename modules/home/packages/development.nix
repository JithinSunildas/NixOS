{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Editors
    helix
    vscode
    emacs

    # Build tools
    cmake
    pkgsCross.musl64.stdenv.cc

    # Design and Frontend
    typst
    tinymist
    pandoc

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
    mariadb

    # PHP/Laravel
    php83
    php83Extensions.pdo
    php83Extensions.mbstring
    php83Extensions.xml
    php83Extensions.curl
    php83Extensions.zip
    php83Extensions.gd

    # Databases
    mariadb
    postgresql
  ];

  CC_x86_64_unknown_linux_musl = "${pkgs.pkgsCross.musl64.stdenv.cc}/bin/x86_64-unknown-linux-musl-gcc";
  CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER = "${pkgs.pkgsCross.musl64.stdenv.cc}/bin/x86_64-unknown-linux-musl-gcc";

  nixpkgs.config = {
    android_sdk.accept_license = true;
  };
}

{ config, ... }:

{
xdg.configFile."mango/config.conf".source =
  config.lib.file.mkOutOfStoreSymlink ./config.conf;
}

{ config, pkgs, lib, ... }:
let
  v2raya = pkgs.callPackage ./../../pkgs/v2raya { };
in {
  options = {
    services.v2raya = {
      enable = lib.options.mkEnableOption "the v2rayA service";
    };
  };

  config = lib.mkIf config.services.v2raya.enable {
    systemd.services.v2raya = {
      unitConfig = {
        Description = "v2rayA service";
        Documentation = "https://github.com/v2rayA/v2rayA/wiki";
        After = [ "network.target" "nss-lookup.target" "iptables.service" "ip6tables.service" ];
        Wants = [ "network.target" ];
      };

      serviceConfig = {
        User = "root";
        ExecStart = "${v2raya}/bin/v2rayA --log-disable-timestamp";
        LimitNPROC = 500;
        LimitNOFILE = 1000000;
        Environment = "V2RAYA_LOG_FILE=/var/log/v2raya/v2raya.log";
        Restart = "on-failure";
        Type = "simple";
      };

      wantedBy = [ "multi-user.target" ];
      path = with pkgs; [ iptables bash iproute2 ]; # required by v2rayA TProxy functionality
    };
  };
}

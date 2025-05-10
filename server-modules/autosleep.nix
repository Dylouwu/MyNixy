{ pkgs, ... }:
let
  wakeHour = 8;
  wakeMinute = 0;
  sleepHour = 2;
  sleepMinute = 0;
  timezone = "Europe/Paris";
in {
  systemd.services."auto-sleep" = {
    description = "Suspend system at ${toString sleepHour}:${
        toString sleepMinute
      } and wake at ${toString wakeHour}:${toString wakeMinute}";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "smart-sleep-and-wakeup" ''
        #!/bin/sh
        set -eu

        # Set timezone
        export TZ=${timezone}

        # Get current hour and minute
        current_hour=$(date +%H)
        current_minute=$(date +%M)
        current_time_minutes=$((current_hour * 60 + current_minute))

        # Calculate sleep and wake times in minutes since midnight
        sleep_time_minutes=$((${toString sleepHour} * 60 + ${
          toString sleepMinute
        }))
        wake_time_minutes=$((${toString wakeHour} * 60 + ${
          toString wakeMinute
        }))

        if [ $current_time_minutes -ge $sleep_time_minutes ] && [ $current_time_minutes -lt $wake_time_minutes ]; then
          # Current time is between sleep time and wake time - wake up today
          target_wake=$(date -d "today ${toString wakeHour}:${
            toString wakeMinute
          }" +%s)
        else
          # Otherwise wake up tomorrow
          target_wake=$(date -d "tomorrow ${toString wakeHour}:${
            toString wakeMinute
          }" +%s)
        fi

        now=$(date +%s)
        delta=$(( target_wake - now ))

        # Only sleep if delta is positive
        if [ $delta -le 0 ]; then
          echo "Wake time is in the past. Not suspending."
          exit 0
        fi

        echo "Sleeping now, will wake in $delta seconds (at $(date -d "@$target_wake" "+%Y-%m-%d %H:%M:%S %Z"))..."
        ${pkgs.utillinux}/bin/rtcwake -m mem -s "$delta"
      '';
    };
  };

  systemd.timers."auto-sleep" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* ${toString sleepHour}:${toString sleepMinute}:00";
    };
  };
}

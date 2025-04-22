{ pkgs, ... }:
let
  menu = pkgs.writeShellScriptBin "menu"
    # bash
    ''
      if pgrep wofi; then
      	pkill wofi
      else
      	wofi -p "Apps" --show drun &
      	# Quit when not focused anymore
      	sleep 0.2
      	while true; do
      		window=$(hyprctl activewindow | grep "wofi")
      		if [[ ! $window ]]; then
      			pkill wofi
      			break
      		fi
      		sleep 0.1
      	done
      fi
    '';
  powermenu = pkgs.writeShellScriptBin "powermenu"
    # bash
    ''
      if pgrep wofi; then
      	pkill wofi
      	exit
      fi
      
      # Create the menu options
      options=(
        "󰌾 Lock"
        "󰍃 Logout"
        " Suspend"
        "󰑐 Reboot"
        "󰿅 Shutdown"
      )
      
      # Create a named pipe for communication
      fifo=$(mktemp -u)
      mkfifo "$fifo"
      
      # Start wofi and capture its output
      printf '%s\n' "''${options[@]}" | wofi -p "Powermenu" --dmenu > "$fifo" &
      wofi_pid=$!
      
      # Start background monitor to close wofi when it loses focus
      {
        sleep 0.2
        while true; do
          window=$(hyprctl activewindow | grep "wofi")
          if [[ ! $window ]]; then
            pkill -P $$ wofi
            break
          fi
          sleep 0.1
        done
      } &
      monitor_pid=$!
      
      # Read selection from the pipe
      read -r selected < "$fifo"
      rm "$fifo"
      
      # Kill the monitor process
      kill $monitor_pid 2>/dev/null
      
      # Process selection
      if [[ $selected ]]; then
        selected=''${selected:2}
        case $selected in
          "Lock")
            ${pkgs.hyprlock}/bin/hyprlock
            ;;
          "Logout")
            hyprctl dispatch exit
            ;;
          "Suspend")
            systemctl suspend
            ;;
          "Reboot")
            systemctl reboot
            ;;
          "Shutdown")
            systemctl poweroff
            ;;
        esac
      fi
    '';
  quickmenu = pkgs.writeShellScriptBin "quickmenu"
    # bash
    ''
      if pgrep wofi; then
      	pkill wofi
      	exit
      fi
      
      # Create the menu options
      options=(
        "󰅶 Caffeine"
        "󰖔 Night-shift"
        " Nixy"
        "󰈊 Hyprpicker"
        "󰖂 Toggle VPN"
      )
      
      # Create a named pipe for communication
      fifo=$(mktemp -u)
      mkfifo "$fifo"
      
      # Start wofi and capture its output
      printf '%s\n' "''${options[@]}" | wofi -p "Quickmenu" --dmenu > "$fifo" &
      wofi_pid=$!
      
      # Start background monitor to close wofi when it loses focus
      {
        sleep 0.2
        while true; do
          window=$(hyprctl activewindow | grep "wofi")
          if [[ ! $window ]]; then
            pkill -P $$ wofi
            break
          fi
          sleep 0.1
        done
      } &
      monitor_pid=$!
      
      # Read selection from the pipe
      read -r selected < "$fifo"
      rm "$fifo"
      
      # Kill the monitor process
      kill $monitor_pid 2>/dev/null
      
      # Process selection
      if [[ $selected ]]; then
        selected=''${selected:2}
        case $selected in
          "Caffeine")
            caffeine
            ;;
          "Night-shift")
            night-shift
            ;;
          "Nixy")
            kitty zsh -c nixy
            ;;
          "Hyprpicker")
            sleep 0.2 && ${pkgs.hyprpicker}/bin/hyprpicker -a
            ;;
          "Toggle VPN")
            openvpn-toggle
            ;;
        esac
      fi
    '';
  lock = pkgs.writeShellScriptBin "lock"
    # bash
    ''
      ${pkgs.hyprlock}/bin/hyprlock
    '';
in { home.packages = [ menu powermenu lock quickmenu ]; }

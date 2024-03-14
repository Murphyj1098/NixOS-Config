{ pkgs, ... }:

{
    wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ ];
    settings = { };
    extraConfig = ''
      ## STARTUP ##

      # Wallpaper
      exec-once=swww init
      exec-once=swww img /home/jrmurphy/.config/hypr/wallpaper.png

      # Notifs
      exec-once=mako

      # Bar
      exec-once=waybar


      ## Monitors ##

      # Laptop Screen
      monitor=desc:Sharp Corporation 0x1548,preferred,0x1148,1.0
      # NOTE: The location for this monitor is based on the 'Work Dock' configuration. This is the
      #       only time the position of the laptop (in relation to other monitors) matters.

      # Clamshell Behavior
      bindl=,switch:Lid Switch,exec,/home/jrmurphy/.config/hypr/scripts/lid.sh

      # Home Thunderbolt Dock
      monitor=desc:Ancor Communications Inc ASUS VS239 J7LMTF006741,preferred,0x180,1.0
      monitor=desc:Acer Technologies XV272U 0x11614F92,preferred,1920x0,1.0
      monitor=desc:Dell Inc. DELL 2007WFP HF73064L41FL,preferred,4480x-300,1.0,transform,1

      # Work Dock
      monitor=desc:Dell Inc. DELL P2411H F8NDP116088U,preferred,1920x591,1.0
      monitor=desc:Dell Inc. DELL P2217H 668VC68Q233B,preferred,3840x0,1.0,transform,1

      # Catch-all Default 
      monitor=,preferred,auto,1.0


      ## Workspaces ##
      # workspace = 1, monitor:desc:Sharp Corporation 0x1548, default:true
      # workspace = 1, monitor:desc:Ancor Communications Inc ASUS VS239 J7LMTF006741, default:true
      # workspace = 1, montorp:desc:Acer Technologies XV272U 0x11614F92, default:true
      # workspace = 1, monitor:desc:Dell Inc. DELL 2007WFP HF73064L41FL, default:true

      ## Environment Vars ##
      env = XCURSOR_SIZE,24

      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = no
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
          numlock_by_default = true
      }

      general {
          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = dwindle

          allow_tearing = false
      }

      decoration {
          rounding = 10
          
          blur {
              enabled = true
              size = 3
              passes = 1
          }

          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          new_is_master = true
      }

      gestures {
          workspace_swipe = off
      }

      misc {
          force_default_wallpaper = 0
      }

      device:logitech-g502-1 {
          sensitivity = -0.6
      }
      device:steelseries-steelseries-rival-3-wireless {
          sensitivity = -0.5
      }


      ## Binds ##
      $mainMod = SUPER

      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, C, killactive, 
      bind = $mainMod, M, exit, 
      bind = $mainMod, V, togglefloating, 
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = CONTROLSHIFT, F, fullscreen, 1

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # rofi launcher
      bind = $mainMod, SPACE, exec, rofi -show drun -show-icons
    '';
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        margin = "7 7 3 7";
        spacing = 2;

        modules-left = [];
        modules-center = [];
        modules-right = [ "wireplumber" "battery" "clock" ];

        wireplumber = {
          "format" = "{volume}%, {icon}";
          "format-muted" = "🔇";
          "max-volume" = 100;
          "scroll-step" = 1.0;
          "format-icons" = [ "" "" "" ];
          "on-click" = "pavucontrol";
        };

        clock = {
          "interval" = 1;
          "format" = "{:%a %Y-%m-%d %I:%M:%S %p}";
          "timezone" = "America/New_York";
        };

        battery = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-icons" = [ "" "" "" "" "" ];
        };
      };
    };
  };
}
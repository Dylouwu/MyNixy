{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";

      control-center-layer = "top";
      control-center-width = 400;
      control-center-height = 400;
      control-center-margin-top = 10;
      control-center-margin-bottom = 250;
      control-center-margin-right = 10;

      notification-window-width = 400;
      notification-icon-size = 48;
      notification-body-image-height = 80;
      notification-body-image-width = 160;
      notification-2fa-action = true;
      notification-grouping = false;

      image-visibility = "when-available";
      transition-time = 100;

      widgets = [ "dnd" "mpris" "notifications" ];

      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = { text = "Do Not Disturb"; };
        label = {
          max-lines = 3;
          text = "Label Text";
        };
        mpris = {
          image-size = 64;
          blur = true;
        };
      };
    };
    style = ''
      * {
        font-size: 14px;
      }

      .control-center {
        padding: 5px;
        border-radius: 15px;
      }

      .widget-body, .widget-mpris, .widget-dnd, .widget-inhibitors {
        margin: 4px 5px; 
      }


      .notification-row {
        background: transparent !important;
        border: none !important;
        outline: none !important;
        margin: 8px !important;
      }

      .widget-notifications {
        background: transparent !important;
        border: none !important;
        padding: 0 !important;
        margin: 0 !important;
      }

      .notification {
        margin: 0 !important; 
        padding: 14px;
        border-radius: 12px; 
      }

      .notification-content {
        margin-left: 10px;
      }

      .notification-title {
        font-size: 14px;
        font-weight: bold;
      }

      .notification-body {
        font-size: 13px;
      }
    '';
  };
}

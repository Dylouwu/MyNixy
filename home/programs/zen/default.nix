# Zen is a minimalistic web browser.
{ inputs, ... }: {
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;

      AutofillAddressesEnabled = false;
      AutoFillCreditCardEnabled = false;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableSetDesktopBackground = true;
      DontCheckDefaultBrowser = true;
      Homepage = "https://home.dilou.me";
      SkipTermsOfUse = true;
      NewTabPage = true;
      OfferToSaveLogins = false;
    };
  };
}

{
  # 👤 SYSTEM & USER CONFIGURATION
  username    = "tiizzel";
  hostName    = "nixos";
  gitUsername = "Tiizzel";
  gitEmail    = "tiizztwitch@gmail.com";

  # Localization
  keyboardLayout  = "de";
  keyboardVariant = "";
  timezone        = "Europe/Berlin";

  # 🖥️ DISPLAY & WINDOW MANAGER
  displayManager = "sddm"; # Not used yet in this config but for future
  hyprlandLayout = "dwindle";

  # Terminal & Editor
  terminal = "kitty";
  editor   = "neovim";
  browser  = "firefox";

  # 📦 FEATURE TOGGLES
  thunarEnable    = true;
  gamingSupportEnable = true;
  steamEnable     = true;

  # 🎨 THEMING & AESTHETICS
  barChoice = "noctalia"; # or "waybar"
}

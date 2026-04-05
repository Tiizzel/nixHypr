# nixHypr - Personal NixOS & Hyprland Configuration

A modular NixOS configuration built with [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/vic/import-tree) for automatic module discovery.

## Project Overview

- **Host:** `nixos` (defined in `hosts/nixos`)
- **Main Desktop:** [Hyprland](https://hyprland.org/) (managed in `modules/desktops/hyprland.nix`)
- **Key Technologies:**
    - **Nix Flake:** Centralized configuration management.
    - **Home-Manager:** Manages user-specific configurations and dotfiles.
    - **flake-parts:** Modularizes the flake definition.
    - **import-tree:** Automatically discovers and imports modules from the `modules/` directory.
    - **Matugen:** Likely used for material color generation/theming.

## Architecture

The project follows a "Dendritic Pattern" where modules are discovered from the `modules/` directory.

- **`flake.nix`**: Entry point. Uses `import-tree` to load all modules in `modules/`.
- **`modules/`**: Contains sub-directories for different categories of configuration (browsers, editors, shells, etc.).
    - Each module typically defines `flake.nixosModules.<name>` and/or `flake.homeModules.<name>`.
- **`hosts/`**: Contains machine-specific configurations.
- **`dotfiles/`**: Contains raw configuration files (e.g., `hyprland.conf`, `kitty.conf`).
    - These are symlinked using `config.lib.file.mkOutOfStoreSymlink` to allow for immediate updates without a full rebuild.
    - **Note:** Paths in symlinks are currently hardcoded to `/home/tiizzel/nixHypr/dotfiles`.
- **`_archive/`**: Contains legacy or unused configuration files.

## Building and Running

### Apply Configuration
To rebuild the NixOS system and switch to the new configuration:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### Update Flake Inputs
To update all flake inputs (like nixpkgs, hyprland):

```bash
nix flake update
```

## Development Conventions

- **Modularization**: Keep configurations small and focused. Add new modules to the appropriate subdirectory in `modules/`.
- **Module Registration**: Use `flake.nixosModules.<name>` for system-level settings and `flake.homeModules.<name>` for user-level (Home-Manager) settings.
- **Dotfiles**: Store application-specific config files in `dotfiles/` and link them in the corresponding Home-Manager module using `mkOutOfStoreSymlink`.
- **Imports**: Avoid manual imports where possible; `import-tree` handles discovery. Explicitly enable discovered modules in `modules/flake/nixos-configurations.nix`.
- **User Configuration**: User-specific Home-Manager module imports are handled in `modules/core/users.nix`.

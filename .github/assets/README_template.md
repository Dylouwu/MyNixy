<div align="center">
    <img src="https://raw.githubusercontent.com/Dylouwu/MyNixy/main/.github/assets/logo.png" width="120px" />
</div>

<br>

# MyNixy

<br>
<div align="center">
    <a href="https://github.com/Dylouwu/MyNixy/stargazers">
        <img src="https://img.shields.io/github/stars/Dylouwu/MyNixy?color={primarycolor}&labelColor={backgroundcolor}&style=for-the-badge&logo=starship&logoColor={primarycolor}">
    </a>
    <a href="https://github.com/Dylouwu/MyNixy/">
        <img src="https://img.shields.io/github/repo-size/Dylouwu/MyNixy?color={primarycolor}&labelColor={backgroundcolor}&style=for-the-badge&logo=github&logoColor={primarycolor}">
    </a>
    <a href="https://nixos.org">
        <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor={backgroundcolor}&logo=NixOS&logoColor={primarycolor}&color={primarycolor}">
    </a>
    <a href="https://github.com/Dylouwu/MyNixy/blob/main/LICENSE">
        <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA={backgroundcolor}&colorB={primarycolor}&logo=unlicense&logoColor={primarycolor}"/>
    </a>
</div>
<br>

**A big shoutout to [@anotherhadi](https://www.github.com/anotherhadi) for making Nixy and many other awesome projects, I highly recommend checking his work out!**

**[Nixy](https://github.com/anotherhadi/nixy) simplifies and unifies** the Hyprland ecosystem with a modular, easily customizable setup. It provides a structured way to manage your system configuration and dotfiles with minimal effort. It includes *home-manager, secrets, and custom theming* all in one place.

**MyNixy** is a Nixy fork, which is a NixOS configuration that I use on my personal laptop and server, with added **features** and **modules** to make it more suitable for my needs.

**Nixy features:**

- 💻 Hyprland-centric: Preconfigured Hyprland ecosystem (Hyprlock, Hyprpanel, etc.)
- 🏠 Home-manager support
- 🔏 Secret handling with [sops](https://https://github.com/Mic92/sops-nix)
- 🏔️ Nvidia GPU support (optimus-manager, nvidia-prime, ...)
- 🎨 Consistent Theming: Base16 & Stylix-powered themes

**MyNixy major additions:**

- 🕹️ **A fully customizable and optimized Minecraft Paper server**, which can be started and stopped directly from the glance dashboard through API calls.
- 💾 New server modules : Cyberchef, Fail2ban, Autosleep, ...
- 🎮 Gaming integration with Steam x Proton, Osu-Lazer, Modrinth (Minecraft Open-Source launcher).

Other small modifications include:

- Minecraft themed grub instead of relying on systemd-boot
- Zellij over tmux
- Copilot shortcuts
- C++ environment with clangd
- Removed bluetooth module
- And many more to come ! Feel free to check the repository issues for more information about the next features to come.

## Table of Content

{md_table_of_content}

## Gallery

![nvim, lazygit](.github/assets/nixy/3.png)

## Architecture

### 🏠 home

Contains **dotfiles and settings** that apply to your user environment.

**Subfolders:**

- `programs` is a collection of apps configured with home-manager
- `scripts` is a folder full of bash scripts (see [SCRIPTS.md](docs/SCRIPTS.md))
- `system` is some "desktop environment" configuration

### 🐧 /nixos

Those are the system-level configurations. (audio, gpu, bootloader, session manager, ...)

### 💻 /hosts

This directory contains host-specific configurations. Each host includes:

- `configuration.nix` for system-wide settings
- `home.nix` for user-level configuration
- `variables.nix` for global variables
- `secrets/` for sensitive data

### 💾 server-modules

Those are the server modules that are used to add features to the server. These include a nextcloud environment, a glance dashboard, ssh connection support, and more.

## Installation

1. [Download](https://nixos.org/download/) and [install](https://nixos.wiki/wiki/NixOS_Installation_Guide) NixOS.

> [!Important]
> Please note that if you do not have a needed package in your NixOS installation (if you installed the minimal terminal version for instance), you can use the following command to temporarily install the needed package:
>
> ```sh
> nix-shell -p <package-name>
> ```

2. [Fork](https://github.com/Dylouwu/MyNixy/fork) this repository and clone it to your machine:

```sh
git clone https://github.com/Dylouwu/MyNixy ~/.config/nixos
```

3. Update `variables.nix` with your device settings.
4. Copy your `hardware-configuration.nix` into your new host's folder to ensure proper hardware support.
5. Register your new host in `flake.nix` by adding it under nixosConfigurations.

> [!Important]
> `# CHANGEME` comments are placed throughout the configuration to indicate necessary modifications.
> Use the following command to quickly locate them:
>
> ```sh
> rg "CHANGEME" ~/.config/nixos
> ```

> [!TIP]
> When you add new files, don't forget to run `git add .` to add them to the git repository

6. Build the system

```sh
sudo nixos-rebuild switch --flake ~/.config/nixos#yourhostname
```

7. Reboot your system.

> [!TIP]
> Recommended things to do after the installation:
>
> - Since your fork was cloned through HTTPS, you may want to change its origin to the SSH one (making full use of the config)
>
> - Additionally, you can remove warning messages while rebuilding the system by using these commands:
>
> ```sh
>   sudo rm /root/.nix-defexpr/channels
>   sudo rm /nix/var/nix/profiles/per-user/root/channels
> ```

## 😿 Non-declarative things

For laptop configurations :

- Zen's settings, logins, extensions (which can be alternatively synced with a firefox account), and mods must be installed manually from the browser directly.
- Tailscale (`sudo tailscale up`), Discord, Nextcloud, Copilot (in nvim) and other apps need their settings must be done manually
- Steam launch options (included in `nixos/steam.nix`) and game library
- Modrinth modpacks, JVM arguments, and other Minecraft-related things
- And maybe more ☔

For server configurations:

- Most apps configurations (adguardhome, cloudflare, glance, nextcloud, etc.) are done through the web interface.
- Some data like the nextcloud database, vaultwarden, minecraft worlds and more, need to be imported manually if you have them on your previous server, and you SHOULD backup them, algonside with your keys.

## Documentation

- [SCRIPTS](docs/SCRIPTS.md): Scripts that are available
- [KEYBINDINGS-HYPRLAND](docs/KEYBINDINGS-HYPRLAND.md): Keybindings available in Hyprland
- [WALLPAPERS](https://github.com/anotherhadi/awesome-wallpapers): A collection of wallpapers for Nixy.

- [LICENSE](LICENSE): MIT License

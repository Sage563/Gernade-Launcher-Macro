# Grenade-Launcher-Macro

> **Disclaimer:** This macro is designed **only for Hyprland** (Wayland) and will not work on other window managers or desktop environments.

A Grenade Launcher macro for Linux (supports **Sober**).

## Prerequisites & In-Game Setup

Before running the script, configure your Roblox settings properly so the macro selects the right weapon:

1. **Weapon Selector:** Set your weapon selector mode to **List**.
2. **Favorite Your Grenade Launcher:** Ensure the Grenade Launcher is favorited so it sits at the very top of your weapon list.
3. **Favorite Utilities & Melee:** Favorite your utilities and a few Melee weapons so the macro doesn't accidentally try to select red-blocked weapons.

## Compatibility

* **Window Manager:** **Hyprland only.**
* **Roblox Client (Sober):** Tested and working.

## Usage

1. Make the script executable:
   ```bash
   chmod +x script.sh
   ```
2. Run the script to activate it in the background:
   ```bash
   ./script.sh
   ```
3. Open Roblox and press **`F8`** to trigger the macro.
4. *(Optional)* Inspect the source code; it's completely safe.

## Troubleshooting

* **Macro misses the Grenade Launcher:** If the script isn't clicking on the Grenade Launcher properly, open `script.sh` and adjust the **`x` and `y` coordinate values** to match your screen resolution.

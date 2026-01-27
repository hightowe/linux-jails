# Gemini-Desktop Launcher

A security-hardened launcher script for the [Gemini-Desktop](https://github.com/bwendell/gemini-desktop) application. This wrapper ensures that the third-party client runs in an isolated environment with strictly controlled network access.

## Why This Exists

Popular third-party desktop clients for Gemini (such as the similarly named "GeminiDesk") have been [flagged for containing surveillance software](https://www.reddit.com/r/GeminiAI/comments/1p6h3wa/warning_geminidesk_please_be_careful_with_random/) designed to steal passwords, exfiltrate session cookies, and execute unauthorized code.

While `Gemini-Desktop` by `bwendell` is the chosen alternative, this launcher adds a "defense-in-depth" layer to ensure that even if the application were compromised, its ability to cause harm is severely limited.

## What It Does

This script implements several security measures using `firejail` and custom network filters:

1.  **Network Whitelisting**: The script fetches Google's official CIDR IP ranges dynamically and configures a `netfilter` firewall that drops **all** outgoing traffic except to Google's infrastructure.
2.  **DNS Locking**: Enforces the use of Google DNS (`8.8.8.8`), preventing the app from seeing local network DNS entries or using malicious DNS servers.
3.  **Filesystem Isolation**:
    - Runs inside a `firejail` sandbox without a default profile (`--noprofile`).
    - Redirects the application's home directory to a dedicated sandbox folder (`~/jails/gemini-desk`).
    - Whitelists only the sandbox directory and `~/Downloads` for file access.
4.  **Process Isolation**: Ensures the application cannot see other processes on the system.

## Performance & Limitations

- **Updates**: Because GitHub IP addresses are not whitelisted, the "Check for Updates" feature within the app will not work.
- **Network Interface**: Auto-detects the active network interface to apply filters correctly.

## Prerequisites

- `firejail`
- `jq`
- `curl`

## Usage

1.  **Configure the script**: Open the `Gemini-Desktop` script and update the following variables in the `Config` section to match your environment:
    -   `APP_EXE`: The path to your `Gemini-Desktop` AppImage or binary.
    -   `JAIL_DIR`: The directory where you want the sandbox data to be stored (e.g., `~/jails/gemini-desk`).
    -   `JAIL_NAME`: (Optional) A custom name for the `firejail` instance.
2.  **Run the script**:

```bash
./Gemini-Desktop
```

The script will:
1. Fetch the latest Google IP ranges.
2. Build a local `google.rules` file for `iptables`.
3. Launch the AppImage (or binary) inside the restricted jail.

---
*Note: This script was created out of a desire for extreme privacy and security when using third-party wrappers for AI services.*

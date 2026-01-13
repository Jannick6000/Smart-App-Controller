# Smart-App-Controller
This is a small, self-elevating Windows batch script that toggles Smart App Control / “Verified &amp; Reputable” policy enforcement by writing a single registry value.

---

### What this script does (exactly)

1. Requests administrative privileges (UAC prompt) by re-launching itself with RunAs.

2. Prompts you to choose ON, OFF, or Cancel.

3. Writes one DWORD registry value:

    * Path: HKLM\System\CurrentControlSet\Control\CI\Policy

    * Name: VerifiedAndReputablePolicyState

    * Type: REG_DWORD

    * Data: 1 (ON) or 0 (OFF)

4. Prompts whether to restart now or restart later.

5. Displays a basic status message.

---

### Requirements

Windows 11 (Smart App Control is a Windows 11 feature; behavior differs across builds).

Administrator rights (required to write under HKLM and to control Code Integrity policy settings).

Ability to restart the system (recommended).

---

### Usage

1. Download the .bat file to a local folder.

2. Right-click → Run as administrator (or double-click and accept the UAC prompt).

3. Select:

* ```1``` to set policy to ON

* ```2``` to set policy to OFF

* ```C``` to cancel

Choose whether to restart immediately.


**Verify the current Smart App Control mode (recommended)**

Microsoft documents using citool.exe to list active policies/mode (helpful to confirm what the OS is actually enforcing).

Example (run in an elevated terminal):

``` bash
citool.exe -lp
```

---

## Security implications (read before using)

Smart App Control is a security feature designed to block untrusted or low-reputation applications based on Microsoft’s reputation/signing checks and cloud intelligence. Disabling it can materially reduce your protection against malicious or unwanted software.

If you set VerifiedAndReputablePolicyState to 0 (OFF):

* You may allow software that Smart App Control would otherwise block.

* You may increase exposure to:

   + unsigned executables,

   + low-reputation binaries,

   + potentially unwanted applications (PUA/PUP),

   + and malware droppers that rely on user execution.

If you set it to **1 (ON)**:

You may cause legitimate apps (especially niche tools, unsigned binaries, internal builds) to be blocked or fail to run as expected.

Use this script only if you understand the trade-off and can tolerate the operational impact.

---

## Disclaimer

This script is provided “as is”, without warranty. You are responsible for:

   * understanding what the setting does,

   * complying with your organization’s security policies,

  * and verifying the results on your specific Windows version/build.

The author(s) are not liable for system instability, security incidents, or data loss resulting from use or misuse.

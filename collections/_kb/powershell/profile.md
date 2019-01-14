---
tech: powershell
title: Profiles
tags: [shell, powershell]
sources:
  - name: PowerShell Profile introduction
    link: https://docs.microsoft.com/en-us/previous-versions//bb613488(v=vs.85)
  - name: PowerShell Profile documentation
    link: https://docs.microsoft.com/en-us/powershell/scripting/components/ise/how-to-use-profiles-in-windows-powershell-ise?view=powershell-6
---

## Create a profile

Locate your profile and create it if necessary:

```powershell
$profile
new-item -path $profile -itemtype file -force
```

## Edit profile

Execute the command you want to be executed whenever a new PowerShell window
opens:

```powershell
# Determine starting location
Set-Location C:\
#
```

**Misc**:

- [Add a welcome message](https://www.computerperformance.co.uk/powershell/profile-ps1/)

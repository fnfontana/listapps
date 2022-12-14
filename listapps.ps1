# Developed by Fernando Fontana under the MIT License, 2022.
# This means that you can use this script for free, but you can't sell it.
# Also if you modify it, you must share the modifications under the same license.
#
# In other words: You can do whatever you want as long as you include the original copyright
# and license notice in any copy of the software/source.
#
# This script creates the listapps function, that can be used to list all installed programs on the computer.
# Currently it can get the list from the registry, scoop, winget, chocolatey, pip, pipx, npm, yarn and cargo.
#
# It works as wrapper for other commands, so it is not necessary to install it.
# Just copy the file into your PowerShell profile folder and add the following line to your profile:
# Invoke-Expression (Get-Content -Path .\Documents\PowerShell\listapps.ps1 -Raw)
#
# To see the instructions on how to use this script, run:
# listapps --help
#
# It can be powerful when combined with tools like:
# - fzf        Powerful Fuzzy Finder to filter the list
# - ripgrep    Powerful RegEx search on the list
# - more       Show the list in a pager
# ...And other commands like peco, grep, findstr, etc.
#
# Examples:
# listapps | fzf
# listapps | rg -i "python"
# listapps --choco | fzf
#
# Another possibility is to save the list to a file and use it with other commands:
# listapps --choco > choco_apps.txt
# listapps --yarn > yarn_packages.txt
#
# The cited above functions may be implemented on this script in the future.
# Or may I develop a whole new cli program with a better interface and more features.
# But for now, this is a simple script that works well enough for me.
# =========================================================================================================================================================

# List all programs installed on the computer using the registry
function show-installed-programs-hklm {
    Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher | Sort-Object DisplayName | Format-Table -AutoSize
}
# List all programs installed with scoop
function show-installed-programs-scoop {
    scoop list
}
# List all programs installed with winget
function show-installed-programs-winget {
    winget list
}
# List all programs installed with choco
function show-installed-programs-choco {
    choco list --local-only
}

# The following funciton list the apps instelled on the computer
function show-installed-programs {
    if ($args[0] -eq "default" -or $args[0] -eq "computer" -or $null -eq $args[0] -or $args[0] -eq "") {
        show-installed-programs-hklm
    }
    # List all programs installed with scoop
    elseif ($args[0] -eq "scoop") {
        show-installed-programs-scoop
    }
    # List all programs installed with winget
    elseif ($args[0] -eq "winget") {
        show-installed-programs-winget
    }
    # List all programs installed with choco
    elseif ($args[0] -eq "choco" -or $args[0] -eq "chocolatey") {
        show-installed-programs-choco
    }

    # Language specific package managers
    # list all programs installed with pip
    elseif ($args[0] -eq "pip") {
        pip list --format=columns
    }
    # list all programs under pipx virtual environments
    elseif ($args[0] -eq "pipx") {
        pipx list
    }
    # list all packages installed with npm
    elseif ($args[0] -eq "npm") {
        npm list -g --depth=0
    }
    # list all packages installed with yarn
    elseif ($args[0] -eq "yarn") {
        yarn global list --depth=0
    }
    # list all programs installed with cargo
    elseif ($args[0] -eq "-cargo") {
        cargo install --list
    }

    # Show help message
    elseif ($args[0] -eq "--help" -or $args[0] -eq "-h") {
        Write-Host "List all programs and applications installed on the computer."
        Write-Host ""
        Write-Host "Usage: show-installed-programs [OPTION] [--Flags]"
        Write-Host ""
        Write-Host ""
        Write-Host "OPTIONS AVAILABLE: "
        Write-Host ""
        Write-Host "        default          List all programs installed on the computer"
        Write-Host "        computer         List all programs installed on the computer        (alias for --default)"
        Write-Host "        choco            List all programs installed with choco"
        Write-Host "        chocolatey       List all programs installed with choco             (alias for --choco)"
        Write-Host "        scoop            List all programs installed with scoop"
        Write-Host "        winget           List all programs installed with winget"
        Write-Host "        pip              List all programs installed with pip"
        Write-Host "        pipx             List all programs under pipx virtual environments"
        Write-Host "        npm              List all packages installed with npm"
        Write-Host "        yarn             List all packages installed with yarn"
        Write-Host "        cargo            List all programs installed with cargo"
        Write-Host ""
        Write-Host " FLAGS AVAILABLE: "
        Write-Host " -h     --help           Show this help message"

    }
    else {
        Write-Host "Invalid argument passed. Valid arguments are:"
        Write-Host " -d     default"
        Write-Host "        computer   (alias for --default)"
        Write-Host "        choco"
        Write-Host "        chocolatey (alias for --choco)"
        Write-Host "        scoop"
        Write-Host "        winget"
        Write-Host "        pip"
        Write-Host "        pipx"
        Write-Host "        npm"
        Write-Host "        yarn"
        Write-Host "        cargo"
        Write-Host " -h     --help"
    }
}

# Create an alias for the function
Set-Alias listapps show-installed-programs #-Option AllScope
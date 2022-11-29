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
        Write-Host "Usage: show-installed-programs [OPTION]"
        Write-Host ""
        Write-Host ""
        Write-Host "Options Available: "
        Write-Host " -a     --alias"
        Write-Host ""
        Write-Host " -d     --default          List all programs installed on the computer"
        Write-Host " -d     --computer         List all programs installed on the computer        (alias for --default)"
        Write-Host " -c     --choco            List all programs installed with choco"
        Write-Host " -c     --chocolatey       List all programs installed with choco             (alias for --choco)"
        Write-Host " -s     --scoop            List all programs installed with scoop"
        Write-Host " -w     --winget           List all programs installed with winget"
        Write-Host " -p     --pip              List all programs installed with pip"
        Write-Host " -px    --pipx             List all programs under pipx virtual environments"
        Write-Host " -n     --npm              List all packages installed with npm"
        Write-Host " -y     --yarn             List all packages installed with yarn"
        Write-Host " -cg    --cargo            List all programs installed with cargo"
        Write-Host " -h     --help             Show this help message"

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
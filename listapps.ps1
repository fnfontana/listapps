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
    if ($args[0] -eq "--default" -or $args[0] -eq "--computer" -or $null -eq $args[0] -or $args[0] -eq "-d" -or $args[0] -eq "") {
        show-installed-programs-hklm
    }
    # List all programs installed with scoop
    elseif ($args[0] -eq "--scoop" -or $args[0] -eq "-s") {
        show-installed-programs-scoop
    }
    # List all programs installed with winget
    elseif ($args[0] -eq "--winget" -or $args[0] -eq "-w") {
        show-installed-programs-winget
    }
    # List all programs installed with choco
    elseif ($args[0] -eq "--choco" -or $args[0] -eq "--chocolatey" -or $args[0] -eq "-c") {
        show-installed-programs-choco
    }

    # Language specific package managers
    # list all programs installed with pip
    elseif ($args[0] -eq "--pip" -or $args[0] -eq "-p") {
        pip list --format=columns
    }
    # list all programs under pipx virtual environments
    elseif ($args[0] -eq "--pipx" -or $args[0] -eq "-px") {
        pipx list
    }
    # list all packages installed with npm
    elseif ($args[0] -eq "--npm" -or $args[0] -eq "-n") {
        npm list -g --depth=0
    }
    # list all packages installed with yarn
    elseif ($args[0] -eq "--yarn" -or $args[0] -eq "-y") {
        yarn global list --depth=0
    }
    # list all programs installed with cargo
    elseif ($args[0] -eq "--cargo" -or $args[0] -eq "-cg") {
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
        Write-Host " -d     --default"
        Write-Host "        --computer   (alias for --default)"
        Write-Host " -c     --choco"
        Write-Host "        --chocolatey (alias for --choco)"
        Write-Host " -s     --scoop"
        Write-Host " -w     --winget"
        Write-Host " -p     --pip"
        Write-Host " -px    --pipx"
        Write-Host " -n     --npm"
        Write-Host " -y     --yarn"
        Write-Host " -cg    --cargo"
        Write-Host " -h     --help"
    }
}

# Create an alias for the function
Set-Alias listapps show-installed-programs #-Option AllScope
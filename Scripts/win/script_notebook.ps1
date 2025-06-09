# --- Variables ---
$desktopPath = [System.Environment]::GetFolderPath('Desktop')
$repoName = 'TDCS_CodeAlong_2025'
$repoLink = 'https://github.com/Makerspace-Ashoka/TDCS_CodeAlong_2025.git'
$pythonVenvPath = "$desktopPath\$repoName\Notebooks\"
$meshPythonPath = "$desktopPath\$repoName\ysp-esp32-mesh-firmware\python-interface\src"
$repoPath = "$desktopPath\$repoName"
# $gitBranch = 'init_setup_edition_2'

# --- Utility functions ---
function Write-Info($msg) { Write-Host $msg -ForegroundColor Green }
function Write-ErrorMsg($msg) { Write-Host $msg -ForegroundColor Red }
function Write-ProgressMsg($msg) { Write-Host $msg -ForegroundColor Cyan }

# --- Track failures ---
$failures = @()

# --- ASCII Art Banner ---
Write-Host @'
 ___  ___      _                                              __   __        __   _____________ 
|  \/  |     | |                                             \ \ / /        \ \ / /  ___| ___ \
| .  . | __ _| | _____ _ __ ___ _ __   __ _  ___ ___    ______\ V /______    \ V /\ `--.| |_/ /
| |\/| |/ _` | |/ / _ \ '__/ __| '_ \ / _` |/ __/ _ \  |______/   \______|    \ /  `--. \  __/ 
| |  | | (_| |   <  __/ |  \__ \ |_) | (_| | (_|  __/        / /^\ \          | | /\__/ / |    
\_|  |_/\__,_|_|\_\___|_|  |___/ .__/ \__,_|\___\___|        \/   \/          \_/ \____/\_|    
                               | |                                                             
                               |_|                                                             
'@ -ForegroundColor Magenta

Write-Host 'This script sets up your development environment by installing and configuring essential tools and extensions.' -ForegroundColor Yellow
Write-Host ''

Write-Host 'Preparing environment...' -ForegroundColor Cyan
for ($i = 1; $i -le 5; $i++) {
    Write-Host -NoNewline '.' -ForegroundColor White
    Start-Sleep -Seconds 1
}
Write-Host ''

# --- Start in Desktop ---
Set-Location $desktopPath
Write-ProgressMsg "Starting setup in: $desktopPath"

# --- Step 1: Winget ---
Write-Host @'
======================================
  [ Step 1/10: Checking for Winget ]
======================================
'@ -ForegroundColor Magenta

$winget = Get-Command winget -ErrorAction SilentlyContinue
if (-not $winget) {
    Write-ErrorMsg 'Winget not found. Opening Microsoft Store to install App Installer.'
    Start-Process 'ms-windows-store://pdp/?productid=9NBLGGH4NNS1'
    Read-Host 'Please install App Installer, then press Enter to continue...'
    
    # Refresh environment variables for the current session
    $env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')

    $winget = Get-Command winget -ErrorAction SilentlyContinue
    if (-not $winget) {
        Write-ErrorMsg 'Winget still not found. Exiting.'
        $failures += "Winget installation failed"
        exit 1
    } else {
        Write-Info 'Winget installed successfully.'
    }
} else {
    Write-Info 'Winget is already installed.'
}

# --- Step 2: Git ---
Write-Host @'
==================================
  [ Step 2/10: Checking for Git ]
==================================
'@ -ForegroundColor Magenta

try {
    $gitVersion = & git --version 2>&1
    if ($gitVersion -match 'git version \d+\.\d+') {
        Write-Info "Git is already installed: $gitVersion"
    } else {
        throw 'Git output invalid.'
    }
} catch {
    Write-Info 'Git not found or invalid. Installing...'
    winget install --silent --accept-package-agreements --accept-source-agreements Git.Git
    Start-Sleep -Seconds 5

    # Refresh environment variables for the current session
    $env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')

    $gitVersion = & git --version 2>&1
    if ($gitVersion -match 'git version \d+\.\d+') {
        Write-Info "Git installed successfully: $gitVersion"
    } else {
        Write-ErrorMsg 'Git installation failed.'
        $failures += "Git installation failed"
    }
}

# --- Step 3: UV ---
Write-Host @'
===================================
  [ Step 3/10: Checking for UV ]
===================================
'@ -ForegroundColor Magenta

try {
    $uvVersion = & uv --version 2>&1
    if ($uvVersion -match 'uv \d+\.\d+\.\d+') {
        Write-Info "UV is already installed: $uvVersion"
    } else {
        throw 'UV output invalid.'
    }
} catch {
    Write-Info 'UV not found or invalid. Installing...'
    winget install --id=astral-sh.uv -e --silent --accept-package-agreements --accept-source-agreements
    Start-Sleep -Seconds 5

    # Refresh environment variables for the current session
    $env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')

    $uvVersion = & uv --version 2>&1
    if ($uvVersion -match 'uv \d+\.\d+\.\d+') {
        Write-Info "UV installed successfully: $uvVersion"
    } else {
        Write-ErrorMsg 'UV installation failed.'
        $failures += "UV installation failed"
    }
}

# --- Step 4: Visual Studio Code ---
Write-Host @'
=================================================
  [ Step 4/10: Checking for Visual Studio Code ]
=================================================
'@ -ForegroundColor Magenta

try {
    $codeVersion = & code --version 2>&1
    if ($codeVersion -match '^\d+\.\d+\.\d+') {
        Write-Info "VS Code is already installed: $($codeVersion -split "`n")[0]"
    } else {
        throw 'VS Code not found or invalid output.'
    }
} catch {
    Write-Info 'VS Code not found. Installing...'
    winget install --silent --accept-package-agreements --accept-source-agreements Microsoft.VisualStudioCode
    Start-Sleep -Seconds 5

    # Refresh environment variables for the current session
    $env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')

    $codeVersion = & code --version 2>&1
    if ($codeVersion -match '^\d+\.\d+\.\d+') {
        Write-Info "VS Code installed successfully: $($codeVersion -split "`n")[0]"
    } else {
        Write-ErrorMsg 'VS Code installation failed. Please check manually.'
        $failures += "VS Code installation failed"
    }
}

# --- Step 5: Install VS Code extensions ---
Write-Host @'
===============================================
  [ Step 5/10: Installing VS Code extensions ]
===============================================
'@ -ForegroundColor Magenta

$extensions = @(
    'ms-python.python',
    'ms-python.vscode-pylance',
    'ms-toolsai.jupyter',
    'ms-vscode.vscode-serial-monitor'
)
foreach ($ext in $extensions) {
    Write-Info "Checking for VS Code extension: $ext"
    code --install-extension $ext | Out-Null
}

# --- Step 6: Clone the repository ---
Write-Host @'
===================================================
  [ Step 6/10: Cloning the repository to Desktop ]
===================================================
'@ -ForegroundColor Magenta

if (-not (Test-Path $repoName)) {
    try {
        Write-Info "Cloning repository from $repoLink..."
        $cloneResult = git clone $repoLink $repoName  2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Info 'Repository cloned successfully.'
        } else {
            Write-ErrorMsg "Git clone failed. Error: $cloneResult"
            $failures += "Git clone failed"
        }
    } catch {
        Write-ErrorMsg "An error occurred while trying to clone the repository: $_"
        $failures += "Git clone error"
    }
} else {
    Write-Info 'Repository already exists. Skipping clone.'
}

    # try {
    #     Set-Location $repoName
    #     Write-Info "Switching to branch: $gitBranch"
    #     git checkout $gitBranch
    # } catch {
    #     Write-ErrorMsg "An error occurred while trying to switch branches: $_"
    #     $failures += "Git checkout branch error"
    # }


# --- Step 7: Create a virtual environment and install dependencies ---
Write-Host @'
=========================================================
   [ Step 7/10: Setting up Python virtual environment ]
=========================================================
'@ -ForegroundColor Magenta

if (Test-Path $pythonVenvPath) {
    Set-Location $pythonVenvPath
    
    try {
        Write-Info "Running 'uv sync' to install Python dependencies..."
        $uvSyncResult = & uv sync 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Info "uv sync completed successfully."
        } else {
            Write-ErrorMsg "uv sync failed. Error: $uvSyncResult"
            $failures += "uv sync failed"
        }
    } catch {
        Write-ErrorMsg "An error occurred while trying to run 'uv sync': $_"
        $failures += "uv sync error"
    }

    $pyCommand =  uv python list --only-installed --managed-python
    Set-Location $desktopPath
} else {
    Write-ErrorMsg "Appropriate folder not found for virtual environment."
    $failures += "Python virtual environment setup failed"
}

# --- Step 8: Stash - Pull - Stash Pop ---
Write-Host @'
=========================================================
  [ Step 8/10: Stash - Pull - Stash Pop ]
=========================================================
'@ -ForegroundColor Magenta

if (Test-Path $repoPath) {
    Set-Location $repoPath
    try {

        if ( git diff-index --quiet HEAD -- ) {
            Write-Info "No changes to stash."
        } else {
            Write-Info "Changes detected. Stashing..."
            git stash push -m "Stashed changes before script execution" | Out-Null
        }
        
        Write-Info "Pulling latest changes..."
        git pull | Out-Null
        
        Write-Info "Pull completed successfully."
        # init and sync ysp-esp32-mesh-firmware submodule
        set-location $repoPath\ysp-esp32-mesh-firmware
        git submodule init | Out-Null
        git submodule update | Out-Null
        Write-Info "Submodule initialized and updated successfully."
        
        git pull origin main | Out-Null
        Write-Info "Pull from main branch completed successfully."

        # Check if stash was created
        if (git stash list | Select-String -Pattern "Stashed changes before script execution") {
            Write-Info "Stash Found, applying stashed changes..."
            git stash pop | Out-Null

        } else {
            Write-Info "No stash found."
        }
        
        Write-Info "Stash - Pull - Stash Pop completed successfully."
    } catch {
        Write-ErrorMsg "An error occurred during stash, pull, or stash pop: $_"
        $failures += "Git stash/pull/pop failed"
    }
} else {
    Write-ErrorMsg 'Appropriate folder not found for Git operations.'
    $failures += "Git operations failed"
}

Write-Host @'
===========================================================
  [ Step 9/10: Updating Python Dependencies for Mesh Firmware Python Interface ]
===========================================================
'@ -ForegroundColor Magenta

if (Test-Path $meshPythonPath) {
    Set-Location $meshPythonPath
    try {
        Write-Info "Running 'uv sync' in mesh Python interface folder..."
        $uvSyncResult = & uv sync 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Info "uv sync completed successfully in mesh Python interface."
        } else {
            Write-ErrorMsg "uv sync failed in mesh Python interface. Error: $uvSyncResult"
            $failures += "uv sync in mesh Python interface failed"
        }
    } catch {
        Write-ErrorMsg "An error occurred while trying to run 'uv sync' in mesh Python interface: $_"
        $failures += "uv sync in mesh Python interface error"
    }
} else {
    Write-ErrorMsg 'Mesh Python interface folder not found.'
    $failures += "Mesh Python interface folder not found"
}


# --- Step 9: Open VS Code in appropriate folder ---
Write-Host @'
===========================================================
  [ Step 10/10: Opening VS Code in the appropriate folder ]
===========================================================
'@ -ForegroundColor Magenta

if (Test-Path $meshPythonPath) {
    Write-Info "Opening VS Code in: $meshPythonPath"
    code $meshPythonPath
} else {
    Write-ErrorMsg 'Appropriate folder not found. Please check manually.'
    $failures += "Opening VS Code in appropriate folder failed"
}

# --- Final Summary ---
Write-Host @'
=========================================
             [ Final Summary ]
=========================================
'@ -ForegroundColor Cyan

Set-Location $repoPath

if ($failures.Count -eq 0) {
    Write-Host "All steps completed successfully!" -ForegroundColor Green
} else {
    Write-Host "$($failures.Count) step(s) failed:" -ForegroundColor Yellow
    $failures | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
}

if ($pyCommand) {
    Write-Host "Python is available at alias: $pyCommand" -ForegroundColor Green
} else {
    Write-Host "Python was not installed successfully." -ForegroundColor Red
}
Read-Host 'Press Enter to exit.'
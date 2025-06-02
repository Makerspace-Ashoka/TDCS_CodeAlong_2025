# --- Variables ---
$desktopPath = [System.Environment]::GetFolderPath('Desktop')
$repoName = 'Makerspace_YSP_TDCS'
$repoLink = 'https://github.com/Makerspace-Ashoka/YSP_TDCS_2025.git'
$pythonVenvPath = "$desktopPath\$repoName\python-interface\src\"

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
  [ Step 1/8: Checking for Winget ]
======================================
'@ -ForegroundColor Magenta

$winget = Get-Command winget -ErrorAction SilentlyContinue
if (-not $winget) {
    Write-ErrorMsg 'Winget not found. Opening Microsoft Store to install App Installer.'
    Start-Process 'ms-windows-store://pdp/?productid=9NBLGGH4NNS1'
    Read-Host 'Please install App Installer, then press Enter to continue...'
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
  [ Step 2/8: Checking for Git ]
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

# --- Step 3: Python ---
Write-Host @'
=====================================
  [ Step 3/8: Checking for Python ]
=====================================
'@ -ForegroundColor Magenta

$pyCommand = $null
$pythonAliases = @('python', 'python3', 'py')
foreach ($alias in $pythonAliases) {
    try {
        $pyVersion = & $alias --version 2>&1
        if ($pyVersion -match 'Python \d+\.\d+') {
            $pyCommand = $alias
            Write-Info "Python found: $pyVersion (using alias: $pyCommand)"
            break
        }
    } catch { }
}

if (-not $pyCommand) {
    Write-Info 'Python not found. Installing...'
    winget install --silent --accept-package-agreements --accept-source-agreements Python.Python.3.12
    Start-Sleep -Seconds 5
    # Recheck installation
    foreach ($alias in $pythonAliases) {
        try {
            $pyVersion = & $alias --version 2>&1
            if ($pyVersion -match 'Python \d+\.\d+') {
                $pyCommand = $alias
                Write-Info "Python installed successfully: $pyVersion (using alias: $pyCommand)"
                break
            }
        } catch { }
    }
    if (-not $pyCommand) {
        Write-ErrorMsg 'Python installation failed. Please check manually.'
        $failures += "Python installation failed"
    }
}

# --- Step 4: Visual Studio Code ---
Write-Host @'
=================================================
  [ Step 4/8: Checking for Visual Studio Code ]
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
  [ Step 5/8: Installing VS Code extensions ]
===============================================
'@ -ForegroundColor Magenta

$extensions = @(
    'ms-python.python',
    'ms-python.vscode-pylance',
    'ms-toolsai.jupyter',
    'ms-vscode.vscode-serial-monitor'
)
foreach ($ext in $extensions) {
    Write-Info "Installing VS Code extension: $ext"
    code --install-extension $ext | Out-Null
}

# --- Step 6: Clone the repository ---
Write-Host @'
===================================================
  [ Step 6/8: Cloning the repository to Desktop ]
===================================================
'@ -ForegroundColor Magenta

if (-not (Test-Path $repoName)) {
    try {
        Write-Info "Cloning repository from $repoLink..."
        $cloneResult = git clone $repoLink $repoName 2>&1
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


# --- Step 7: Create a virtual environment and install dependencies ---
Write-Host @'
=========================================================
   [ Step 7/8: Setting up Python virtual environment ]
=========================================================
'@ -ForegroundColor Magenta

if (Test-Path $pythonVenvPath) {
    Set-Location $pythonVenvPath
    if (-not (Test-Path ".venv")) {
        Write-Info "Creating virtual environment in $pythonVenvPath\.venv..."
        & $pyCommand -m venv .venv
        if ($LASTEXITCODE -eq 0) {
            Write-Info "Virtual environment created."
        } else {
            Write-ErrorMsg "Failed to create virtual environment."
            $failures += "Virtual environment creation failed"
        }
    } else {
        Write-Info "Virtual environment already exists. Skipping creation."
    }

    # Activate the virtual environment
    $venvActivate = Join-Path $pythonVenvPath ".venv\Scripts\Activate.ps1"
    if (Test-Path $venvActivate) {
        Write-Info "Activating virtual environment..."
        & $venvActivate

        # Install dependencies
        $requirementsFile = Join-Path $pythonVenvPath "requirements.txt"
        if (Test-Path $requirementsFile) {
            Write-Info "Installing Python dependencies from requirements.txt..."
            & $pyCommand -m pip install --upgrade pip
            & $pyCommand -m pip install -r $requirementsFile
            if ($LASTEXITCODE -eq 0) {
                Write-Info "Dependencies installed successfully."
            } else {
                Write-ErrorMsg "Failed to install dependencies."
                $failures += "Python dependencies installation failed"
            }
        } else {
            Write-Info "requirements.txt not found. Skipping dependency installation."
        }
    } else {
        Write-ErrorMsg "Could not find .venv activation script."
        $failures += "Virtual environment activation failed"
    }
    Set-Location $desktopPath
} else {
    Write-ErrorMsg "Appropriate folder not found for virtual environment."
    $failures += "Python virtual environment setup failed"
}

# --- Step 8: Open VS Code in appropriate folder ---
Write-Host @'
===========================================================
  [ Step 8/8: Opening VS Code in the appropriate folder ]
===========================================================
'@ -ForegroundColor Magenta

if (Test-Path $pythonVenvPath) {
    Write-Info "Opening VS Code in: $pythonVenvPath"
    code $pythonVenvPath "$pythonVenvPath\workspace.py"
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
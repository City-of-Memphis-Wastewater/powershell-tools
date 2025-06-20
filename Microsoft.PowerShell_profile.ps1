Set-Alias np "notepad++"
Set-Alias nano "notepad++" # blasphemy

$env:PYENV = "$HOME\.pyenv\pyenv-win"
$env:PYENV_ROOT = "$HOME\.pyenv\pyenv-win"
$env:PYENV_HOME = "$HOME\.pyenv\pyenv-win"
$env:Path += ";$env:PYENV\bin;$env:PYENV\shims"

# Manually set up the pyenv environment
function Invoke-PyenvInit {
    # Update PATH to include pyenv directories
    $pyenvShims = "$env:PYENV\shims"
    $pyenvBin = "$env:PYENV\bin"
    $env:PATH = "$pyenvBin;$pyenvShims;$env:PATH"
}
Invoke-PyenvInit

# Print the contents of the current directory by adding ls to the start of a poetry python -m call with dot notation.
# Specifically for usage with poetry or python -m calls.
# The downside: no tab completion.
function lspoetry($modpath) {
    # Remove 'run python -m ' or just 'python -m ' if present.
    $modpath = ($modpath -replace 'run python -m', '').Trim()
	$modpath = ($modpath -replace 'python -m', '').Trim()
    $fsPath = ($modpath -replace '\.', '/')
	$srcPath = Join-Path -Path "src/" -ChildPath $fsPath

    if (Test-Path $fsPath -PathType Container) {
        # Directory → hand it off to ls
        ls $fsPath
    }
    elseif (Test-Path "$fsPath.py" -PathType Leaf) {
        # .py file → hand it off to ls
        ls "$fsPath.py"
    }
	
	elseif (Test-Path $srcPath -PathType Container) {
        # Directory → hand it off to ls
        ls $srcPath
    }
    elseif (Test-Path "$srcPath.py" -PathType Leaf) {
        # .py file → hand it off to ls
        ls "$srcPath.py"
    }
    else {
        Write-Output "Path not found: $fsPath or $fsPath.py or $srcPath or $srcPath.py"
    }
}

# Print the contents of the current file by adding cat to the start of a poetry python -m call with dot notation.
# Specifically for usage with poetry or python -m calls.
# The downside: no tab completion.
function catpoetry($modpath) {
    # Remove 'run python -m ' or just 'python -m ' if present.
    $modpath = ($modpath -replace 'run python -m', '').Trim()
	$modpath = ($modpath -replace 'python -m', '').Trim()
    $fsPath = ($modpath -replace '\.', '/')
	$srcPath = Join-Path -Path "src" -ChildPath $fsPath

    if (Test-Path "$fsPath.py" -PathType Leaf) {
        # .py file → hand it off to cat
        cat "$fsPath.py"
    }
	
    elseif (Test-Path "$srcPath.py" -PathType Leaf) {
        # .py file → hand it off to cat
        cat "$srcPath.py"
    }
	
	elseif (Test-Path $fsPath -PathType Container) {
        # Directory 
        Write-Output "$fsPath is a directory, not a file."
    }
	elseif (Test-Path $srcPath -PathType Container) {
        # Directory 
        Write-Output "$srcPath is a directory, not a file."
    }
    else {
        Write-Output "Path not found: $fsPath or $fsPath.py or $srcPath or $srcPath.py"
    }
}

Remove-Item Alias:curl # Solution to a common PowerShell issue

# same as ii . ; can be used PS1 in scripts
function Open-FileBrowser {
    Add-Type -AssemblyName System.Windows.Forms

    # Get the current PowerShell directory
    $currentDir = (Get-Location).Path

    $fileBrowser = New-Object System.Windows.Forms.OpenFileDialog

    # Set the initial directory to the current PowerShell directory
    $fileBrowser.InitialDirectory = $currentDir

    $null = $fileBrowser.ShowDialog()

    if ($fileBrowser.FileName) {
        $selectedFile = $fileBrowser.FileName
        Write-Host "Selected file: $selectedFile"
    } else {
        Write-Host "No file selected."
    }
}

# Allow for line completion and hints
Import-Module PSReadLine

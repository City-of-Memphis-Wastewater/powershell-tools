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



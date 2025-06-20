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

# TLDR
```poetry``` users will enjoy [catpoetry](https://github.com/City-of-Memphis-Wastewater/powershell-tools/blob/main/catpoetry.ps1) and [lspoetry](https://github.com/City-of-Memphis-Wastewater/powershell-tools/blob/main/lspoetry.ps1) custom functions.
Learn more about ```poetry``` [here](https://github.com/python-poetry/poetry).

# Overview
Notepad++, pyenv, and poetry are key parts of my Python devloper workflow in PowerShell. Here I share my PowerShell $profile (Microsoft.PowerShell_profile.ps1) file.

# Novel Contributions: catpoetry, lspoetry
Novel contributions to the community: 
- **lspoetry**
- **catpoetry**
 
These two functions allow you to use ```ls``` and ```cat``` functionality without having to spend time altering your ```poetry run python -m``` call.

## Before catpoetry
```
poetry run python -m project.folder.script
# --> manually edit, annoying, time-consuming
cat project/folder/script.py
```
## After, with catpoetry

```
poetry run python -m project.folder.script
# --> manually edit, easy :)
catpoetry run python -m project.folder.script
```

## Before lspoetry
```
poetry run python -m project.folder.subfolder
# --> manually edit, annoying, time-consuming
ls project/folder/subfolder/
```
## After, with lspoetry

```
poetry run python -m project.folder.subfolder
# --> manually edit, easy :)
lspoetry run python -m project.folder.subfolder
```

# Not included here:
Set-Location "$env:USERPROFILE\your\special\dir" 

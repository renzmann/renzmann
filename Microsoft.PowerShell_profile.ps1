Function global:prompt {
    "`nPS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) ";
}

Set-PSReadlineOption -BellStyle None

Set-PSReadLineOption -EditMode Emacs
$Env:Path += ";$Env:APPDATA\Python\Scripts"
$Env:Path += ";C:\Mingw\bin"
$Env:Path += ";C:\cygwin64\bin"
$Env:Path += ";$Env:APPDATA\npm"
$Env:XDG_CONFIG_HOME = "$Env:LOCALAPPDATA"
$Env:XDG_DATA_HOME = "$Env:LOCALAPPDATA"
$Env:XDG_CONFIG_DIRS = "$Env:APPDATA"
$Env:XDG_DATA_DIRS = "$Env:APPDATA"

# $folders = @($Env:XDG_CONFIG_HOME,$Env:XDG_DATA_HOME,$Env:XDG_STATE_HOME,$Env:XDG_CACHE_HOME)
# ForEach ($f in $folders) {
#     if (!$(Test-Path $f)) {
#         New-Item $f -ItemType Directory
#     }
# }
# Remove-Variable folders

Function Install-Vimplug {
    Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    New-Item "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
}

Function Install-Poetry {
   (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python3 -
}

# TODO:
# Install-Julia
# Install-Go
# LspInstall rust-analyzer fails
# Treesitter modules causing fatal crash on Windows. Bad `cc` or something else?

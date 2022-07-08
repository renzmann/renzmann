Function global:prompt {
    "`nPS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) ";
}

Set-PSReadlineOption -BellStyle None

Set-PSReadLineOption -EditMode Emacs
$Env:Path += ";$Env:APPDATA\Python\Scripts"
$Env:Path += ";$Env:APPDATA\Python\Python310\Scripts"
$Env:Path += ";$HOME\.local\bin"
$Env:Path += ";C:\msys64\mingw64\bin"
$Env:Path += ";C:\cygwin64\bin"
$Env:Path += ";$Env:APPDATA\npm"
$Env:XDG_CONFIG_HOME = "$Env:LOCALAPPDATA"
$Env:XDG_DATA_HOME = "$Env:LOCALAPPDATA"
$Env:XDG_CONFIG_DIRS = "$Env:APPDATA"
$Env:XDG_DATA_DIRS = "$Env:APPDATA"

Function Install-Poetry {
   (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python3 -
}

# TODO:
# Install-Julia
# Install-Go
# LspInstall rust-analyzer fails
Function Edit-TerminalSettings {
    # TODO add to dotfiles and symlink here
    nvim $Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
}

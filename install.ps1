# Neovim {{{
if (Test-Path $Env:XDG_CONFIG_HOME\nvim) {
	Remove-Item -Force -Recurse $Env:XDG_CONFIG_HOME\nvim
}
New-Item -Path $Env:XDG_CONFIG_HOME\nvim -ItemType SymbolicLink -Value $PSScriptRoot\.config\nvim
# }}}

# vimrc {{{
if (Test-Path $HOME\vimfiles) {
	Remove-Item -Force -Recurse $HOME\vimfiles
}
New-Item -Path $HOME\vimfiles -ItemType SymbolicLink -Value $PSScriptRoot\.vim
# }}}

# Powershell profile {{{
if (Test-Path $profile) {
	Remove-Item -Force $profile
}
New-Item -Path $profile -ItemType SymbolicLink -Value $PSScriptRoot\Microsoft.PowerShell_profile.ps1
# }}}

# Windows terminal settings {{{
# Copy-Item -Path $Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -ItemType SymbolicLink -Value $PSScriptRoot\windows_terminal_settings.json
# }}}

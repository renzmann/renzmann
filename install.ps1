if (Test-Path $Env:XDG_CONFIG_HOME\nvim) {
	Remove-Item -Force $Env:XDG_CONFIG_HOME\nvim
}
New-Item -Path $Env:XDG_CONFIG_HOME\nvim -ItemType SymbolicLink -Value $PSScriptRoot\.config\nvim

if (Test-Path $profile) {
	Remove-Item -Force $profile
}
New-Item -Path $profile -ItemType SymbolicLink -Value $PSScriptRoot\Microsoft.PowerShell_profile.ps1

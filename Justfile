set shell := ["pwsh.exe", "-c"]

today := `Get-Date -Format 'yyyyMMdd'`
product_name := "wezterm-config"
gpg_pub_key := "CCAA9E0638DF9088BB624BC37C0F8AD3FB3938FC"

default:
	just --list

alias pab := patch-branch

#--------------------
#    patch
#--------------------

patch : clean-patch diff-patch copy2win-patch

diff-patch-raw :
	git diff origin/master > {{product_name}}.{{today}}.patch

#diff-patch-gpg :
#	git diff origin/master | gpg --encrypt --recipient {{gpg_pub_key}} > {{product_name}}.{{today}}.patch.gpg

diff-patch : diff-patch-raw

patch-branch :
	git switch -c patch-{{today}}

switch-master :
	git switch master

delete-branch : switch-master
	git branch --list "patch*" | ForEach-Object{ $_ -replace " ", "" } | ForEach-Object { git branch -d $_ }

clean : clean-patch

clean-patch :
	Remove-Item *.patch

copy2win-patch :
	Copy-Item *.patch $env:USERPROFILE\Downloads\

#--------------------
#    development
#--------------------

lint : stylua-lint

stylua-lint :
	stylua --check ./

fmt : format

format : stylua-format

stylua-format :
	stylua ./

run : copy2win

copy2win :
	cp ./wezterm.lua $env:USERPROFILE/.config/wezterm/wezterm.lua

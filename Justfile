today := `shell date "+%Y%m%d"`
product_name := "wezterm-config"
gpg_pub_key := "CCAA9E0638DF9088BB624BC37C0F8AD3FB3938FC"

set shell := ["pwsh.exe", "-c"]

default:
	just --list

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
#	git branch --list "patch*" | xargs -n 1 git branch -D
    echo "TODO win command"

clean :
    clean.ps1

copy2win-patch : copy2win-patch-raw

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

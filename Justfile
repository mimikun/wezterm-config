set shell := ["pwsh.exe", "-c"]

default:
	just --list

lint : stylua-lint

stylua-lint :
	stylua --check ./

fmt : format

format : stylua-format

stylua-format :
	stylua ./

copy2win :
	cp ./wezterm.lua $env:USERPROFILE/.config/wezterm/wezterm.lua

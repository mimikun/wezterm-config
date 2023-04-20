# wezterm-config

## 目標

Windows向けweztermの設定を完成させる

## 解説

Windowsから編集するときはJustfileでタスクを実行する
Linux(WSL含む)から編集するときはMakefileでタスクを実行する

## TODO

全体的にWindows Terminalと同一の挙動にしていきたい

- [ ] フォントを `FiraCode Nerd Font Mono Retina` にする
- [ ] テキストを選択して `C-c` でコピー
- [ ] 入力画面を選択して `C-v` でペースト
- [x] 会社PCと自宅PCとで読み込む変数を変える
  - 主に `WSL:Ubuntu` のため
- [x] 配色を `GitHub Dark` にする
- [x] フォントサイズを `12pt` にする
- [x] 使用するシェルを以下から選べるようにする
  - [x] WSL(Ubuntu) **デフォルト**
  - [x] Windows PowerShell(PowerShell v5.1)
  - [x] PowerShell(PowerShell v7)
  - [x] cmd.exe
- [x] `C-t` で新しくタブを開く

# wezterm-config

## 目標

Windows向けweztermの設定を完成させる

## 解説

Windowsから編集するときはJustfileでタスクを実行する
Linux(WSL含む)から編集するときはMakefileでタスクを実行する

## TODO

全体的にWindows Terminalと同一の挙動にしていきたい

- [ ] フォントを `FiraCode Nerd Font Mono Retina` にする
- [x] 配色を `GitHub Dark` にする
- [ ] テキストを選択して `C-c` でコピー
- [ ] 入力画面を選択して `C-v` でペースト
- [x] フォントサイズを `12pt` にする
- [ ] 使用するシェルを以下から選べるようにする
  - [ ] WSL(Ubuntu) **デフォルト**
  - [ ] Windows PowerShell(PowerShell v5.1)
  - [ ] PowerShell(PowerShell v7)
  - [ ] cmd.exe
- [x] `C-t` で新しくタブを開く

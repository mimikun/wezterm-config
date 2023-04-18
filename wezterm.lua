local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- os.dateによって返却された数値から曜日を判定し、漢字に変換する
-- (曜日, 1–7, 日曜日が 1)
local function day_of_week_ja(w_num)
  if w_num == 1 then
    return "日"
  elseif w_num == 2 then
    return "月"
  elseif w_num == 3 then
    return "火"
  elseif w_num == 4 then
    return "水"
  elseif w_num == 5 then
    return "木"
  elseif w_num == 6 then
    return "金"
  elseif w_num == 7 then
    return "土"
  end
end

-- 年月日と時間をステータスバーに表示する
-- ウィンドウが最初に表示されてから1秒後に開始され、1秒に1回トリガーされるイベント
wezterm.on("update-status", function(window, pane)
  -- 日付のtableを作成する方法じゃないと曜日の取得がうまくいかなかった
  -- NOTE: https://www.lua.org/pil/22.1.html
  local wday = os.date("*t").wday
  -- 指定子の後に半角スペースをつけないと正常に表示されなかった
  local wday_ja = string.format("(%s)", day_of_week_ja(wday))
  local date = wezterm.strftime("📆 %Y-%m-%d " .. wday_ja .. " ⏰ %H:%M:%S")

  window:set_right_status(wezterm.format({
    { Text = date .. "  " },
  }))
end)

-- タブの表示をカスタマイズ
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local tab_index = tab.tab_index + 1

  -- Copymode時のみ、"Copymode..."というテキストを表示
  if tab.is_active and string.match(tab.active_pane.title, "Copy mode:") ~= nil then
    return string.format(" %d %s ", tab_index, "Copy mode...")
  end

  return string.format(" %d ", tab_index)
end)

-- 色の設定
local base_colors = {
  dark = "#172331",
  yellow = "#ffe64d",
}

config.colors = {
  cursor_bg = base_colors["yellow"],
  split = "#6fc3df",
  -- the foreground color of selected text
  selection_fg = base_colors["dark"],
  -- the background color of selected text
  selection_bg = base_colors["yellow"],
  tab_bar = {
    background = base_colors["dark"],
    -- The active tab is the one that has focus in the window
    active_tab = {
      bg_color = "aliceblue",
      fg_color = base_colors["dark"],
    },
    -- plus button hidden
    new_tab = {
      bg_color = base_colors["dark"],
      fg_color = base_colors["dark"],
    },
  },
}

-- キーバインドの設定
-- leader keyを CTRL + qにマッピング
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- CMD + Tでタブを新規作成
  {
    key = "t",
    mods = "LEADER",
    action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
  },
  -- CMD + Wでタブを閉じる
  {
    key = "w",
    mods = "LEADER",
    action = wezterm.action({ CloseCurrentTab = { confirm = true } }),
  },
  -- CTRL + q + numberでタブの切り替え
  {
    key = "1",
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = 0 }),
  },
  {
    key = "2",
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = 1 }),
  },
  {
    key = "3",
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = 2 }),
  },
  {
    key = "4",
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = 3 }),
  },
  {
    key = "5",
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = 4 }),
  },
  {
    key = "6",
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = 5 }),
  },
  {
    key = "7",
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = 6 }),
  },
  {
    key = "8",
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = 7 }),
  },
  {
    key = "9",
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = 8 }),
  },
  -- PANEを水平方向に開く
  {
    key = "-",
    mods = "LEADER",
    action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
  },
  -- PANEを縦方向に開く
  {
    key = "|",
    mods = "LEADER",
    action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
  },
  -- hjklでPANEを移動する
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action({ ActivatePaneDirection = "Left" }),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action({ ActivatePaneDirection = "Right" }),
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action({ ActivatePaneDirection = "Up" }),
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action({ ActivatePaneDirection = "Down" }),
  },
  -- PANEを閉じる
  { key = "x", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
  -- ALT + hjklでペインの幅を調整する
  {
    key = "h",
    mods = "ALT",
    action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }),
  },
  {
    key = "l",
    mods = "ALT",
    action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }),
  },
  {
    key = "k",
    mods = "ALT",
    action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }),
  },
  {
    key = "j",
    mods = "ALT",
    action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }),
  },
  -- QuickSelect・・・画面に表示されている文字をクイックにコピペできる機能
  {
    key = "Enter",
    mods = "SHIFT",
    action = "QuickSelect",
  },
}

config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = 450, stretch = "Normal", style = "Normal" })
config.font_size = 12
config.line_height = 1
config.color_scheme = "GitHub Dark"
config.use_fancy_tab_bar = false
config.use_ime = true
-- アクティブではないペインの彩度を変更しない
config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1,
}
-- Work PC
--config.default_domain = "WSL:Ubuntu-20.04"
-- Home PC
config.default_domain = "WSL:Ubuntu"

return config

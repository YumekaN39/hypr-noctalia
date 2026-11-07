-- 窗口规则
--
-- 对应 ~/.config/sway/window_rules + sway/options 里的 for_window，
-- 以及原来 hyprland.lua 中仍然通用的规则（DMS 专属规则已去掉）。

-- ============================================================
-- 浮动窗口
-- ============================================================
-- Nautilus 以浮动窗口打开（Wayland app_id / XWayland class 都覆盖）
hl.window_rule({ match = { class = "^(org\\.gnome\\.Nautilus)$" }, float = true })
hl.window_rule({ match = { class = "(?i)^nautilus$" }, float = true })

hl.window_rule({ match = { class = "^(org\\.gnome\\.Calculator)$" }, float = true })
hl.window_rule({ match = { class = "^(gnome-calculator)$" }, float = true })
hl.window_rule({ match = { class = "^(galculator)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal)$" }, float = true })
hl.window_rule({ match = { class = "^(zoom)$" }, float = true })

-- ============================================================
-- 透明度 / 模糊
-- ============================================================
hl.window_rule({ match = { class = "^(firefox|firefox-esr)$" }, opacity = "0.98" })
hl.window_rule({ match = { class = "^(code|com\\.microsoft\\.VSCode)$" }, opacity = "0.98" })
hl.window_rule({ match = { class = "^(kitty)$" }, opacity = "0.95" })

-- ============================================================
-- 其他保留的窗口行为
-- ============================================================
hl.window_rule({ match = { class = "^(org\\.wezfurlong\\.wezterm)$" }, tile = true })
hl.window_rule({ match = { class = "^(gnome-control-center)$" }, tile = true })
hl.window_rule({ match = { class = "^(pavucontrol)$" }, tile = true })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, tile = true })

-- Steam 通知不抢焦点
hl.window_rule({
	match = { class = "^(steam)$", title = "^(notificationtoasts)" },
	no_initial_focus = true,
	pin = true,
})

-- Firefox 画中画浮动
hl.window_rule({
	match = { class = "^(firefox|firefox-esr)$", title = "^(Picture-in-Picture)$" },
	float = true,
})

-- 当工作区处于最大化状态（f[1]）时，取消外边距和内边距
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

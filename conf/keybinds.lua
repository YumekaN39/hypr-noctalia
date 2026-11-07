-- 快捷键（基准：~/.config/sway/config，$mod = Mod4 = SUPER）
--
-- sway 的 IPC 命令在 Hyprland 里照旧用 noctalia msg 调用，
-- 因此这一份和 sway 的手感保持一致。

local mod = "SUPER"
local term = "foot"
local fileManager = "nautilus"
local ipc = "noctalia msg"

-- ============================================================
-- 启动器 / Noctalia 面板
-- ============================================================
hl.bind(mod .. " + space", hl.dsp.exec_cmd(ipc .. " panel-toggle launcher"))
hl.bind(mod .. " + S", hl.dsp.exec_cmd(ipc .. " panel-toggle control-center"))
hl.bind(mod .. " + comma", hl.dsp.exec_cmd(ipc .. " settings-toggle"))
hl.bind(mod .. " + TAB", hl.dsp.exec_cmd(ipc .. " window-switcher"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd(ipc .. " panel-toggle clipboard"))
hl.bind(mod .. " + X", hl.dsp.exec_cmd(ipc .. " panel-toggle session"))

-- ============================================================
-- 截图
-- ============================================================
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd(ipc .. " screenshot-region"))
hl.bind("Print", hl.dsp.exec_cmd(ipc .. " screenshot-region"))

-- ============================================================
-- 程序
-- ============================================================
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mod .. " + T", hl.dsp.exec_cmd(term))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))

-- ============================================================
-- 窗口
-- ============================================================
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))

-- 重载 / 退出（sway 的 mod+Shift+c / mod+Shift+e）
hl.bind(mod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))

-- dwindle 没有 splith/splitv，统一对应到 togglesplit
-- （sway 的 mod+Shift+b / mod+Shift+v）
hl.bind(mod .. " + SHIFT + B", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + SHIFT + V", hl.dsp.layout("togglesplit"))

-- ============================================================
-- 焦点 / 移动窗口（h j k l 与方向键都可用）
-- ============================================================
local moves = {
	{ key = "H", dir = "l" },
	{ key = "J", dir = "d" },
	{ key = "K", dir = "u" },
	{ key = "L", dir = "r" },
	{ key = "left", dir = "l" },
	{ key = "down", dir = "d" },
	{ key = "up", dir = "u" },
	{ key = "right", dir = "r" },
}

for _, m in ipairs(moves) do
	hl.bind(mod .. " + " .. m.key, hl.dsp.focus({ direction = m.dir }))
	hl.bind(mod .. " + SHIFT + " .. m.key, hl.dsp.window.move({ direction = m.dir }))
end

-- ============================================================
-- 工作区 1-10
-- ============================================================
for i = 1, 10 do
	local key = i % 10 -- 10 映射到 0
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	-- 等同 sway 的 "move container to workspace N; workspace N"
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))
end

-- 额外保留的顺手绑定（sway 里没有，但原来 hypr 有）
hl.bind(mod .. " + U", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + I", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- ============================================================
-- Scratchpad（sway 的 scratchpad 对应 special workspace）
-- ============================================================
hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mod .. " + minus", hl.dsp.workspace.toggle_special("magic"))

-- ============================================================
-- 调整大小模式（sway 的 mode "resize"）
-- ============================================================
hl.bind(mod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

	hl.bind("Return", hl.dsp.submap("reset"))
	hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- ============================================================
-- 音量 / 亮度（Noctalia IPC，等同 sway 的 --locked 绑定）
-- ============================================================
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume-up"), {
	locked = true,
	repeating = true,
})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume-down"), {
	locked = true,
	repeating = true,
})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume-mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. " mic-mute"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness-up"), {
	locked = true,
	repeating = true,
})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness-down"), {
	locked = true,
	repeating = true,
})

-- ============================================================
-- 鼠标：按住 SUPER 左键拖动、右键缩放（等同 sway floating_modifier）
-- ============================================================
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

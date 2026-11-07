-- 外观与输入（对应 ~/.config/sway/options 里的外观部分）
--
-- sway 的设置                  → Hyprland 对应项
--   default_border pixel 1     → general.border_size = 1
--   corner_radius 0            → decoration.rounding = 0
--   gaps（未启用）              → gaps_in / gaps_out = 0
--   blur_xray enable           → decoration.blur.xray = true
--   blur_passes 2              → decoration.blur.passes = 2
--   blur_radius 5              → decoration.blur.size = 8（Hyprland 的 size 比 swayfx 的 radius 轻，适当加大）
--   input type:touchpad {...}  → input.touchpad {...}

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 12,
		border_size = 2,
		layout = "dwindle",
		resize_on_border = false,
	},

	decoration = {
		rounding = 16,
		active_opacity = 0.95,
		inactive_opacity = 0.8,

		blur = {
			enabled = true,
			size = 4,
			passes = 3,
			xray = false,
			new_optimizations = true,
		}
	},

	animations = {
		enabled = true,
	},

	-- 触摸板、键盘
	input = {
		-- 留空表示继承 XKB_DEFAULT_LAYOUT，和 sway 一样交给环境决定
		kb_layout = "",
		numlock_by_default = true,
		-- sway 默认 focus_follows_mouse yes
		follow_mouse = 1,
		touchpad = {
			tap_to_click = true,
			natural_scroll = true,
			middle_button_emulation = true,
			disable_while_typing = true,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

-- Spring曲线
hl.curve( "rubber", { type = "spring", mass = 1, stiffness = 1234, damping = 100 } )

-- 匹配最大化工作区中的非浮动窗口，去掉边框
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })

-- 动画（曲线为 Hyprland 内置的 default；扁平、轻量，不做过冲）
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "default" })
-- 关闭：缩小 + 淡出，和 1px 无圆角的扁平风格更搭
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "default", style = "popin 80%" })
-- 切工作区：滑动 + 淡入淡出
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default", style = "slidefade 20%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, spring = "rubber" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "default" })

-- 三指水平滑动切换工作区（原来的设置）
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

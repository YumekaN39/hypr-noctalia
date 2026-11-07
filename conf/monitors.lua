-- 显示器（原 dms/outputs.lua，用 swaymsg -t get_outputs 可查名称）

hl.monitor({ output = "", mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60.056",
	position = "0x0",
	scale = 1,
	vrr = 0,
})

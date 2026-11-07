-- 1. 引入 Noctalia 生成的主题文件（这一步会把它的 table 拿过来）
-- 注意：这里 require 的路径取决于你的目录结构，如果是同级目录就是 "./theme"
local colors = require("noctalia").colors

-- 2. 提取颜色值
local primary_rgb = colors.primary -- 拿到 "rgb(b7c4ff)"
local surface_rgb = colors.surface -- 拿到 "rgb(121317)"

-- 3. Lua 字符串替换：把 "rgb" 替换成 "rgba"
-- 并在末尾加上透明度。比如 "aa" 代表半透明
local primary_shadow = primary_rgb:gsub("rgb", "rgba"):gsub("%)", "20)") 
local surface_shadow = surface_rgb:gsub("rgb", "rgba"):gsub("%)", "ff)")

-- 4. 覆盖 Hyprland 的阴影配置
hl.config({
    decoration = {
        shadow = {
            enabled = true,
            range = 6,             -- 阴影扩散范围（发光范围）
            render_power = 4,       -- 阴影渲染平滑度
            color = primary_shadow, -- 焦点窗口阴影：读取 primary 并转为 rgba
            color_inactive = surface_shadow, -- 非焦点窗口阴影：读取 surface 并设为全透明
        },
    },
})

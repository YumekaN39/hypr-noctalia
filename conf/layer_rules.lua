-- 图层规则（bar、面板等非窗口的 layer surface）

-- Noctalia 的 bar 模糊（sway: layer_effects "noctalia-bar-*" blur enable）
-- xray 对应 sway 的 blur_xray，让图层模糊不叠加在平铺窗口上
hl.layer_rule({ match = { namespace = "^noctalia-bar" }, blur = true, xray = true })

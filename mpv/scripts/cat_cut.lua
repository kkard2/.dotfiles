local mp = require("mp")

local cut_ab = function()
    local a = mp.get_property_number("ab-loop-a")
    local b = mp.get_property_number("ab-loop-b")

    if a == nil or b == nil then
        mp.msg.error("ab loop not set")
        return
    end

    if a > b then
        a, b = b, a
    end

    --- @type string
    local path = mp.get_property("path")
    local i = 1
    local last_dot_idx = nil
    while i <= #path do
        if path:sub(i, i) == "." then
            last_dot_idx = i
        end
        i = i + 1
    end

    if last_dot_idx == nil then
        mp.msg.error("could not parse path: " .. path)
        return
    end

    local target_path = path:sub(1, last_dot_idx) .. a .. "-" .. b .. path:sub(last_dot_idx, nil)

    mp.commandv(
        "run", "ffmpeg",
        "-ss", a,
        "-to", b,
        "-i", path,
        "-c", "copy",
        target_path)
end

mp.add_key_binding("c", cut_ab)

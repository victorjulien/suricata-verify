function init(args)
    return {}
end

function match(args)
    msg = SCRuleMsg()

    if msg == "FOO" then
        return 1
    else
        return 0
    end
end

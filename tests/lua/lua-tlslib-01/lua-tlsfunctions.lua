-- simple output test for some lua flow lib functions
name = "tlslib_lua.log"

local tls = require("suricata.tls")
local logger = require("suricata.log")
local config = require("suricata.config")

function init (args)
    local needs = {}
    needs["protocol"] = "tls"
    return needs
end

function setup (args)
    filename = config.log_path() .. "/" .. name
    file = assert(io.open(filename, "a"))
    logger.info("Log Filename " .. filename)
    http = 0
end

function ternary(var, T, F)
    if var == nil then return T else return F end
end

function log(args)
    local t, err = tls.get_tx()
    if t == err then
        print(err)
    end
    cl_version = t:get_client_version()
    sv_version = t:get_server_version()
    msg = string.format(
        "client version: %s  server_version: %s\n",
        ternary(cl_version, "na-cl-version", cl_version),
        ternary(sv_version, "na-sv-version", sv_version))
    file:write(msg)
    file:flush()
end

function deinit (args)
    file:close(file)
end

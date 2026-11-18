---@version: 5.4, 5.5

if tonumber(_VERSION:sub(5)) < 5.4 then
    error("expected: lua >= 5.4 \n recive: " .. _VERSION)
end

---@alias Virtual_Type_Default_Lua_Types
---| "nil"
---| "number"
---| "string"
---| "boolean"
---| "table"
---| "function"
---| "thread"
---| "userdata"

---@generic T: string
---@class Virtual_Type_Obj<T>: table<any, any>
---@field __vtype T|nil


---@class Virtual_Type_Module
---@operator call(any):string
local Virtual_Type_Module <const> = {
    __AUTHOR = "davi/pessoa736",
    __LICENSE = "MIT",
    __DECRIPTION = "symbolics types in lua",
    __VERSION = "0.0.1",
}


---@generic T: string
---@param obj Virtual_Type_Obj<T>|any
---@return T|Virtual_Type_Default_Lua_Types
function Virtual_Type_Module:vtype(obj)
    if type(obj) == "table" then
        local vt = obj.__vtype
        if vt ~= nil then
            if type(vt) ~= "string" then
                error(("invalid __vtype: expected string, got %s"):format(type(vt)), 2)
            end
            return vt
        end
    end

    return type(obj)
end

---@param obj any
---@param ... string|Virtual_Type_Default_Lua_Types
---@return boolean
function Virtual_Type_Module:MultOrVerify(obj, ...)
    local t = self:vtype(obj)
    for i = 1, select("#", ...) do
        if t == select(i, ...) then
            return true
        end
    end
    return false
end

---@generic T: string
---@param obj table
---@param vt T
---@return Virtual_Type_Obj<T>
function Virtual_Type_Module:set(obj, vt)
    if type(obj) ~= "table" then
        error("invalid object: expected table, got " .. type(obj), 2)
    end
    if type(vt) ~= "string" then
        error("invalid vtype: expected string, got " .. type(vt), 2)
    end

    obj.__vtype = vt
    return obj
end

setmetatable(Virtual_Type_Module, {
    __call = function(t, val) return t:vtype(val) end
})

---@cast Virtual_Type_Module +fun(obj: Virtual_Type_Obj<string>):string
return Virtual_Type_Module


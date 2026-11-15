# luaVirtualTypes

Symbolic (virtual) types for Lua.

Lua's built-in `type()` only knows eight types, and every table is just a `"table"`. **luaVirtualTypes** lets you tag a table with a custom type name stored in a `__vtype` field, and then query it the same way you would use `type()`.

```lua
local vtype = require("luavirtualtypes")

local banana = { __vtype = "fruit" }

print(vtype(banana)) --> fruit
print(vtype("text")) --> string
print(vtype(nil))    --> nil
```

If an object has no `__vtype`, the module falls back to the regular Lua type, so it works as a drop-in replacement for `type()`.

## Requirements

- Lua >= 5.4

## Installation

With [LuaRocks](https://luarocks.org):

```bash
luarocks install luavirtualtypes
```

Or copy `source/init.lua` into your project.

## Usage

### Defining a virtual type

**1) Directly on the object**

```lua
---@type Virtual_Type_Obj<"fruit">
local banana = { __vtype = "fruit" }
```

**2) On an existing object**

```lua
local apple = {}

vtype:set(apple, "fruit")
---@cast apple Virtual_Type_Obj<"fruit">
```

The `@cast` line is optional. It only helps the Lua language server (LuaLS) know the type, because it can't track values assigned at runtime.

### Querying a type

```lua
print(vtype(banana))         --> fruit
print(vtype:vtype(banana))   --> fruit (same thing)
print(vtype(42))             --> number
```

### Checking against several types

```lua
if vtype:MultOrVerify(obj, "fruit", "vegetable") then
    print("it's food")
end
```

`MultOrVerify` returns `true` if the type of `obj` matches **any** of the given names. Both virtual types and default Lua types are accepted.

## API

| Function | Description |
|---|---|
| `vtype(obj)` | Shortcut for `vtype:vtype(obj)`. |
| `vtype:vtype(obj)` | Returns `obj.__vtype` if `obj` is a table with a string `__vtype`, otherwise `type(obj)`. |
| `vtype:MultOrVerify(obj, ...)` | Returns `true` if the type of `obj` equals any of the given names. |
| `vtype:set(obj, name)` | Sets `obj.__vtype = name` and returns `obj`. |

### Errors

- `vtype:vtype(obj)` raises an error if `obj.__vtype` exists but is not a string.
- `vtype:set(obj, name)` raises an error if `obj` is not a table or `name` is not a string.

### Notes

- `__vtype` is read with normal indexing, so it respects `__index`. A table whose metatable inherits from a "class" will also inherit its virtual type.
- Use `:` (colon) to call the functions. With `.` the first argument is taken as `self`.

## Type annotations

The module ships with [LuaLS](https://github.com/LuaLS/lua-language-server) annotations. To get a precise type in your editor, annotate your objects:

```lua
---@class Fruit: Virtual_Type_Obj<"fruit">
```

## License

MIT, see [LICENSE](LICENSE).

## Author

davi / [pessoa736](https://github.com/pessoa736)
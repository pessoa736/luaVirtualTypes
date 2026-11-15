package = "luavirtualtypes"
version = "dev-1"

source = {
   url = "https://github.com/pessoa736/luaVirtualTypes"
}

description = {
   license = "MIT"
}

dependencies = {
   "lua >= 5.4"
}

build = {
   type = "builtin",
   modules = {
      ["luaVirtualTypes"] = "source/init.lua",
   }
}

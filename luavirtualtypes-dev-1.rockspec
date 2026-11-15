package = "luaVirtualTypes"
version = "dev-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
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
test_dependencies = {
   queries = {}
}

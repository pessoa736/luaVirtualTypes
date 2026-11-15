
package.path =  "./?lua;./?/init.lua;" .. package.path

local vtype = require("source.init")




------------------------------------------------------------------------------------------
---- caminhos para definir vtype / ways to define a vtype.


-----
--- 1) definindo diretamente ao objeto / defining directly on the object.

---@type Virtual_Type_Obj<"fruit">
local banana = {__vtype = "fruit"}

--- ou / or

---@class fruit: Virtual_Type_Obj<"fruit">

---@type fruit
local grappes = {};
grappes.__vtype = "fruit"



-----
---2) atribuindo á objetos ja existentes / assigning to an existing object

local apple = {};

vtype:set(apple, "fruit")
---@cast apple Virtual_Type_Obj<"fruit">


------------------------------------------------------------------------------------------


--- verify vtypes
print(vtype(banana))
print(vtype(apple))
print(vtype(grappes))
print(vtype("text"))
print(vtype(nil))

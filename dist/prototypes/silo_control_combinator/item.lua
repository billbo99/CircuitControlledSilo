local Constants = require("constants")

local combinator = table.deepcopy(data.raw.item["constant-combinator"])
combinator.name = "silo-control-combinator"
combinator.place_result = combinator.name
combinator.icon = Constants.icon_path .. "silo-control-combinator.png"
combinator.icon_mipmaps = nil

data:extend({combinator})

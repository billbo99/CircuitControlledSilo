local Constants = require("constants")

local path = Constants.entity_path .. "/silo-control-combinator/"

local combinator = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
combinator.name = "silo-control-combinator"
combinator.minable.result = combinator.name

combinator.sprites.north.layers[1].filename = string.format("%s/constant-combinator.png", path)
combinator.sprites.north.layers[1].hr_version.filename = string.format("%s/hr-constant-combinator.png", path)
combinator.sprites.east.layers[1].filename = string.format("%s/constant-combinator.png", path)
combinator.sprites.east.layers[1].hr_version.filename = string.format("%s/hr-constant-combinator.png", path)
combinator.sprites.south.layers[1].filename = string.format("%s/constant-combinator.png", path)
combinator.sprites.south.layers[1].hr_version.filename = string.format("%s/hr-constant-combinator.png", path)
combinator.sprites.west.layers[1].filename = string.format("%s/constant-combinator.png", path)
combinator.sprites.west.layers[1].hr_version.filename = string.format("%s/hr-constant-combinator.png", path)

data:extend({combinator})

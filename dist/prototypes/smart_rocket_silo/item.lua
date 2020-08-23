local Constants = require("constants")

local blue_silo = table.deepcopy(data.raw.item["rocket-silo"])
blue_silo.name = "smart-rocket-silo-blue"
blue_silo.order = "e[rocket-silo]-a"
blue_silo.place_result = blue_silo.name
blue_silo.icon = Constants.icon_path .. "rocket-silo-blue.png"
data:extend({blue_silo})

-- local red_silo = table.deepcopy(data.raw.item["rocket-silo"])
-- red_silo.name = "smart-rocket-silo-red"
-- red_silo.order = "e[rocket-silo]-b"
-- red_silo.place_result = red_silo.name
-- red_silo.icon = Constants.icon_path .. "rocket-silo-red.png"
-- data:extend({red_silo})

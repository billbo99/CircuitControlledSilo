local Constants = require("constants")

local function apply_colours(entity, path, colour)
    entity.arm_01_back_animation.filename = string.format("%s/08-rocket-silo-arms-back-%s.png", path, colour)
    entity.arm_01_back_animation.hr_version.filename = string.format("%s/hr-08-rocket-silo-arms-back-%s.png", path, colour)
    entity.arm_02_right_animation.filename = string.format("%s/08-rocket-silo-arms-right-%s.png", path, colour)
    entity.arm_02_right_animation.hr_version.filename = string.format("%s/hr-08-rocket-silo-arms-right-%s.png", path, colour)
    entity.arm_03_front_animation.filename = string.format("%s/13-rocket-silo-arms-front-%s.png", path, colour)
    entity.arm_03_front_animation.hr_version.filename = string.format("%s/hr-13-rocket-silo-arms-front-%s.png", path, colour)
    entity.door_back_sprite.filename = string.format("%s/04-door-back-%s.png", path, colour)
    entity.door_back_sprite.hr_version.filename = string.format("%s/hr-04-door-back-%s.png", path, colour)
    entity.door_front_sprite.filename = string.format("%s/05-door-front-%s.png", path, colour)
    entity.door_front_sprite.hr_version.filename = string.format("%s/hr-05-door-front-%s.png", path, colour)
end

local path = Constants.entity_path .. "/rocket-silo/"

local blue_silo = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
blue_silo.name = "smart-rocket-silo-blue"
blue_silo.minable.result = blue_silo.name
apply_colours(blue_silo, path, "blue")
data:extend({blue_silo})

-- local red_silo = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
-- red_silo.name = "smart-rocket-silo-red"
-- red_silo.minable.result = red_silo.name
-- apply_colours(red_silo, path, "red")
-- data:extend({red_silo})

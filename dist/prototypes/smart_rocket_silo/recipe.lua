local blue_silo = table.deepcopy(data.raw.recipe["rocket-silo"])
blue_silo.name = "smart-rocket-silo-blue"
blue_silo.result = blue_silo.name
blue_silo.energy_required = 60
blue_silo.ingredients = {
    {"rocket-silo", 1},
    {"red-wire", 50},
    {"green-wire", 50},
    {"processing-unit", 50},
    {"constant-combinator", 1}
}
data:extend({blue_silo})

if data.raw.item["deadlock-stack-rocket-part"] then
    local red_silo = table.deepcopy(data.raw.recipe["rocket-silo"])
    red_silo.name = "smart-rocket-silo-red"
    red_silo.result = red_silo.name
    red_silo.energy_required = 60
    red_silo.ingredients = {
        {"rocket-silo", 1},
        {"red-wire", 50},
        {"green-wire", 50},
        {"processing-unit", 50},
        {"constant-combinator", 1}
    }
    data:extend({red_silo})
end

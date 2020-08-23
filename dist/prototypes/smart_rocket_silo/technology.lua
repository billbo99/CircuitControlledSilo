local Constants = require("constants")

local technology = {
    effects = {
        {
            recipe = "smart-rocket-silo-blue",
            type = "unlock-recipe"
        }
    },
    icon = Constants.tech_path .. "smart-rocket-silo.png",
    icon_size = 128,
    name = "smart-rocket-silo",
    order = "k-a",
    prerequisites = {
        "rocket-silo"
    },
    type = "technology",
    unit = {
        count = 1000,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1}
        },
        time = 60
    }
}

data:extend({technology})

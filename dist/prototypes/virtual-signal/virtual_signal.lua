local Constants = require("constants")

data:extend(
    {
        {
            type = "item-subgroup",
            name = "CircuitControlledSilo",
            group = "signals",
            order = "zCircuitControlledSilo"
        }
    }
)

data:extend(
    {
        {
            type = "virtual-signal",
            name = "CCS_Rocket_Launch",
            icons = {
                {icon = Constants.icon_path .. "blank64.png", icon_size = 64},
                {icon = Constants.icon_path .. "rocket64.png", icon_size = 64}
            },
            subgroup = "CircuitControlledSilo",
            order = "ba"
        }
    }
)

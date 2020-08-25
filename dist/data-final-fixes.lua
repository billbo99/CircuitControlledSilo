if data.raw.item["deadlock-stack-rocket-part"] and data.raw.recipe["StackedRecipe-rocket-part"] then
    table.insert(data.raw.technology["smart-rocket-silo"].effects, {recipe = "smart-rocket-silo-red", type = "unlock-recipe"})

    local silo = data.raw["rocket-silo"]["smart-rocket-silo-red"]
    silo.fixed_recipe = "StackedRecipe-rocket-part"

    if data.raw.item["deadlock-stack-satellite"] then
        local satellite = data.raw.item["deadlock-stack-satellite"]
        satellite.rocket_launch_product = nil
    end
else
    data.raw["rocket-silo"]["smart-rocket-silo-red"] = nil
    data.raw["item"]["smart-rocket-silo-red"] = nil
    data.raw["recipe"]["smart-rocket-silo-red"] = nil
end

local Func = require("func")

local function find_free_slot_cb(cb, name)
    local first_free = 0
    local flag = false
    for _, row in pairs(cb.parameters.parameters) do
        if row.signal.name and row.signal.name == name then
            first_free = row.index
            goto exit_cb_parameters
        end
        if not flag and not row.signal["name"] then
            first_free = row.index
            flag = true
        end
    end
    ::exit_cb_parameters::
    return first_free
end

local function check_silo_control_combinator()
    if Func.is_empty(global.silos) then
        return
    end

    for _, record in pairs(global.silos) do
        local combinator = record.combinator
        local silo = record.silo
        local signals = combinator.get_merged_signals() or {}
        local cb = combinator.get_or_create_control_behavior()

        for _, row in pairs(cb.parameters.parameters) do
            cb.set_signal(row.index, nil)
        end

        if silo.rocket_parts and silo.rocket_parts > 0 then
            cb.set_signal(find_free_slot_cb(cb, "rocket-part"), {signal = {type = "item", name = "rocket-part"}, count = silo.rocket_parts})
        end

        if silo.get_inventory(defines.inventory.rocket_silo_rocket) then
            local inv = silo.get_inventory(defines.inventory.rocket_silo_rocket)
            local content = inv.get_contents()
            for name, count in pairs(content) do
                cb.set_signal(find_free_slot_cb(cb, name), {signal = {type = "item", name = name}, count = count})
            end
        end

        if signals then
            for _, cell in pairs(signals) do
                if cell.signal and cell.signal.type == "virtual" and cell.signal.name == "CCS_Rocket_Launch" then
                    if cell.count > 0 then
                        silo.auto_launch = true
                    elseif cell.count < 1 then
                        silo.auto_launch = false
                    end
                end
            end
        end
    end
end

local function rocket_silo_removed(event)
    local e = event.created_entity or event.entity or event.destination or nil
    if e and e.valid then
        if global.silos[e.unit_number].combinator and global.silos[e.unit_number].combinator.valid then
            global.silos[e.unit_number].combinator.destroy()
        end
        global.silos[e.unit_number] = nil
    else
        log(e)
    end
end

local function rocket_silo_built(event)
    local e = event.created_entity or event.entity or event.destination or nil
    if e and e.valid then
        if Func.starts_with(e.name, "smart-rocket-silo-") then
            local combinator = e.surface.create_entity {name = "silo-control-combinator", direction = defines.direction.south, position = {(e.position.x) + 3.5, (e.position.y) + 3.5}, force = e.force}
            global.silos[e.unit_number] = {silo = e, combinator = combinator}
            combinator.destructible = false
        end
    else
        log(event)
    end
end

--- Find rocket silos on the map
local function find_rocket_silos()
    global.silos = {}
    for i, row in pairs(global.silos) do
        if row.silo and not row.silo.valid then
            if row.combinator and row.combinator.valid then
                row.combinator.destroy()
            end
            global.silos[i] = nil
        end
    end

    if game then
        for _, surface in pairs(game.surfaces) do
            for _, entity in pairs(surface.find_entities_filtered({type = "rocket-silo"})) do
                if Func.starts_with(entity.name, "smart-rocket-silo-") then
                    local area = {{entity.position.x - 4, entity.position.y - 4}, {entity.position.x + 4, entity.position.y + 4}}
                    local combinator = nil
                    for _, e in pairs(entity.surface.find_entities_filtered {area = area, name = "silo-control-combinator"}) do
                        combinator = e
                    end
                    global.silos[entity.unit_number] = {silo = entity, combinator = combinator}
                end
            end
        end
    end
end

script.on_init(
    function()
        log("on_init")
        global.silos = global.silos or {}
        find_rocket_silos()
    end
)

script.on_load(
    function()
        log("on_load")
    end
)

script.on_configuration_changed(
    function(e)
        -- e.mod_changes
        -- e.mod_startup_settings_changed
        -- e.migration_applied
        log("on_configuration_changed")
        global.silos = global.silos or {}
        find_rocket_silos()
    end
)

script.on_nth_tick(20, check_silo_control_combinator)

script.on_event(defines.events.on_built_entity, rocket_silo_built, {{filter = "type", type = "rocket-silo"}})
script.on_event(defines.events.on_entity_cloned, rocket_silo_built, {{filter = "type", type = "rocket-silo"}})
script.on_event(defines.events.on_robot_built_entity, rocket_silo_built, {{filter = "type", type = "rocket-silo"}})
script.on_event(defines.events.script_raised_built, rocket_silo_built, {{filter = "type", type = "rocket-silo"}})
script.on_event(defines.events.script_raised_revive, rocket_silo_built, {{filter = "type", type = "rocket-silo"}})

script.on_event(defines.events.on_entity_died, rocket_silo_removed, {{filter = "type", type = "rocket-silo"}})
script.on_event(defines.events.on_player_mined_entity, rocket_silo_removed, {{filter = "type", type = "rocket-silo"}})
script.on_event(defines.events.on_robot_mined_entity, rocket_silo_removed, {{filter = "type", type = "rocket-silo"}})
script.on_event(defines.events.script_raised_destroy, rocket_silo_removed, {{filter = "type", type = "rocket-silo"}})

script.on_event(defines.events.on_chunk_deleted, find_rocket_silos)
script.on_event(defines.events.on_surface_cleared, find_rocket_silos)
script.on_event(defines.events.on_surface_deleted, find_rocket_silos)

MonkeSynergyBlocker = MonkeSynergyBlocker or {}
local r = MonkeSynergyBlocker

function r.buildMenu()
    local LAM = LibAddonMenu2
    local syn = {
        {
            type = "description",
            text = "Indivisual synergy toggling. \nHealing based synergies toggled off by default. \nTurn on Tracking in the general section to be able to toggle synergies"
        }
    }
    for k, v in pairs(r.synergies) do
        if r.divider[k] then syn[#syn + 1] = {type = "divider"} end
        syn[#syn + 1] = {
            type = "description",
            text = "",
            title = "|c00FFCC" .. string.upper(v.name) .. "|r"
        }
        for idx = 1, #v.types do
            local type = v.types[idx]
            local tex = "|t24:24:" .. r.synids[type].tex .. "|t  "
            syn[#syn + 1] = {
                type = "checkbox",
                name = tex .. r.synids[type].en,
                getFunc = function()
                    return r.savedVars.synids[type].blocked
                end,
                setFunc = function(val)
                    r.savedVars.synids[type].blocked = val
                end,
                disabled = function()
                    return not (r.savedVars.stamBlock or r.savedVars.magBlock)
                end,
                default = r.defaults.synids[type].blocked
            }
        end
    end

    local panelData = {
        type = "panel",
        name = "Monke Synergy Blocker",
        displayName = "Monke Synergy Blocker",
        author = "|cFFA500FlaminDemigod|r",
        version = "" .. r.version,
        slashCommand = "/msb",
        registerForDefaults = true,
        registerForRefresh = true
    }

    LAM:RegisterAddonPanel(r.name .. "GeneralOptions", panelData)

    local generalOptions = {
        [1] = {
            type = "description",
            text = "Custom Synergy blocker that blocks synergies based on Resources"
        },
        [2] = {
            type = "submenu",
            name = "|c00ffffGeneral|r",
            controls = {
                {
                    type = "description",
                    text = "Settings related to global synergy toggling"
                }, {
                    type = "checkbox",
                    name = "Global Toggle",
                    getFunc = function()
                        return r.savedVars.enabled
                    end,
                    setFunc = function(var)
                        r.savedVars.enabled = var
                    end,
                    default = r.defaults["enabled"],
                    width = "half"
                }, {
                    type = "checkbox",
                    name = "Disable in PvP",
                    getFunc = function()
                        return r.savedVars.blockInPvP
                    end,
                    setFunc = function(var)
                        r.savedVars.blockInPvP = var
                    end,
                    default = r.defaults["blockInPvP"],
                    width = "half"
                }, {
                    type = "checkbox",
                    name = "Track Magicka",
                    getFunc = function()
                        return r.savedVars.magBlock
                    end,
                    setFunc = function(var)
                        r.savedVars.magBlock = var
                    end,
                    default = r.defaults["magBlock"],
                    width = "half"
                }, {
                    type = "slider",
                    name = "Magicka Threshold",
                    getFunc = function()
                        return r.savedVars.magThreshold
                    end,
                    setFunc = function(val)
                        r.savedVars.magThreshold = val
                    end,
                    min = 0,
                    max = 100,
                    step = 10,
                    default = r.defaults["magThreshold"],
                    disabled = function()
                        return not r.savedVars.magBlock
                    end,
                    width = "half"
                }, {
                    type = "checkbox",
                    name = "Track Stamina",
                    getFunc = function()
                        return r.savedVars.stamBlock
                    end,
                    setFunc = function(var)
                        r.savedVars.stamBlock = var
                    end,
                    default = r.defaults["stamBlock"],
                    width = "half"
                }, {
                    type = "slider",
                    name = "Stamina Threshold",
                    getFunc = function()
                        return r.savedVars.stamThreshold
                    end,
                    setFunc = function(val)
                        r.savedVars.stamThreshold = val
                    end,
                    min = 0,
                    max = 100,
                    step = 10,
                    default = r.defaults["stamThreshold"],
                    disabled = function()
                        return not r.savedVars.stamBlock
                    end,
                    width = "half"
                }
            }
        },
        [3] = {type = "submenu", name = "|c00ffffSynergies|r", controls = syn}
    }

    LAM:RegisterOptionControls(r.name .. "GeneralOptions", generalOptions)
end

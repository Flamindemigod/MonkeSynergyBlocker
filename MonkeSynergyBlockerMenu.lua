MonkeSynergyBlocker = MonkeSynergyBlocker or {}
local r = MonkeSynergyBlocker

local blockMapping = {
    [r.blockType.NOT_BLOCKED] = "Not Blocked",
    [r.blockType.RESOURCE_BLOCKED] = "Resource Blocked",
    [r.blockType.SET_BLOCKED] = "Set Blocked",
    [r.blockType.PERMA_BLOCKED] = "Permanently Blocked"
}

local invBlockMapping = {}
local choices = {}
for key, value in pairs(blockMapping) do
    invBlockMapping[value] = key
    choices[#choices + 1] = value
end

function r.buildMenu()
    local LAM = LibAddonMenu2
    local Syn = {
        {
            type = "description",
            text = "Indivisual synergy toggling. \nHealing based synergies toggled off by default. \nTurn on Tracking in the general section to be able to toggle synergies"
        }
    }
    for k, v in pairs(r.synids) do
        if r.divider[k] then Syn[#Syn + 1] = {type = "divider"} end
        Syn[#Syn + 1] = {
            type = "description",
            text = "",
            title = "|c00FFCC" .. string.upper(v.name) .. "|r"
        }
        for a_id, a_v in pairs(v.types) do
            local type = k
            local tex = "|t24:24:" .. a_v.tex .. "|t  "
            Syn[#Syn + 1] = {
                type = "dropdown",
                choices = choices,
                name = tex .. a_v.name,
                getFunc = function()
                    return blockMapping[r.savedVars.synids[type].types[a_id]
                               .blocked]
                end,
                setFunc = function(val)
                    r.savedVars.synids[type].types[a_id].blocked =
                        invBlockMapping[val]
                end,
                default = r.defaults.synids[type].types[a_id].blocked
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
        {
            type = "description",
            text = "Custom Synergy blocker that used to only blocks synergies based on Resources, now it does more"
        },
        {
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
        {type = "submenu", name = "|c00ffffSynergies|r", controls = Syn}
    }

    LAM:RegisterOptionControls(r.name .. "GeneralOptions", generalOptions)
end

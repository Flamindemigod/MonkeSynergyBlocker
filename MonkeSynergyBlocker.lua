MonkeSynergyBlocker = MonkeSynergyBlocker or {}
local r = MonkeSynergyBlocker
local EM = GetEventManager()

r.mag = 0
r.stam = 0
r.iota = 1
local function iota()
    r.iota = r.iota + 1
    return r.iota
end
-- sets
local TYPE_THORN = iota()
local TYPE_URSUS = iota()
-- undaunted
local TYPE_ALTAR = iota()
local TYPE_SPIDER = iota()
local TYPE_TAUNT = iota()
local TYPE_SHIELD = iota()
local TYPE_ORB = iota()
-- dragonknight
local TYPE_STANDARD = iota()
local TYPE_TALONS = iota()
-- sorcerer
local TYPE_ATRONACH = iota()
local TYPE_LIGHTNING = iota()
-- nightblade
local TYPE_DARKNESS = iota()
local TYPE_SOUL = iota()
-- templar
local TYPE_SHARD = iota()
local TYPE_NOVA = iota()
local TYPE_RITUAL = iota()
-- warden
local TYPE_SEED = iota()
local TYPE_GATE = iota()
-- necromancer
local TYPE_GRAVE = iota()
local TYPE_TOTEM = iota()
-- werewolf
local TYPE_FRENZY = iota()

-- Companion
local TYPE_CRIMSON_FUNNEL = iota()

r.fonts = {
    ["ProseAntique"] = "$(ANTIQUE_FONT)",
    ["Consolas"] = "/EsoUI/Common/Fonts/consola.slug",
    ["Futura Condensed"] = "$(GAMEPAD_MEDIUM_FONT)",
    ["Futura Condensed Bold"] = "$(GAMEPAD_BOLD_FONT)",
    ["Futura Condensed Light"] = "$(GAMEPAD_LIGHT_FONT)",
    ["Skyrim Handwritten"] = "$(HANDWRITTEN_FONT)",
    ["Trajan Pro"] = "$(STONE_TABLET_FONT)",
    ["Univers 55"] = "$(CHAT_FONT)",
    ["Univers 57"] = "$(MEDIUM_FONT)",
    ["Univers 67"] = "$(BOLD_FONT)"
};

r.blockType = {
    NOT_BLOCKED = 0,
    RESOURCE_BLOCKED = 1,
    SET_BLOCKED = 2,
    PERMA_BLOCKED = 3
}
r.name = "MonkeSynergyBlocker"
r.version = "1.2.0"
r.variableVersion = 1
r.defaults = {
    ["synCustomization"] = {
        ["enabled"] = true,
        ["iconScale"] = 1,
        ["hideText"] = false,
        ["textFont"] = "Consolas",
        ["textFontSize"] = 22
    },
    ["magBlock"] = false,
    ["stamBlock"] = false,
    ["enabled"] = true,
    ["debug"] = false,
    ["magThreshold"] = 50,
    ["stamThreshold"] = 50,
    ["blockInPvP"] = true,
    ["missingIds"] = {},
    ["synids"] = {
        -- Sets
        -- - Lady Thorn
        --   - Lady Thorn                Sanguine Burst         141920
        [TYPE_THORN] = {
            types = {[141920] = {blocked = r.blockType.PERMA_BLOCKED}},
            name = "Lady Thorn"
        },
        -- - Haven of Ursus
        --   - Haven of Ursus            Shield of Ursus        111437
        [TYPE_URSUS] = {
            types = {[111437] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "Shield of Ursus"
        },
        -- - Kraglen's Howl

        -- Undaunted
        -- - Blood Altar                 Blood Funnel           39500 (UESP)
        --   - Sanguine Altar            Blood Funnel           39500 (UESP)
        --   - Overflowing Altar         Blood Feast            41963 (UESP)
        [TYPE_ALTAR] = {
            types = {
                [39500] = {blocked = r.blockType.NOT_BLOCKED},
                [41963] = {blocked = r.blockType.NOT_BLOCKED}
            },
            name = "Undaunted Altar"
        },
        -- - Trapping Webs               Spawn Broodling        39429 (UESP)
        --   - Shadow Silk               Black Widow            41994
        --   - Tangling Webs             Arachnophobia          42020 (UESP)
        [TYPE_SPIDER] = {
            types = {
                [39429] = {blocked = r.blockType.RESOURCE_BLOCKED},
                [41994] = {blocked = r.blockType.RESOURCE_BLOCKED},
                [42020] = {blocked = r.blockType.RESOURCE_BLOCKED}
            },
            name = "Undaunted Spider"
        },
        -- - Inner Fire                  Radiate                41839
        --   - Inner Rage                Radiate                41839
        --   - Inner Beast               Radiate                41839
        [TYPE_TAUNT] = {
            types = {[41839] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "Undaunted Taunt"
        },
        -- - Bone Shield                 Bone Wall              39377 (UESP)
        --   - Spiked Bone Shield        Bone Wall              39377 (UESP)
        --   - Bone Surge                Spinal Surge           42194 (UESP)
        [TYPE_SHIELD] = {
            types = {
                [39377] = {blocked = r.blockType.RESOURCE_BLOCKED},
                [42194] = {blocked = r.blockType.NOT_BLOCKED}
            },
            name = "Undaunted Shield"
        },
        -- - Necrotic Orb                Combustion             39301 (UESP)
        --   - Mystic Orb                Combustion             39301 (UESP)
        --   - Energy Orb                Healing Combustion     63507 (UESP)
        [TYPE_ORB] = {
            types = {
                [39301] = {blocked = r.blockType.RESOURCE_BLOCKED},
                [63507] = {blocked = r.blockType.NOT_BLOCKED}
            },
            name = "Undaunted Orb"
        },
        -- Dragonknight
        -- - Dragonknight Standard       Shackle                98438
        --   - Shifting Standard         Shackle                98438
        --   - Standard of Might         Shackle                98438
        [TYPE_STANDARD] = {
            types = {[98438] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "DK Standard"
        },
        -- - Dark Talons                 Ignite                 32974
        --   - Burning Talons            Ignite                 32974
        --   - Choking Talons            Ignite                 32974
        [TYPE_TALONS] = {
            types = {[32974] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "DK Talons"
        },
        -- Sorcerer
        -- - Summon Storm Atronach       Charged Lightning      48076 (UESP)
        --   - Greater Storm Atronach    Charged Lightning      48076 (UESP)
        --   - Summon Charged Atronach   Charged Lightning      48076 (UESP)
        [TYPE_ATRONACH] = {
            types = {[48076] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "Sorc Atro"
        },
        -- - Lightning Splash            Conduit                23196
        --   - Liquid Lightning          Conduit                23196
        --   - Lightning Flood           Conduit                23196
        [TYPE_LIGHTNING] = {
            types = {[23196] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "Sorc Conduit"
        },
        -- Nightblade
        -- - Consuming Darkness          Hidden Refresh         37729 (UESP)
        --   - Bolstering Darkness       Hidden Refresh         37729 (UESP)
        --   - Veil of Blades            Hidden Refresh         37729 (UESP)
        [TYPE_DARKNESS] = {
            types = {[37729] = {blocked = r.blockType.NOT_BLOCKED}},
            name = "NB Refresh"
        },
        -- - Soul Shred                  Soul Leech             25170 (UESP)
        --   - Soul Siphon               Soul Leech             25170 (UESP)
        --   - Soul Tether               Soul Leech             25170 (UESP)
        [TYPE_SOUL] = {
            types = {[25170] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "NB Soul"
        },
        -- Templar
        -- - Spear Shards                Blessed Shards         26832 (UESP)
        --   - Luminous Shards           Holy Shards            95922 (UESP)
        --   - Blazing Spear             Blessed Shards         26832 (UESP)
        [TYPE_SHARD] = {
            types = {
                [26832] = {blocked = r.blockType.RESOURCE_BLOCKED},
                [95922] = {blocked = r.blockType.RESOURCE_BLOCKED}
            },
            name = "Templar Shards"
        },
        -- - Nova                        Supernova              31538 (UESP)
        --   - Solar Prison              Gravity Crush          31603 (UESP)
        --   - Solar Disturbance         Supernova              31538 (UESP)
        [TYPE_NOVA] = {
            types = {
                [31538] = {blocked = r.blockType.RESOURCE_BLOCKED},
                [31603] = {blocked = r.blockType.RESOURCE_BLOCKED}
            },
            name = "Templar Nova"
        },
        -- - Cleansing Ritual            Purify                 26300 (UESP)
        --   - Ritual of Retribution     Purify                 26300 (UESP)
        --   - Extended Ritual           Purify                 26300 (UESP)
        [TYPE_RITUAL] = {
            types = {[26300] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "Templar Ritual"
        },
        -- Warden
        -- - Healing Seed                Harvest                85577
        --   - Budding Seeds             Harvest                85577
        --   - Corrupting Pollen         Harvest                85577
        [TYPE_SEED] = {
            types = {[85577] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "Warden Harvest"
        },
        -- - Frozen Gate                 ---
        --   - Frozen Device             ---
        --   - Frozen Retreat            Icy Escape             88884 (UESP)
        [TYPE_GATE] = {
            types = {[88884] = {blocked = r.blockType.NOT_BLOCKED}},
            name = "Warden Gate"
        },
        -- Necromancer
        -- - Boneyard                    Grave Robber           115572
        --   - Unnerving Boneyard        Grave Robber           115572
        --   - Avid Boneyard             Grave Robber           115572
        [TYPE_GRAVE] = {
            types = {[115572] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "Necro Boneyard"
        },
        -- - Bone Totem                  ---
        --   - Remote Totem              ---
        --   - Agony Totem               Pure Agony             118618
        [TYPE_TOTEM] = {
            types = {[118618] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "Necro Totem"
        },
        -- Werewolf
        -- - Piercing Howl               ---
        --   - Howl of Despair           Feeding Frenzy         58775 (UESP)
        --   - Howl of Agony             ---
        [TYPE_FRENZY] = {
            types = {[58775] = {blocked = r.blockType.RESOURCE_BLOCKED}},
            name = "Werewolf"
        },
        -- TODO: Add Arcanist Synergies
        -- RuneBreak
        -- Portal
        -- Companion
        -- Crimson Funnel
        [TYPE_CRIMSON_FUNNEL] = {
            types = {[155521] = {blocked = r.blockType.NOT_BLOCKED}},
            name = "Companion Altar"
        }
    }
}

r.divider = {
    [TYPE_THORN] = true,
    [TYPE_ALTAR] = true,
    [TYPE_STANDARD] = true,
    [TYPE_ATRONACH] = true,
    [TYPE_DARKNESS] = true,
    [TYPE_SHARD] = true,
    [TYPE_SEED] = true,
    [TYPE_GRAVE] = true,
    [TYPE_FRENZY] = true,
    [TYPE_CRIMSON_FUNNEL] = true
}

r.synids = r.defaults.synids
r.invMapping = {}

for id, v in pairs(r.synids) do
    for k, _ in pairs(v.types) do
        r.synids[id].types[k].name = zo_strformat(SI_ABILITY_NAME,
                                                  GetAbilityName(k))
        r.synids[id].types[k].tex = GetAbilityIcon(k)
        r.invMapping[r.synids[id].types[k].tex] = {["key"] = id, ["id"] = k}
    end
end

function r.eprintln(str) if r.savedVars.debug then d("[MSB]: " .. str) end end

function r.resourceTracker(e, _, _, powerType, powerValue, powerMax, _)
    if (powerType == POWERTYPE_MAGICKA) then
        r.mag = (powerValue / powerMax) * 100
    elseif (powerType == POWERTYPE_STAMINA) then
        r.stam = (powerValue / powerMax) * 100
    end
end

function r.blockSynergies()
    ZO_PostHook(SYNERGY, 'OnSynergyAbilityChanged', function(self)
        if r.savedVars.enabled then
            if not ((IsPlayerInAvAWorld() or IsActiveWorldBattleground()) and
                r.savedVars.blockInPvP) then
                local name, icon = GetSynergyInfo()
                if name and icon then
                    local link = ZO_LinkHandler_CreateLink(zo_strformat(
                                                               "<<C:1>>", name),
                                                           nil,
                                                           "synergydisplay",
                                                           name, icon);
                    r.eprintln("|cf05a4f" .. link .. "|r");
                    local t = r.invMapping[icon]
                    if not t then
                        if not r.savedVars.missingIds[name] then
                            r.savedVars.missingIds[name] = true;
                            r.eprintln("Cannot block " .. name)
                        end
                        return false
                    end
                    local blockInfo = r.savedVars.synids[t.key].types[t.id]
                                          .blocked
                    if blockInfo == r.blockType.PERMA_BLOCKED then
                        r.eprintln("Perma Blocking '" .. name .. "'")
                        SHARED_INFORMATION_AREA:SetHidden(self, true)
                        return true
                    elseif blockInfo == r.blockType.RESOURCE_BLOCKED then
                        if (r.savedVars.magBlock and r.mag >=
                            r.savedVars.magThreshold) or
                            (r.savedVars.stamBlock and r.stam >=
                                r.savedVars.stamThreshold) then
                            r.eprintln("Resource Blocking '" .. name .. "'")
                            SHARED_INFORMATION_AREA:SetHidden(self, true)
                            return true
                        end
                    end
                end
            end
        end
    end)
end

function r.CombatEvent(_, result, isError, abilityName, abilityGraphic,
                       abilityActionSlotType, sourceName, sourceType,
                       targetName, targetType, hitValue, powerType, damageType,
                       log, sourceUnitId, targetUnitId, abilityId)
    if r.savedVars.missingIds[abilityName] == true then
        r.savedVars.missingIds[abilityName] = {["id"] = abilityId};
    end
end

SLASH_COMMANDS["/msb.debug"] = function()
    r.savedVars.debug = not r.savedVars.debug
end

function r.init(_, addon)
    if addon ~= r.name then return end
    EM:UnregisterForEvent(r.name .. "onLoad", EVENT_ADD_ON_LOADED)
    r.savedVars = ZO_SavedVars:NewCharacterIdSettings(r.name .. "Vars",
                                                      r.variableVersion, r.name,
                                                      r.defaults, GetWorldName())
    r.buildMenu()
    r.blockSynergies()
    EM:RegisterForEvent(r.name, EVENT_POWER_UPDATE, r.resourceTracker)
    EM:RegisterForEvent(r.name .. "cbEvent", EVENT_COMBAT_EVENT, r.CombatEvent)
    EM:AddFilterForEvent(r.name .. "cbEvent", EVENT_COMBAT_EVENT,
                         REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, "player")
end

EM:RegisterForEvent(r.name, EVENT_ADD_ON_LOADED, r.init)

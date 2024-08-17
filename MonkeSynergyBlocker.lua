MonkeSynergyBlocker = MonkeSynergyBlocker or { }
local r = MonkeSynergyBlocker
local EM = GetEventManager()
local WM = GetWindowManager()

r.name = "MonkeSynergyBlocker"
r.version = "1.0.0"
r.variableVersion = 1
r.defaults = {
    ["magBlock"] = false,
    ["stamBlock"] = false,
    ["enabled"] = true,
    ["magThreshold"] = 50,
    ["stamThreshold"] = 50,
    ["blockInPvP"] = true,
    ["synids"] = {
        -- Sets
        -- - Lady Thorn
        --   - Lady Thorn                Sanguine Burst         141920
        [141920] = { en = "Sanguine Burst", blocked = true},
        -- - Haven of Ursus
        --   - Haven of Ursus            Shield of Ursus        111437
        [111437] = { en = "Shield of Ursus", blocked = true},      
        -- - Kraglen's Howl
        
        -- Undaunted
        -- - Blood Altar                 Blood Funnel           39500 (UESP)
        --   - Sanguine Altar            Blood Funnel           39500 (UESP)
        --   - Overflowing Altar         Blood Feast            41963 (UESP)
        [39500] = { en = "Blood Funnel", blocked = false},
        [41963] = { en = "Blood Feast" , blocked = false},
        -- - Trapping Webs               Spawn Broodling        39429 (UESP)
        --   - Shadow Silk               Black Widow            41994
        --   - Tangling Webs             Arachnophobia          42020 (UESP)
        [39429] = { en = "Spawn Broodling", blocked = true},
        [41994] = { en = "Black Widow", blocked = true},
        [42020] = { en = "Arachnophobia", blocked = true},
        -- - Inner Fire                  Radiate                41839
        --   - Inner Rage                Radiate                41839
        --   - Inner Beast               Radiate                41839
        [41839] = { en = "Radiate", blocked = true },
        -- - Bone Shield                 Bone Wall              39377 (UESP)
        --   - Spiked Bone Shield        Bone Wall              39377 (UESP)
        --   - Bone Surge                Spinal Surge           42194 (UESP)
        [39377] = { en = "Bone Wall", blocked = true },
        [42194] = { en = "Spinal Surge", blocked = false },
        -- - Necrotic Orb                Combustion             39301 (UESP)
        --   - Mystic Orb                Combustion             39301 (UESP)
        --   - Energy Orb                Healing Combustion     63507 (UESP)
        [39301] = { en = "Combustion", blocked = true },
        [63507] = { en = "Healing Combustion", blocked = false },
        
        -- Dragonknight
        -- - Dragonknight Standard       Shackle                98438
        --   - Shifting Standard         Shackle                98438
        --   - Standard of Might         Shackle                98438
        [98438] = { en = "Shackle", blocked = true },
        -- - Dark Talons                 Ignite                 32974
        --   - Burning Talons            Ignite                 32974
        --   - Choking Talons            Ignite                 32974
        [32974] = { en = "Ignite", blocked = true },
        
        -- Sorcerer
        -- - Summon Storm Atronach       Charged Lightning      48076 (UESP)
        --   - Greater Storm Atronach    Charged Lightning      48076 (UESP)
        --   - Summon Charged Atronach   Charged Lightning      48076 (UESP)
        [48076] = { en = "Charged Lightning", blocked = true },
        -- - Lightning Splash            Conduit                23196
        --   - Liquid Lightning          Conduit                23196
        --   - Lightning Flood           Conduit                23196
        [23196] = { en = "Conduit", blocked = true },
    
        -- Nightblade
        -- - Consuming Darkness          Hidden Refresh         37729 (UESP)
        --   - Bolstering Darkness       Hidden Refresh         37729 (UESP)
        --   - Veil of Blades            Hidden Refresh         37729 (UESP)
        [37729] = { en = "Hidden Refresh", blocked = false },
        -- - Soul Shred                  Soul Leech             25170 (UESP)
        --   - Soul Siphon               Soul Leech             25170 (UESP)
        --   - Soul Tether               Soul Leech             25170 (UESP)
        [25170] = { en = "Soul Leech", blocked = true },
    
        -- Templar
        -- - Spear Shards                Blessed Shards         26832 (UESP)
        --   - Luminous Shards           Holy Shards            95922 (UESP)
        --   - Blazing Spear             Blessed Shards         26832 (UESP)
        [26832] = { en = "Blessed Shards", blocked = true },
        [95922] = { en = "Holy Shards", blocked = true },
        -- - Nova                        Supernova              31538 (UESP)
        --   - Solar Prison              Gravity Crush          31603 (UESP)
        --   - Solar Disturbance         Supernova              31538 (UESP)
        [31538] = { en = "Supernova", blocked = true },
        [31603] = { en = "Gravity Crush", blocked = true },
        -- - Cleansing Ritual            Purify                 26300 (UESP)
        --   - Ritual of Retribution     Purify                 26300 (UESP)
        --   - Extended Ritual           Purify                 26300 (UESP)
        [26300] = { en = "Purify", blocked = true },
    
        -- Warden
        -- - Healing Seed                Harvest                85577
        --   - Budding Seeds             Harvest                85577
        --   - Corrupting Pollen         Harvest                85577
        [85577] = { en = "Harvest", blocked = false },
        -- - Frozen Gate                 ---
        --   - Frozen Device             ---
        --   - Frozen Retreat            Icy Escape             88884 (UESP)
        [88884] = { en = "Icy Escape", blocked = true },
        
        -- Necromancer
        -- - Boneyard                    Grave Robber           115572
        --   - Unnerving Boneyard        Grave Robber           115572
        --   - Avid Boneyard             Grave Robber           115572
        [115572] = { en = "Grave Robber", blocked = true },
        -- - Bone Totem                  ---
        --   - Remote Totem              ---
        --   - Agony Totem               Pure Agony             118618
        [118618] = { en = "Pure Agony", blocked = true },
    
        -- Werewolf
        -- - Piercing Howl               ---
        --   - Howl of Despair           Feeding Frenzy         58775 (UESP)
        --   - Howl of Agony             ---
        [58775] = { en = "Feeding Frenzy", blocked = true },
    },
}

r.blocking = false
r.debug = true

--sets
local TYPE_THORN     = 1
local TYPE_URSUS     = 2
-- undaunted
local TYPE_ALTAR     = 3
local TYPE_SPIDER    = 4
local TYPE_TAUNT     = 5
local TYPE_SHIELD    = 6
local TYPE_ORB       = 7
-- dragonknight
local TYPE_STANDARD  = 8
local TYPE_TALONS    = 9
-- sorcerer
local TYPE_ATRONACH  = 10
local TYPE_LIGHTNING = 11
-- nightblade
local TYPE_DARKNESS  = 12
local TYPE_SOUL      = 13
-- templar
local TYPE_SHARD	 = 14
local TYPE_NOVA      = 15
local TYPE_RITUAL    = 16
-- warden
local TYPE_SEED      = 17
local TYPE_GATE      = 18
-- necromancer
local TYPE_GRAVE     = 19
local TYPE_TOTEM     = 20
-- werewolf
local TYPE_FRENZY    = 21


r.synergies = {
    --sets
    [TYPE_THORN]        = {id = "TYPE_THORN",      name = "Set Lady Thorn",                types = {[1] = 141920}},
    [TYPE_URSUS]        = {id = "TYPE_URSUS",      name = "Set Haven of Ursus",            types = {[1] = 111437}},
	-- undaunted
	[TYPE_ALTAR]		= { id = "TYPE_ALTAR",	   name = "Undaunted Blood Altar",		   types = { [1] = 39500 , [2] = 41963 } },
	[TYPE_SPIDER]		= { id = "TYPE_SPIDER",	   name = "Undaunted Trapping Webs",	   types = { [1] = 39429, [2] = 41994, [3] = 42020 } },
	[TYPE_TAUNT]		= { id = "TYPE_TAUNT",	   name = "Undaunted Inner Fire",		   types = { [1] = 41839 } },
	[TYPE_SHIELD]		= { id = "TYPE_SHIELD",	   name = "Undaunted Bone Shield",		   types = { [1] = 39377, [2] = 42194 } },
	[TYPE_ORB]			= { id = "TYPE_ORB",	   name = "Undaunted Necrotic Orb",		   types = { [1] = 39301, [2] = 63507 } },
	-- dragonknight
	[TYPE_STANDARD]		= { id = "TYPE_STANDARD",  name = "Dragonknight Standard",		   types = { [1] = 98438 } },
	[TYPE_TALONS]		= { id = "TYPE_TALONS",	   name = "Dragonknight Dark Talons",	   types = { [1] = 32974 } },
	-- sorcerer
	[TYPE_ATRONACH]		= { id = "TYPE_ATRONACH",  name = "Sorcerer Storm Atronach",	   types = { [1] = 48076 } },
	[TYPE_LIGHTNING]	= { id = "TYPE_LIGHTNING", name = "Sorcerer Lightning Splash",	   types = { [1] = 23196 } },
	-- nightblade
	[TYPE_DARKNESS]		= { id = "TYPE_DARKNESS",  name = "Nightblade Consuming Darkness", types = { [1] = 37729 } },
	[TYPE_SOUL]			= { id = "TYPE_SOUL",	   name = "Nightblade Soul Shred",		   types = { [1] = 25170 } },
	-- templar
	[TYPE_SHARD]		= { id = "TYPE_SHARD",	   name = "Templar Spear Shard",	       types = { [1] = 26832, [2] = 95922 } },
	[TYPE_NOVA]			= { id = "TYPE_NOVA",	   name = "Templar Nova",				   types = { [1] = 31538, [2] = 31603 } },
	[TYPE_RITUAL]		= { id = "TYPE_RITUAL",	   name = "Templar Cleansing Ritual",	   types = { [1] = 26300 } },
	-- warden
	[TYPE_SEED]			= { id = "TYPE_SEED",	   name = "Warden Healing Seed",		   types = { [1] = 85577 } },
	[TYPE_GATE]			= { id = "TYPE_GATE",	   name = "Warden Frozen Retreat",		   types = { [1] = 88884 } },
	-- necromancer
	[TYPE_GRAVE]		= { id = "TYPE_GRAVE",	   name = "Necromancer Boneyard",		   types = { [1] = 115572 } },
	[TYPE_TOTEM]		= { id = "TYPE_TOTEM",	   name = "Necromancer Agony Totem",	   types = { [1] = 118618 } },
	-- werewolf
	[TYPE_FRENZY]		= { id = "TYPE_FRENZY",	   name = "Werewolf Howl of Despair",	   types = { [1] = 58775 } },
}

r.divider = {
    [TYPE_THORN]        = true,
    [TYPE_ALTAR]		= true,
    [TYPE_STANDARD]		= true,
    [TYPE_ATRONACH]	    = true,
    [TYPE_DARKNESS]		= true,
    [TYPE_SHARD]    	= true,
    [TYPE_SEED]			= true,
    [TYPE_GRAVE]		= true,
    [TYPE_FRENZY]		= true,
}

r.synids = r.defaults.synids

for id, data in pairs( r.synids ) do
	r.synids[id].name = string.lower( zo_strformat( SI_ABILITY_NAME, GetAbilityName( id ) ) )
	r.synids[id].tex  = GetAbilityIcon( id )
end

function r.resourceTracker(e, _, _, powerType, powerValue, powerMax, _)
    if r.savedVars.enable then
        if not ((IsPlayerInAvAWorld() or IsActiveWorldBattleground()) and r.savedVars.blockInPvP) then
            if ((powerType == POWERTYPE_MAGICKA) and r.savedVars.magBlock) or ((powerType == POWERTYPE_STAMINA) and r.savedVars.stamBlock) then
                if ((powerValue/powerMax)*100 >= r.savedVars.magThreshold) or ((powerValue/powerMax)*100 >= r.savedVars.stamThreshold) then
                    r.blocking = true
          return;
                end
            end
        end
    end
                    r.blocking = false
end



function r.blockSynergies()
    ZO_PreHook(SYNERGY, 'OnSynergyAbilityChanged',
    function(self)
		local name, icon = GetSynergyInfo()
		if name and icon then
			if r.debug then
				local link = ZO_LinkHandler_CreateLink(zo_strformat("<<C:1>>", name), nil, "synergydisplay", name, icon);
				d("|cf05a4f" .. link .. "|r");
                d(r.blocking)
			end
            for id, data in pairs (r.savedVars.synids) do
                if r.savedVars.synids[id].tex == icon and r.savedVars.synids[id].blocked and r.blocking then
                    if r.debug then
                        d("Blocking '".. name .."'")
                    end
                    SHARED_INFORMATION_AREA:SetHidden(self, true)
                    return true
                end
            end
		end
	end)
end


function r.init(e, addon)
	if addon ~= r.name then return end
	EM:UnregisterForEvent(r.name.."onLoad", EVENT_ADD_ON_LOADED)
	r.savedVars = ZO_SavedVars:NewCharacterIdSettings(r.name .. "Vars", r.variableVersion, r.name , r.defaults, GetWorldName())
	r.buildMenu()
    r.blockSynergies()
    EM:RegisterForEvent(r.name, EVENT_POWER_UPDATE, r.resourceTracker)
end

SLASH_COMMANDS["/msb.debug"] = function() r.debug = not r.debug end

EM:RegisterForEvent(r.name, EVENT_ADD_ON_LOADED, r.init)

local pathToVars = assert(arg[1], "Path to saved vars must be provided")
assert(loadfile(pathToVars))()
local m = MonkeSynergyBlockerVars
missingIds = {}

function FindId(val)
    for k, v in pairs(val) do
        if k == "missingIds" then
            for name, id in pairs(v) do
                if name ~= "" and id ~= true then
                    if missingIds[name] == nil then
                        missingIds[name] = {}
                    end
                    table.insert(missingIds[name], id.id)
                end
            end
        end
        if type(v) == "table" then FindId(v) end
    end
end

FindId(m)

for name, ids in pairs(missingIds) do
    local repName = string.gsub(string.upper(name), " ", "_")
    print("local TYPE_" .. repName .. " = iota()")
end

print("\n\n\n")
for name, ids in pairs(missingIds) do
    local repName = string.gsub(string.upper(name), " ", "_")
    print("{[\"TYPE_" .. repName .. "\"] = {\n\ttypes = {")
    for _, id in pairs(ids) do
        print("\t\t[" .. id .. "] = { blocked = r.blockType.RESOURCE_BLOCKED },")
    end
    print("\t},\nname = \"" .. name .. "\"\n},")
end


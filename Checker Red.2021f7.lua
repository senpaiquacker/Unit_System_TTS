

local unitAssigned = {} 
function onLoad()
    unitAssigned = Global.call("CreateNewUnit", 
    {
        name="Skitarii Rangers", 
        models={"e53e79", "052f88", "7126e9"},
        points = 70
    })
end
--[[_G.PUnit:new("Belisarius Cawl", {"721623"}, 150)--]]
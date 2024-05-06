

local unitAssigned = {} 
function onLoad()
    unitAssigned = Global.call("CreateNewUnit", 
    {
        name="Belisarius Cawl", 
        models={"721623"}, 
        points = 150
    })
    --[[function unitAssigned:CreateNewUnit()
        if UnitLayout:Count(self.Name) > 0 then
            error "There is Epic Hero in roster already"
        else
            self:SpawnUnit()
            AddArmyPoints(self.PointsValue)
        end
    end
    function unitAssigned:SpawnUnit()
        UnitLayout.AddUnit(self)
    end--]]
end
--[[_G.PUnit:new("Belisarius Cawl", {"721623"}, 150)--]]
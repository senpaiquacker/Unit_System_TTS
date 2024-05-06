--[[Unit Prototype--]]
do PUnit = 
    {
    Name = "empty",
    ModelsGUID = {},
    PointsValue = 0,
    Description = "It's a test unit. Zero value",
    baseGUID="913c18",
    }
    
    --[[ SpawnUnit() //Spawns unit in physical space (on the layout)--]]
    function PUnit:SpawnUnit()
        UnitLayout:AddUnit(self)
    end

    --[[ CreateUnit() //Method to add new Unit to roster--]]
    function PUnit:CreateUnit()
        self:SpawnUnit()
        AddArmyPoints(self.PointsValue)
    end

    function PUnit:new(unit)
        local obj = unit or {}
        setmetatable(obj, self)
        return obj
    end
    PUnit.__index=PUnit
end


function CreateNewUnit(unit)
    local obj = {}
    setmetatable(obj, PUnit)
    obj.Name = unit.name
    obj.ModelsGUID = unit.models
    obj.PointsValue = unit.points
    obj.Description = unit.desc
    setmetatable(obj, PUnit)
    for i,v in pairs(obj) do
        print(i)
        print(v)
    end
    print(" ")
    UnitRoster[obj.Name] = obj
    return obj
end


--[[Unit Layout--]]
UnitLayout = {}
do
    local paste_pos = Vector(-107, 3, 35)
    for i=1,6 do UnitLayout[i]={}
        for j=1,6 do
            local new_pos = Vector(paste_pos.x + 12 * (j-1), paste_pos.y, paste_pos.z - 12 * (i-1))
            UnitLayout[i][j]={Unit=nil, Position = new_pos}
        end
    end
end

function UnitLayout:Count(name)
    local count = 0
    for i, line in ipairs(self) do
        for j, value in ipairs(line) do
            if value.Name == name then count = count + 1 end
        end
    end
    return count
end

--[[ GetLastEmptySlot() //Searches for Empty Slot in Layout --]]
function UnitLayout:GetFirstEmptySlot()
    local coords = {}
    for i, lines in ipairs(self) do
        local found_empty=false
        for j, v in ipairs(lines) do
            if v.Unit == nil then 
                found_empty=true; coords = {l=i, c=j}; break;
            end
        end
        if found_empty==true then break; end
    end
    return coords
end

--[[ AddUnit(PUnit unit) //Adds a new unit to layout --]]
function UnitLayout:AddUnit(unit)
    local indices = self:GetFirstEmptySlot()

    self[indices.l][indices.c].Unit = unit
    local pos = self[indices.l][indices.c].Position

    local placeHolder = getObjectFromGUID(PUnit.BaseGUID)
    copy{placeHolder}; paste{position = pos, snap_to_grid = true}

    for i, v in ipairs(unit.ModelsGUID) do
        local model = getObjectFromGUID(v)        
        copy{model}        
        local res = paste{position = pos + Vector(2*(i-1),0,0), snap_to_grid = false}
    end
end

ArmyTableGUID = "bfe1fb"

TotalArmyPoints = 0
ArmySize=1000

UnitRoster = 
{
    --["SkitariiRangers"] = PUnit:new("Skitarii Rangers", {"e53e79","052f88","7126e9"}, 70),
    --["SkitariiVanguard"] = PUnit:new("Skitarii Vanguard", {"74b704","72f3c0","3462e0"}, 80),
}



function onLoad()
    local armytable = getObjectFromGUID(ArmyTableGUID)
    armytable.setPosition({-74, 2, 0});  armytable.setScale({80, 0.8, 80})
    armytable.use_snap_points = true;    armytable.grid_projection = true
    SetPointsValue(0);
end

function CreateUnitButtonClick (player, value, id) 
    local unit = UnitRoster[value]
    for i,v in pairs(unit) do
        print(i)
    end
    unit:CreateUnit()
end
function SetPointsValue(value) TotalArmyPoints = value; UI.setValue("TotalArmyPoints", value .. "/" .. ArmySize); end
function AddArmyPoints(value) SetPointsValue(TotalArmyPoints + value); end
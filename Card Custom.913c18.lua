HoldedUnit=nil
HoldedModels={}
do  for i=1,5 do HoldedModels[i]={}
        for j=1,5 do HoldedModels[i][j]="" end 
end end

function onLoad()
    use_snap_points = true
    local snapPoints = {}
    local index = 1
    for i=-2,2 do 
        for j=-2,2 do 
            snapPoints[index] = {position=Vector(j*2, 0, i*2)}; index=index+1 
        end 
    end
    self.setSnapPoints(snapPoints)
end
function DeployModels(params)
    local topLeftPosition = self.getPosition() - Vector(4,0,4)
    if params.Alignment == "MiddleRound" then
        for i,v in ipairs(Sequence.MiddleRound) do
            HoldedModels[v[1]][v[2]] = getObjectFromGUID(params.Models[i])
        end
    elseif params.Alignment == "TopLeftLine" then
        for _,v in ipairs(Sequence.TopLeftLine) do
            
        end
    end
end

function FillTopLeftSequence()
    local sequence = {}
    for i=1,5 do
        for j=1,5 do
            sequence[(i-1)*5 + j]= {i,j}
        end
    end
    return sequence
end
function MiddleRoundSequence()
    local sequence = {}
    local i = 1
    sequence[i]={3,3};i=i+1

    for j=2,4 do sequence[i]={2,j};i=i+1 end
    for j=3,4 do sequence[i]={j,4};i=i+1 end
    for j=3,2,-1 do sequence[i]={4,j};i=i+1 end
    sequence[i]={3,2};i=i+1
    
    for j=1,5 do sequence[i]={1,j}; i=i+1 end
    for j=2,5 do sequence[i]={j,5}; i=i+1 end
    for j=4,1,-1 do sequence[i]={5,j};i=i+1 end
    for j=4,2,-1 do sequence[i]={j,1};i=i+1 end
    return sequence
end
local Sequence=
{
    TopLeftLine=FillTopLeftSequence(),
    MiddleRound=MiddleRoundSequence()
}
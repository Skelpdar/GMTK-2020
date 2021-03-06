LoveFrames = require("lib/loveframes")
TileMath = require("tileMath")

local M = {}

M.sprites = {love.graphics.newImage("assets/Lever1.png"),
			love.graphics.newImage("assets/Lever2.png"),
			love.graphics.newImage("assets/Lever3.png"),
			love.graphics.newImage("assets/Lever4.png"),
			love.graphics.newImage("assets/Lever5.png"),
			love.graphics.newImage("assets/Lever6.png"),
			}

local directionMapping = {
	[125] = {2,1},
	[136] = {6,1},
	[134] = {3,4},
	[146] = {1,6},
	[245] = {5, 4},
	[256] = {5, 6},
	[346] = {3,4},
	[235] = {2,3}
}		

local function createLever(level,x,y,railType,railx, raily, state)
	local lever = {}

	--Pos of the lever itself, in world coordinates
	lever.x = x
	lever.y = y
	-- Only controls the graphics
	lever.railType = railType

	-- Position of the railswitch it controls
	lever.railx = railx
	lever.raily = raily
	-- Whether or not it is toggled once on level start, 1 or 2
	lever.state = state or 1

	lever.button = LoveFrames.Create("imagebutton")
	print(directionMapping[railType])
	lever.button:SetImage(M.sprites[directionMapping[railType][state]])
	lever.button:SetText("")
	--button:Center()
	local worldpos = TileMath.tilePosCenter(railx,raily)
	lever.button:SetPos(worldpos.x+x, worldpos.y+y, true)

    lever.button.OnClick = function(object, x, y)
		occupied = false	
		for key, train in pairs(level.trains) do
			if train.levelPos.x ==  railx and train.levelPos.y == raily then
				print("Occupied")
				occupied = true
			end		
		end
		if occupied == false then	
	        level.switches[lever.railx][lever.raily]:toggle()
			sfx = love.audio.newSource("audio/sfx_gameplay_lever_1.wav", "stream")
			sfx:play()
			if lever.state == 1 then
				lever.state = 2
				lever.button:SetImage(M.sprites[directionMapping[lever.railType][lever.state]])
			else
				lever.state = 1
				lever.button:SetImage(M.sprites[directionMapping[lever.railType][lever.state]])
			end	
		end
    end

	return lever

end	

M.createLever = createLever

return M

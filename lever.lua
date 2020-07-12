LoveFrames = require("lib/loveframes")

local M = {}

M.sprites = {love.graphics.newImage("assets/Lever1.png"),
			love.graphics.newImage("assets/Lever2.png"),
			love.graphics.newImage("assets/Lever3.png"),
			love.graphics.newImage("assets/Lever4.png"),
			love.graphics.newImage("assets/Lever5.png"),
			love.graphics.newImage("assets/Lever6.png"),
			}

local directionMapping = {
	[136] = {6,1},
	[134] = {3,4},
	[146] = {1,6},
	[346] = {3,4}
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

	local button = LoveFrames.Create("imagebutton")
	button:SetImage(M.sprites[directionMapping[railType][state]])
    print(directionMapping[railType][1])
	button:SetText("")
	button:Center()
    button.OnClick = function(object, x, y)
		print(lever.railx)	
        level.switches[lever.railx][lever.raily]:toggle()
		if lever.state == 1 then
			lever.state = 2
			button:SetImage(M.sprites[directionMapping[lever.railType][lever.state]])
		else
			lever.state = 1
			button:SetImage(M.sprites[directionMapping[lever.railType][lever.state]])
		end	
    end

end	

M.createLever = createLever

return M

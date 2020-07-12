LoveFrames = require("lib/loveframes")

local M = {}

M.sprites = {love.graphics.newImage("assets/Lever1.png"),
			love.graphics.newImage("assets/Lever2.png"),
			love.graphics.newImage("assets/Lever3.png"),
			love.graphics.newImage("assets/Lever4.png"),
			love.graphics.newImage("assets/Lever5.png"),
			love.graphics.newImage("assets/Lever6.png"),
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
	-- Whether or not it is toggled once on level start
	lever.state = state or false

	local button = LoveFrames.Create("imagebutton")
	button:SetImage(M.sprites[1])
    button:SetText("")
	button:Center()
    button.OnClick = function(object, x, y)
		print(level.switches)	
        level.switches[lever.railx][lever.raily]:toggle()
    end

end	

M.createLever = createLever

return M

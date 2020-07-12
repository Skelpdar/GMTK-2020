TileMath = require("tileMath")

local M = {}

M.boxes = {}

--Airtime for boxes
M.airtime = 1

local function createBox(level, tilex,tiley, dir)
	local box = {}

	box.startx = tilex
	box.starty = tiley

	box.lifetime = 0

	local delta = TileMath.lvlPosDelta(dir)
	box.goalTiles = {x = tilex + 4*delta.x, y = tiley +4*delta.y}	

	box.image = love.graphics.newImage("assets/box.png")

	M.boxes[box] = box

	return box
end		

M.createBox = createBox

local function updateBoxes(dt)
	for key, box in pairs(M.boxes) do
		box.lifetime = box.lifetime + dt
	end		
end		

M.updateBoxes = updateBoxes

local function drawBoxes()
	for key, box in pairs(M.boxes) do
		if box.lifetime < M.airtime then
			local t = box.lifetime/M.airtime	
			local startpos = TileMath.tilePosCenter(box.startx, box.starty)	
			local endpos = TileMath.tilePosCenter(box.goalTiles.x, box.goalTiles.y)
			local height = 50*(-t*t+t)
			love.graphics.draw(box.image, (1-t)*startpos.x+endpos.x*t, (1-t)*startpos.y + endpos.y*t-height)
		else
			local pos = TileMath.tilePosCenter(box.goalTiles.x, box.goalTiles.y)	
			love.graphics.draw(box.image, pos.x, pos.y)
		end		

	end		
end

M.drawBoxes = drawBoxes

return M

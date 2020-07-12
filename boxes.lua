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

	local delta = TileMath.lvlPosDelta(dir, {x=tilex, y=tiley})
	local delta2 = TileMath.lvlPosDelta(dir, {x=tilex+delta.x, y=tiley+delta.y})
	local delta3 = TileMath.lvlPosDelta(dir, {x=tilex+delta.x+delta2.x, y=tiley+delta.y+delta2.y})
	box.goalTiles = {x = tilex + delta.x + delta2.x +delta3.x, y = tiley +delta.y+delta2.y+delta3.y}	

	box.image = love.graphics.newImage("assets/box.png")

	M.boxes[box] = box

	for key,val in pairs(level.targets) do
		print(val.x)
		print(val.y)
		if val.x == box.goalTiles.x and val.y == box.goalTiles.y then
			val.delivered = true
			print("HIT TARGET")
		end		
	end


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
			love.graphics.draw(box.image, (1-t)*startpos.x+endpos.x*t-box.image:getWidth()/2, (1-t)*startpos.y + endpos.y*t-height- box.image:getHeight()/2)
		else
			local pos = TileMath.tilePosCenter(box.goalTiles.x, box.goalTiles.y)	
			love.graphics.draw(box.image, pos.x-box.image:getWidth()/2, pos.y-box.image:getHeight()/2)
		end		

	end		
end

M.drawBoxes = drawBoxes

return M

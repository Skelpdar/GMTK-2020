--[ This holds the code for our hexagonal levels
--
--]

--[
--Directions for rails:
--  1  6
--2      5
--  3  4
--
--]

local M = {}

local rail_sprites = {}

local example_tracks_tileset = {{25, 24,0 , 0     },
								 {0,   14, 0,  0     },
								{0, 0    , 135, 25},
								 {25, 26,0 , 0      }}

local example_elements_tileset = {{{},             {}, {},            {}},
								  {   {},            {},            {}, {}},
								  {{},             {}, {"switch3-5"}, {}},
								  {   {"bluetrain"},   {}, {}, {}}}

function M.loadRailSprites()
	
	rail_sprites[13] = love.graphics.newImage("assets/Rail13.png")
	rail_sprites[25] = love.graphics.newImage("assets/Rail25.png")
	rail_sprites[1346] = love.graphics.newImage("assets/Rail1346.png")
	rail_sprites[135] = love.graphics.newImage("assets/Rail135.png")
	rail_sprites[136] = love.graphics.newImage("assets/Rail136.png")
	rail_sprites[14] = love.graphics.newImage("assets/Rail14.png")
	rail_sprites[146] = love.graphics.newImage("assets/Rail146.png")
	rail_sprites[15] = love.graphics.newImage("assets/Rail15.png")
	rail_sprites[16] = love.graphics.newImage("assets/Rail16.png")
	rail_sprites[24] = love.graphics.newImage("assets/Rail24.png")
	rail_sprites[246] = love.graphics.newImage("assets/Rail246.png")
	rail_sprites[25] = love.graphics.newImage("assets/Rail25.png")
	rail_sprites[26] = love.graphics.newImage("assets/Rail26.png")
	rail_sprites[34] = love.graphics.newImage("assets/Rail34.png")
	rail_sprites[346] = love.graphics.newImage("assets/Rail346.png")
	rail_sprites[35] = love.graphics.newImage("assets/Rail35.png")
	rail_sprites[36] = love.graphics.newImage("assets/Rail36.png")
	rail_sprites[46] = love.graphics.newImage("assets/Rail46.png")
end		

-- Takes a tracks tileset as in the above example and renders it
function M.drawRails(width, height)
	--love.graphics.draw(rail_sprites[25], 32, 32)	
	for k, row in pairs(example_tracks_tileset) do
		for i, tile in pairs(row) do
			if tile ~= 0 then
				local x,y = M.tilePos(k,i)		
				love.graphics.draw(rail_sprites[tile], x, y)
			end		
		end		
	end
end		

function M.tilePos(k,i)
	offset = 0	
	if math.fmod(k, 2) == 0 then
		offset = 16	
	end
	return i*32+offset, k*27

end		

return M

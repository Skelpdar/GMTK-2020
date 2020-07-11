--[[ This holds the code for our hexagonal levels
--
--]]

--[[
--Directions for rails:
--  1  6
--2      5
--  3  4
--
--]]

local M = {}

-- Well, holds the sprites for the rails
local rail_sprites = {}

local prop_sprites = {}

function M.loadLevel(level)
    M.rails = level.rails
    M.width = level.width
    M.height = level.height

    --M.props = level.props
end		

-- Just loads the sprites for the rails
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

function M.loadPropSprites()
    prop_sprites.paprica = love.graphics.newImage("assets/props/paprica.png")
end		

-- Takes a tracks tileset as in the above example and renders it
function M.drawRails(width, height)
    for k, row in pairs(M.rails) do
        for i, tile in pairs(row) do
            if tile ~= 0 then
                local x,y = M.tilePos(k,i)		
                love.graphics.draw(rail_sprites[tile], x, y)
            end		
        end		
    end
end		

-- Takes a props tileset as in the above example and renders it
function M.drawProps(width, height)
    for k, row in pairs(M.props) do
        for i, tile in pairs(row) do
            if tile ~= 0 then
                local x,y = M.tilePos(k,i)		
                love.graphics.draw(prop_sprites[tile], x, y)
            end		
        end		
    end
end	

-- Returns the upper left corner of a tile (in world coordinates)
function M.tilePos(k,i)
    local offset = 0	
    if math.fmod(k, 2) == 0 then
        offset = 16	
    end
    return i*32+offset, k*27

end		

-- Same as above, but the center of the tile
function M.tilePosCenter(k,i)
    local x,y = M.tilesPos(k,i)
    return x+16, y+20
end

return M

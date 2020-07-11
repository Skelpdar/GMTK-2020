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

Switch = require("switch")

local M = {}

-- Well, holds the sprites for the rails
local rail_sprites = {}

local prop_sprites = {}

M.switchMapping = {
    [13]    = Switch.createSwitch(1, {3}),
    [14]    = Switch.createSwitch(1, {4}),
    [15]    = Switch.createSwitch(1, {5}),
    [16]    = Switch.createSwitch(1, {6}),
    [24]    = Switch.createSwitch(2, {4}),
    [25]    = Switch.createSwitch(2, {5}),
    [26]    = Switch.createSwitch(2, {6}),
    [34]    = Switch.createSwitch(3, {4}),
    [35]    = Switch.createSwitch(3, {5}),
    [36]    = Switch.createSwitch(3, {6}),
    [46]    = Switch.createSwitch(4, {6}),
    [136]   = Switch.createSwitch(3, {6, 1}),
    [146]   = Switch.createSwitch(4, {1, 6}),
    [346]   = Switch.createSwitch(6, {3, 4}),
    [1346]  = Switch.createCrossing({1, 6}, {4, 3}),
    [135]   = {
        [1] = Switch.createSwitch(1, {5, 3}),
        [3] = Switch.createSwitch(3, {1, 5}),
        [5] = Switch.createSwitch(5, {3, 1})
    },
    [246]   = {
        [2] = Switch.createSwitch(2, {6, 4}),
        [4] = Switch.createSwitch(4, {2, 6}),
        [6] = Switch.createSwitch(6, {4, 2})
    }
}

-- Just loads the sprites for the rails
function M.loadRailSprites()
    rail_sprites[13] = love.graphics.newImage("assets/Rail13.png")
    rail_sprites[14] = love.graphics.newImage("assets/Rail14.png")
    rail_sprites[15] = love.graphics.newImage("assets/Rail15.png")
    rail_sprites[16] = love.graphics.newImage("assets/Rail16.png")
    rail_sprites[24] = love.graphics.newImage("assets/Rail24.png")
    rail_sprites[25] = love.graphics.newImage("assets/Rail25.png")
    rail_sprites[26] = love.graphics.newImage("assets/Rail26.png")
    rail_sprites[34] = love.graphics.newImage("assets/Rail34.png")
    rail_sprites[35] = love.graphics.newImage("assets/Rail35.png")
    rail_sprites[36] = love.graphics.newImage("assets/Rail36.png")
    rail_sprites[46] = love.graphics.newImage("assets/Rail46.png")
    rail_sprites[135] = love.graphics.newImage("assets/Rail135.png")
    rail_sprites[136] = love.graphics.newImage("assets/Rail136.png")
    rail_sprites[146] = love.graphics.newImage("assets/Rail146.png")
    rail_sprites[246] = love.graphics.newImage("assets/Rail246.png")
    rail_sprites[346] = love.graphics.newImage("assets/Rail346.png")
    rail_sprites[1346] = love.graphics.newImage("assets/Rail1346.png")
end

function M.loadPropSprites()
    prop_sprites.paprica = love.graphics.newImage("assets/props/paprica.png")
end		

-- Takes a tracks tileset as in the above example and renders it
function M.drawRails(tiles)
    for k, row in pairs(tiles) do
        for i, tile in pairs(row) do
            if tile ~= 0 then
                local x,y = M.tilePos(k,i)		
                love.graphics.draw(rail_sprites[tile], x, y)
            end		
        end		
    end
end		

-- Takes a props tileset as in the above example and renders it
function M.drawProps()
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
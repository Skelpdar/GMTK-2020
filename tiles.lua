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

Switch      = require("switch")
TileMath    = require("tileMath")

local M = {}

-- Well, holds the sprites for the rails
M.rail_sprites = {
    [13] = love.graphics.newImage("assets/Rail13.png"),
    [14] = love.graphics.newImage("assets/Rail14.png"),
    [15] = love.graphics.newImage("assets/Rail15.png"),
    [16] = love.graphics.newImage("assets/Rail16.png"),
    [24] = love.graphics.newImage("assets/Rail24.png"),
    [25] = love.graphics.newImage("assets/Rail25.png"),
    [26] = love.graphics.newImage("assets/Rail26.png"),
    [34] = love.graphics.newImage("assets/Rail34.png"),
    [35] = love.graphics.newImage("assets/Rail35.png"),
    [36] = love.graphics.newImage("assets/Rail36.png"),
    [46] = love.graphics.newImage("assets/Rail46.png"),
    [135] = love.graphics.newImage("assets/Rail135.png"),
    [136] = love.graphics.newImage("assets/Rail136.png"),
    [146] = love.graphics.newImage("assets/Rail146.png"),
    [246] = love.graphics.newImage("assets/Rail246.png"),
    [346] = love.graphics.newImage("assets/Rail346.png"),
    [1346] = love.graphics.newImage("assets/Rail1346.png"),
}

M.prop_sprites = {}

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
end

function M.loadPropSprites()
    M.prop_sprites.paprica = love.graphics.newImage("assets/props/paprica.png")
end		

-- Takes a tracks tileset as in the above example and renders it
function M.drawRails(tiles)
    for x, column in pairs(tiles) do
        for y, tile in pairs(column) do
            if tile ~= 0 then
                local pos = TileMath.tilePos(x, y)
                love.graphics.draw(M.rail_sprites[tile], pos.x, pos.y)
            end		
        end		
    end
end		

-- Takes a props tileset as in the above example and renders it
function M.drawProps()
    for x, column in pairs(M.props) do
        for y, tile in pairs(column) do
            if tile ~= 0 then
                local pos = TileMath.tilePos(x, y)		
                love.graphics.draw(M.prop_sprites[tile], pos.x, pos.y)
            end		
        end		
    end
end

return M

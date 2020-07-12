local M = {}

local function pixelPos(tileX, tileY)
    local y = tileY / 27

    local pos = {}
    if math.fmod(y, 2) == 0 then
        pos = {x = math.floor((tileX - 16) / 32), y = math.floor(y)}
    else
        pos = {x = math.floor(tileX / 32), y = math.floor(y)}
    end

    if pos.x <= 0 then pos.x = 1 end
    if pos.x > 16 then pos.x = 16 end
    if pos.y <= 0 then pos.y = 1 end
    if pos.y > 13 then pos.y = 13 end

    return pos
end

M.pixelPos = pixelPos

-- Returns the upper left corner of a tile (in world coordinates)
local function tilePos(x, y)
    local offset = 0
    if math.fmod(y, 2) == 0 then
        offset = 16	
    end
    return {x = x*32 + offset, y = y*27}
end

M.tilePos = tilePos

-- Same as above, but the center of the tile
local function tilePosCenter(x ,y)
    local pos = tilePos(x, y)
    return {x = pos.x + 16, y = pos.y + 20}
end

M.tilePosCenter = tilePosCenter

local direction = {
    UpLeft      = 1, Left   = 2, DownLeft   = 3,
    DownRight   = 4, Right  = 5, UpRight    = 6,
}

M.direction = direction

local function lvlPosDelta(dir)
    if dir        == direction.UpLeft then
        return {x   = -1, y = -1}

    elseif dir    == direction.Left then
        return {x   = -1, y = 0}

    elseif dir    == direction.DownLeft then
        return {x   = -1, y = 1}

    elseif dir    == direction.DownRight then
        return {x   = 1, y = 1}

    elseif dir    == direction.Right then
        return {x   = 1, y = 0}

    elseif dir    == direction.UpRight then
        return {x   = 1, y = -1}
    end
end

M.lvlPosDelta = lvlPosDelta

local function withinBounds(lvlPosition, level)
    if     lvlPosition.x == 0 then
        return false

    elseif lvlPosition.x > level.width then
        print(table.getn(level))
        return false

    elseif lvlPosition.y == 0 then
        return false

    elseif lvlPosition.y > level.height then
        return false
    end
    
    return true
end

M.withinBounds = withinBounds

local function opposite(dir)
    if dir == direction.UpLeft      then return direction.DownRight end
    if dir == direction.Left        then return direction.Right end
    if dir == direction.DownLeft    then return direction.UpRight end
    if dir == direction.DownRight   then return direction.UpLeft end
    if dir == direction.Right       then return direction.Left end
    if dir == direction.UpRight     then return direction.DownLeft end
end

M.opposite = opposite

return M

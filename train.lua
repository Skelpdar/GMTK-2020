TileMath = require("tileMath")

local Cargo = {none = 0, blue = 1, purple = 2}

local Export = {}

--[[local function createRailwagon(trainParent, cargoType)
    local railwagon = {
        tilePos = trainParent.tilePos,
        cargo = cargoType
    }

    return railwagon
end]]

local function createTrain(levelPos, direction, speed)
    local train = {
        levelPos = levelPos or {x = 1, y = 1},
        tilePos = TileMath.tilePos(levelPos.x, levelPos.y),
        direction = direction or TileMath.direction.UpLeft,
        speed = speed or 1, ticks = 0,
        sprites = {
            [TileMath.direction.UpLeft] = 
                love.graphics.newImage("assets/train14.png"),

            [TileMath.direction.Left] = 
                love.graphics.newImage("assets/train25.png"),

            [TileMath.direction.DownLeft] = 
                love.graphics.newImage("assets/train26.png"),

            [TileMath.direction.DownRight] = 
                love.graphics.newImage("assets/train14.png"),

            [TileMath.direction.Right] = 
                love.graphics.newImage("assets/train25.png"),

            [TileMath.direction.UpRight] = 
                love.graphics.newImage("assets/train26.png"),
        }
    }
    
    return train
end

Export.createTrain = createTrain

local function move(train, level)
    train.ticks = train.ticks + 1
    if train.ticks ~= train.speed then
        return train
    end

    train.ticks = 0

    local positionDelta = TileMath.lvlPosDelta(train.direction)
    local newLvlPos = {
        x = train.levelPos.x + positionDelta.x,
        y = train.levelPos.y + positionDelta.y
    }

    if TileMath.withinBounds(newLvlPos, level) ~= true then
        return train
    end

    train.levelPos  = newLvlPos
    train.tilePos   =
        TileMath.tilePos(train.levelPos.x, train.levelPos.y)
    
    train.direction = 
        level.switches[
            train.levelPos.x][
                train.levelPos.y][
                    TileMath.opposite(train.direction)]

    return train
end

Export.move = move

local function drawTrain(train)
    love.graphics.draw(
        train.sprites[train.direction],
        train.tilePos.x, train.tilePos.y
    )
end

Export.drawTrain = drawTrain

return Export
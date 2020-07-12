TileMath = require("tileMath")

local Export = {}

local function createTrain(levelPos, direction, speed, trainType)
	 	
    local train = {
		active = true,	
		trainType = trainType or "engine",	
        levelPos = levelPos or {x = 1, y = 1},
        tilePos = TileMath.tilePos(levelPos.x, levelPos.y),
        direction = direction or TileMath.direction.UpLeft,
        speed = speed or 1, ticks = 0,
        sprites = {
            [TileMath.direction.UpLeft] = 
                love.graphics.newImage("assets/TrainUpLeft.png"),

            [TileMath.direction.Left] = 
                love.graphics.newImage("assets/TrainLeft.png"),

            [TileMath.direction.DownLeft] = 
                love.graphics.newImage("assets/TrainDownLeft.png"),

            [TileMath.direction.DownRight] = 
                love.graphics.newImage("assets/TrainDownRight.png"),

            [TileMath.direction.Right] = 
                love.graphics.newImage("assets/TrainRight.png"),

            [TileMath.direction.UpRight] = 
                love.graphics.newImage("assets/TrainUpRight.png"),
        }
    }
	if train.trainType == "wagon" then
		train.sprites = { 
            [TileMath.direction.UpLeft] = 
                love.graphics.newImage("assets/TrainCarUpLeft.png"),

            [TileMath.direction.Left] = 
                love.graphics.newImage("assets/TrainCarLeft.png"),

            [TileMath.direction.DownLeft] = 
                love.graphics.newImage("assets/TrainCarDownLeft.png"),

            [TileMath.direction.DownRight] = 
                love.graphics.newImage("assets/TrainCarDownRight.png"),

            [TileMath.direction.Right] = 
                love.graphics.newImage("assets/TrainCarRight.png"),

            [TileMath.direction.UpRight] = 
                love.graphics.newImage("assets/TrainCarUpRight.png"),
		}
	end		
    if train.trainType == "wagonloaded" then
		train.sprites = { 
            [TileMath.direction.UpLeft] = 
                love.graphics.newImage("assets/LoadedUpLeft.png"),

            [TileMath.direction.Left] = 
                love.graphics.newImage("assets/LoadedLeft.png"),

            [TileMath.direction.DownLeft] = 
                love.graphics.newImage("assets/LoadedDownLeft.png"),

            [TileMath.direction.DownRight] = 
                love.graphics.newImage("assets/LoadedDownRight.png"),

            [TileMath.direction.Right] = 
                love.graphics.newImage("assets/LoadedRight.png"),

            [TileMath.direction.UpRight] = 
                love.graphics.newImage("assets/LoadedUpRight.png"),
		}
	end	
    return train
end

Export.createTrain = createTrain

local function move(train, level)
	if train.active then	
    train.ticks = train.ticks + 1
    if train.ticks ~= train.speed then
        return train
    end

    train.ticks = 0

    local positionDelta = TileMath.lvlPosDelta(train.direction, train.levelPos)
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
	end
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

local function disableTrain(allTrains, train, boxes, level)
		
	train.active = false	

	-- Catapult boxes :D
	if train.trainType == "wagonloaded" then
		boxes.createBox(level, train.levelPos.x, train.levelPos.y, train.direction)
	end		

	for key, otherTrain in pairs(allTrains) do
		local otherDelta = TileMath.lvlPosDelta(otherTrain.direction, otherTrain.levelPos)
		if (otherTrain.trainType == "wagon" or otherTrain.trainType == "wagonloaded") and otherTrain.levelPos.x + otherDelta.x == train.levelPos.x and otherTrain.levelPos.y + otherDelta.y == train.levelPos.y then
			disableTrain(allTrains, otherTrain)
		end		
	end		
end

Export.disableTrain = disableTrain

return Export

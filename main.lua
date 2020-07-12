Bump = require("lib/bump/bump")
Cron = require("lib/cron/cron")
MGL = require("lib/MGL/src/MGL")
LoveFrames = require("lib/loveframes")

AnimLib = require("lib/animation/animation")

Tiles = require("tiles")
Trains = require("train")
Switch = require("switch")
Boxes = require("boxes")
Lever = require("lever")

G_Framerate = 0

G_ScreenWidth = 640
G_ScreenHeight = 480

function love.load()
    G_screenCanvas = love.graphics.newCanvas(640,480)

    local levelDescription = require("levels/level1")

    local function loadLevel(levelDescription)
        local level = {}

        level.switches  = {}
        level.tiles     = {}
        level.trains    = {}

        for x = 1, levelDescription.width, 1 do
            level.switches[x]   = {}
            level.tiles[x]      = {}
            for y = 1, levelDescription.height, 1 do
                local rail = levelDescription.rails[y][x]

                if type(rail.id) ~= "table" then
                    level.switches[x][y]    = Tiles.switchMapping[rail.id]
                    level.tiles[x][y]       = rail.id
                else
                    level.switches[x][y]    = Tiles.switchMapping[rail.id[1]][rail.id[2]]
                    level.tiles[x][y]       = rail.id[1]
                end
                if type(rail.train) ~= "nil" then
                    table.insert(
                        level.trains,
                        Trains.createTrain(
                            {x = x, y = y}, rail.train.dir, rail.train.speed, rail.train.trainType
                        )
                    )
                end
                if type(rail.toggled) ~= "nil" then
                    if rail.toggled == true then
                        level.switches[x][y]:toggle()
                    end
                end
				if type(rail.hasLever) ~= "nil" then
					if rail.hasLever == true then
						local toggled = 1	
						if type(rail.toggled) ~= "nil" then
							if rail.toggled == true then
								toggled = 2
							end	
						end	
						Lever.createLever(level, 40, 0, rail.id, x, y, toggled)
					end		
				end		
            end
        end

        level.width     = levelDescription.width
        level.height    = levelDescription.height

        return level
    end		

    G_Level = loadLevel(levelDescription)

    Tiles.loadRailSprites()

    love.window.setMode(G_ScreenWidth, G_ScreenHeight, {vsync=-1, resizable=true})
    love.graphics.setBackgroundColor(19/255, 20/255, 68/255)

	--Temp stuff
	--box = Boxes.createBox(G_Level, 5,5,5)
	--Lever.createLever(G_Level, 20, 0, 134, 2, 11, 1)
end

-- love.update is given the timestep since the last update in seconds
-- love.timer.getFPS is also available
function love.update(dt)
    G_Framerate = 1/dt	

	Boxes.updateBoxes(dt)
    LoveFrames.update(dt)
end

function love.draw()
    love.graphics.setCanvas(G_screenCanvas)
    love.graphics.clear(0,0,0,1)

    --SetCameraPosition(love, -Camera_x, -Camera_y)

    Tiles.drawRails(G_Level.tiles)

    for key, train in pairs(G_Level.trains) do
        Trains.drawTrain(train)
    end

	Boxes.drawBoxes()

    love.graphics.setCanvas()


    -- This resets the translation above
    -- so that we can draw GUI in screen space coordinates
    love.graphics.origin()

    local windowwidth, windowheight = love.graphics.getDimensions()

    love.graphics.draw(G_screenCanvas, windowwidth/2-G_ScreenWidth/2, windowheight/2-G_ScreenHeight/2)

    -- This resets the translation above
    -- so that we can draw GUI in screen space coordinates
    love.graphics.origin()
    love.graphics.translate(windowwidth/2-G_ScreenWidth/2, windowheight/2-G_ScreenHeight/2) 

    -- Coloured text, love.graphics.printf is available for formatted text	
    -- To round a number x with a precision delta_x do:
    -- math.floor(x + delta_x / 2)
    love.graphics.print({{1,0,0,1},math.floor(G_Framerate+0.5)}, 0, 0)

    LoveFrames.draw()
end

function love.mousepressed(x, y, button)


    LoveFrames.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)


    LoveFrames.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
    if key == "n" then
        for key, train in pairs(G_Level.trains) do
            Trains.move(train, G_Level)
        end

	-- Check for collisions
	local prevTrains = {} 
	for key, train in pairs(G_Level.trains) do
		for k, prevPos in pairs(prevTrains) do
			if prevPos.levelPos.x == train.levelPos.x and prevPos.levelPos.y == train.levelPos.y then
				Trains.disableTrain(G_Level.trains,train, G_Level)
				Trains.disableTrain(G_Level.trains,prevPos,G_Level)
			end	
		end
		prevTrains[key] = train
	end		
	end

	-- Catapult boxes
	for key, train in pairs(G_Level.trains) do
		if train.trainType == "wagonloaded" and train.active == false then
			Boxes.createBox(G_Level, train.levelPos.x, train.levelPos.y, train.direction)
			train.trainType = "wagon"
			Trains.makeWagon(train)	
		end		
	end		

    LoveFrames.keypressed(key, unicode)
end

function love.keyreleased(key)


    LoveFrames.keyreleased(key)
end

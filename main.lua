Bump = require("lib/bump/bump")
Cron = require("lib/cron/cron")
MGL = require("lib/MGL/src/MGL")
LoveFrames = require("lib/loveframes")

AnimLib = require("lib/animation/animation")
Tiles = require("Tiles")

Switch = require("switch")

TrainTracer = require("trainTracer")

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

        for i, row in pairs(levelDescription.rails) do
            level.switches[i]   = {}
            level.tiles[i]      = {}
            for j, railID in pairs(row) do
                if type(railID) ~= "table" then
                    level.switches[i][j]    = Tiles.switchMapping[railID]
                    level.tiles[i][j]       = railID
                else
                    level.switches[i][j]    = Tiles.switchMapping[railID[1]][railID[2]]
                    level.tiles[i][j]       = railID[1]
                end
            end
        end

        return level
    end		

    G_Level = loadLevel(levelDescription)

    Tiles.loadRailSprites()

    love.window.setMode(G_ScreenWidth, G_ScreenHeight, {vsync=-1, resizable=true})
    love.graphics.setBackgroundColor(19/255, 20/255, 68/255)
end

-- love.update is given the timestep since the last update in seconds
-- love.timer.getFPS is also available
function love.update(dt)
    G_Framerate = 1/dt	
    
    LoveFrames.update(dt)
end

function love.draw()
    love.graphics.setCanvas(G_screenCanvas)
    love.graphics.clear(0,0,0,1)

    --SetCameraPosition(love, -Camera_x, -Camera_y)

    Tiles.drawRails(G_Level.tiles)

    TrainTracer:draw()

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
    if key == "up" then
        TrainTracer:nextSprite()
    end
    
    if key == "down" then
        TrainTracer:previousSprite()
    end
    
    if key == "w" then
        TrainTracer.pos.y = TrainTracer.pos.y - TrainTracer.stepSize
    end
    
    if key == "s" then
        TrainTracer.pos.y = TrainTracer.pos.y + TrainTracer.stepSize
    end
    
    if key == "d" then
        TrainTracer.pos.x = TrainTracer.pos.x + TrainTracer.stepSize
    end
    
    if key == "a" then
        TrainTracer.pos.x = TrainTracer.pos.x - TrainTracer.stepSize
    end
    
    if key == "p" then
        TrainTracer:print()
    end
    
    if key == "o" then
        TrainTracer:output()
    end
    
        LoveFrames.keypressed(key, unicode)
end

function love.wheelmoved(x, y)
    if y > 0 then
        TrainTracer.stepSize = TrainTracer.stepSize + 1
    elseif y < 0 then
        TrainTracer.stepSize = TrainTracer.stepSize - 1
    end
end

function love.keyreleased(key)


    LoveFrames.keyreleased(key)
end

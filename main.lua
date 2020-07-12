Bump = require("lib/bump/bump")
Cron = require("lib/cron/cron")
MGL = require("lib/MGL/src/MGL")
LoveFrames = require("lib/loveframes")

AnimLib = require("lib/animation/animation")

Tiles = require("tiles")
Trains = require("train")
Switch = require("switch")

G_Framerate = 0

G_ScreenWidth = 640
G_ScreenHeight = 480

G_Level = {}
G_OutLevel = {}

EditMode = {
    "Tracks", "Trains", "Levers", "Toggle", "Cars", "Cargo",
    Tracks = "Tracks", Trains = "Trains", Levers = "Levers", Toggles = "Toggle", Cars = "Cars", Cargo = "Cargo"
}
NumModes = 6

G_Editing = 1

Direction = {
    "UpLeft", "Left", "DownLeft",
    "DownRight", "Right", "UpRight",
}

G_Direction = TileMath.direction.UpLeft

TrainTypeNames = {
    "engine", "wagon", "wagonloaded", "barrier"
}

TrainType = {
    engine = 1, wagon = 2, wagonloaded = 3, barrier = 4
}

G_TrainType = TrainType.engine

function InitLevel(level)
    level.switches  = {}
    level.tiles     = {}
    level.trains    = {}
    level.levers    = {}

    for x = 1, 16, 1 do
        level.switches[x]   = {}
        level.tiles[x]      = {}
        level.trains[x]     = {}
        level.levers[x]      = {}

        for y = 1, 13, 1 do
            level.switches[x][y] = 0
            level.tiles[x][y] = 0
            level.trains[x][y] = 0
            level.levers[x][y] = 0
        end
    end

    level.tileIndicies = {}

    local i = 1
    for index, sprite in pairs(Tiles.switchMapping) do
        level.tileIndicies[i] = index
        i = i + 1
    end

    level.selectedTile = 1
end

function love.load()
    G_screenCanvas = love.graphics.newCanvas(640,480)

    InitLevel(G_Level)
    InitLevel(G_OutLevel)

    Tiles.loadRailSprites()

    love.window.setMode(G_ScreenWidth, G_ScreenHeight, {vsync=-1, resizable=true})
    love.graphics.setBackgroundColor(19/255, 20/255, 68/255)
end

-- love.update is given the timestep since the last update in seconds
-- love.timer.getFPS is also available
G_CurrentTile   = {x = 1, y = 1}
G_MousePos      = {x = 1, y = 1}   

function love.update(dt)
    G_Framerate = 1/dt

    local x, y = love.mouse.getPosition()
    G_MousePos = TileMath.pixelPos(x, y)

    if (G_MousePos.x ~= G_CurrentTile.x) or (G_MousePos.y ~= G_CurrentTile.y) then
        G_Level.tiles[G_CurrentTile.x][G_CurrentTile.y] = 0
        G_Level.trains[G_CurrentTile.x][G_CurrentTile.y] = 0
        G_CurrentTile = G_MousePos
    end

    if EditMode[G_Editing] == EditMode.Tracks then
        if (G_MousePos.x == G_CurrentTile.x) and (G_MousePos.y == G_CurrentTile.y) then
            G_Level.tiles[G_CurrentTile.x][G_CurrentTile.y] = G_Level.tileIndicies[G_Level.selectedTile]
        end
    elseif EditMode[G_Editing] == EditMode.Trains then
        if (G_MousePos.x == G_CurrentTile.x) and (G_MousePos.y == G_CurrentTile.y) then
            G_Level.trains[G_CurrentTile.x][G_CurrentTile.y] =
                Trains.createTrain(
                    G_CurrentTile, G_Direction, 1,
                    TrainTypeNames[G_TrainType])
        end
    end

    LoveFrames.update(dt)
end

function love.draw()
    love.graphics.setCanvas(G_screenCanvas)
    love.graphics.clear(0,0,0,1)

    --SetCameraPosition(love, -Camera_x, -Camera_y)

    Tiles.drawRails(G_OutLevel.tiles, G_OutLevel.switches, G_OutLevel.levers)
    Tiles.drawRails(G_Level.tiles, G_Level.switches, G_OutLevel.levers)

    for i, column in pairs(G_Level.trains) do
        for j, train in pairs(column) do
            if train ~= 0 then
                Trains.drawTrain(train)
            end
        end
    end

    for i, column in pairs(G_OutLevel.trains) do
        for j, train in pairs(column) do
            if train ~= 0 then
                Trains.drawTrain(train)
            end
        end
    end

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

    love.graphics.print("x: " .. G_MousePos.x, 0, 0)
    love.graphics.print("y: " .. G_MousePos.y, 0, 12)

    if EditMode[G_Editing] == EditMode.Tracks then
        love.graphics.print("Tile selected: " .. G_Level.selectedTile, 0, 26)
    elseif EditMode[G_Editing] == EditMode.Trains then
        love.graphics.print(
            "Direction: " .. Direction[G_Direction] .. 
            ", TrainType: " .. TrainTypeNames[G_TrainType], 0, 26)
    end


    love.graphics.print("EditMode: " .. EditMode[G_Editing], 0, 38)

    LoveFrames.draw()
end

function IncrementSelTile()
    G_Level.selectedTile = G_Level.selectedTile + 1
    
    if G_Level.selectedTile == table.getn(G_Level.tileIndicies) then
        G_Level.selectedTile = 1
    end
end

function DecrecmentSelTile()
    G_Level.selectedTile = G_Level.selectedTile - 1
    
    if G_Level.selectedTile == 0 then
        G_Level.selectedTile = table.getn(G_Level.tileIndicies)
    end
end

function IncrementMode()
    G_Editing = G_Editing + 1
    
    if G_Editing > NumModes then
        G_Editing = 1
    end
end

function DecrementMode()
    G_Editing = G_Editing - 1
    
    if G_Editing == 0 then
        G_Editing =  NumModes
    end
end

function IncrementDir()
    G_Direction = G_Direction + 1
    
    if G_Direction > 6 then
        G_Direction =  1
    end
end

function DecrementDir()
    G_Direction = G_Direction - 1
    
    if G_Direction == 0 then
        G_Direction =  6
    end
end

function love.wheelmoved(x, y)
    if y > 0 then
        if EditMode[G_Editing] == EditMode.Tracks then
            IncrementSelTile()
        elseif EditMode[G_Editing] == EditMode.Trains then
            IncrementDir()
        end

    elseif y < 0 then
        if EditMode[G_Editing] == EditMode.Tracks then
            DecrecmentSelTile()
        elseif EditMode[G_Editing] == EditMode.Trains then
            DecrementDir()
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then

        if EditMode[G_Editing] == EditMode.Tracks then
            G_OutLevel.tiles[G_MousePos.x][G_MousePos.y] =
                G_Level.tileIndicies[G_Level.selectedTile]
            
            G_OutLevel.switches[G_MousePos.x][G_MousePos.y] = 0

            G_OutLevel.levers[G_MousePos.x][G_MousePos.y] = 0

        elseif EditMode[G_Editing] == EditMode.Trains then
            G_OutLevel.trains[G_MousePos.x][G_MousePos.y] =
                Trains.createTrain(
                    G_CurrentTile, G_Direction, 1,
                    TrainTypeNames[G_TrainType])
        
        elseif EditMode[G_Editing] == EditMode.Toggles then
            if G_OutLevel.tiles[G_MousePos.x][G_MousePos.y] ~= 0 then
                if G_OutLevel.switches[G_MousePos.x][G_MousePos.y] == 0 then
                    G_OutLevel.switches[G_MousePos.x][G_MousePos.y] = 1
                else
                    G_OutLevel.switches[G_MousePos.x][G_MousePos.y] = 0
                end
            end

        elseif EditMode[G_Editing] == EditMode.Levers then
            if G_OutLevel.tiles[G_MousePos.x][G_MousePos.y] ~= 0 then
                if G_OutLevel.levers[G_MousePos.x][G_MousePos.y] == 0 then
                    G_OutLevel.levers[G_MousePos.x][G_MousePos.y] = 1
                else
                    G_OutLevel.levers[G_MousePos.x][G_MousePos.y] = 0
                end
            end
        end

    elseif button == 2 then

        if EditMode[G_Editing] == EditMode.Tracks then
            G_OutLevel.tiles[G_MousePos.x][G_MousePos.y] = 0
            
            G_OutLevel.switches[G_MousePos.x][G_MousePos.y] = 0

            G_OutLevel.levers[G_MousePos.x][G_MousePos.y] = 0

        elseif EditMode[G_Editing] == EditMode.Trains then
            G_OutLevel.trains[G_MousePos.x][G_MousePos.y] = 0
        end

    end

    LoveFrames.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)


    LoveFrames.mousereleased(x, y, button)
end

function Serialise(level)
    local line = "{"

    for y = 1, 13, 1 do
        line = line .. "{"
        for x = 1, 16, 1 do
            if level.tiles[x][y] == 135 then
                line = line .. "{id = {" .. level.tiles[x][y] .. ", 1}"

            elseif level.tiles[x][y] == 246 then
                line = line .. "{id = {" .. level.tiles[x][y] .. ", 2}"

            else
                line = line .. "{id = " .. level.tiles[x][y]
            end

            if level.trains[x][y] ~= 0 then
                line = 
                    line .. ", train = {dir = " ..
                    level.trains[x][y].direction .. ", speed = " ..
                    level.trains[x][y].speed .. ", trainType = \"" ..
                    level.trains[x][y].trainType .. "\"}"
            end

            if  level.switches[x][y] == 1 then
                line = line .. ", toggled = true"
            end

            if level.levers[x][y] == 1 then
                line = line .. ", hasLever = true"
            end

            line = line .. "}, "
        end

        line = line .. "}, \n"
    end
    print(line .. "}")
end

function IncrementTrainT()
    G_TrainType = G_TrainType + 1
    
    if G_TrainType > 4 then
        G_TrainType =  1
    end
end

function DecrementTrainT()
    G_TrainType = G_TrainType - 1
    
    if G_TrainType < 1 then
        G_TrainType =  4
    end
end

function love.keypressed(key, unicode)
    if key == "up" then
        IncrementMode()
    elseif key == "down" then
        DecrementMode()
    elseif key == "p" then
        Serialise(G_OutLevel)
    elseif key == "right" then
        if EditMode[G_Editing] == EditMode.Trains then
            IncrementTrainT()
        end
    elseif key == "left" then
        if EditMode[G_Editing] == EditMode.Trains then
            DecrementTrainT()
        end
    end

    LoveFrames.keypressed(key, unicode)
end

function love.keyreleased(key)


    LoveFrames.keyreleased(key)
end

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

G_IsChangingLevel = false
G_VictoryTime = 0

isInDialogue = true
local function loadLevel(name, reloading)
        if not reloading then
			reloading = false
        end


    	local levelDescription = require(name)
        local level = {}

		level.name = name
		if levelDescription.nextlevel then
			level.nextlevel = levelDescription.nextlevel
		else	
			level.nextlevel = "levels/mainmenu"
		end

		--Reset boxes
		Boxes.boxes = {}

        level.switches  = {}
        level.tiles     = {}
        level.trains    = {}
		level.levers    = {}

		if levelDescription.targets then
			level.targets   = levelDescription.targets
		else
			level.targets = {{}}
		end	

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
                        level.switches[x][y]:toggle(true)
                    end
                end
				if type(rail.hasLever) ~= "nil" then
					if rail.hasLever == true then
						local toggled = 1	
						if level.switches[x][y].engaged then
							toggled = 2
						end	
						table.insert(level.levers, Lever.createLever(level, 40, 0, rail.id, x, y, toggled))
					end		
				end		
            end
        end

        level.width     = levelDescription.width
        level.height    = levelDescription.height

		level.dialogueProgress = levelDescription.dialogueProgress
		level.dialogueTimer = levelDescription.dialogueTimer
		level.dialogue = levelDescription.dialogue

		if #level.dialogue == 0 then
			isInDialogue = false
		else
			isInDialogue = true
		end	

        return level
    end


function love.load(name)
	if not reloading then
		reloading = false
	end	

	bgm = love.audio.newSource("audio/Theme_music_1_industrial.wav", "stream")
	bgm:setLooping(true)
	bgm:setVolume(0.5)
	love.audio.play(bgm)
		
    G_screenCanvas = love.graphics.newCanvas(640,480)

	G_font = love.graphics.newFont("fonts/Cabin-Regular.ttf", 16)

    G_Level = loadLevel("levels/level1")

    Tiles.loadRailSprites()

    love.window.setMode(G_ScreenWidth, G_ScreenHeight, {vsync=-1, resizable=false})
    love.graphics.setBackgroundColor(19/255, 20/255, 68/255)

	-- Reset button
	resetButton = LoveFrames.Create("imagebutton")
	resetButton:SetImage(love.graphics.newImage("assets/UI/ui_resetbutton.png"))
	resetButton:SetPos(640-220,0)
	resetButton:SetText("")
	resetButton:SetWidth(220)
	resetButton:SetHeight(64)
	resetButton.OnClick = function(object, x, y)
		bgm = love.audio.newSource("audio/sfx_gameplay_ui_click_2.wav", "stream")
		love.audio.play(bgm)

		for key, val in pairs(G_Level.levers) do
			val.button:Remove()
			val = nil
		end
		for key, val in pairs(G_Level.switches) do
			val = nil
		end	
		for key, val in pairs(G_Level) do
			val = nil
        end	
		G_Level = loadLevel(G_Level.name, true)
	end	
			

end

-- love.update is given the timestep since the last update in seconds
-- love.timer.getFPS is also available
function love.update(dt)
    G_Framerate = 1/dt	

	if isInDialogue then
        G_Level.dialogueTimer = G_Level.dialogueTimer + dt
        if love.mouse.isDown(1)  and G_Level.dialogueTimer > 0.3 then
			sfx = love.audio.newSource("audio/sfx_gameplay_ui_click.wav", "stream")
			sfx:play()	
            G_Level.dialogueProgress = G_Level.dialogueProgress + 1
            G_Level.dialogueTimer = 0
            if G_Level.dialogueProgress > #G_Level.dialogue then
                isInDialogue = false
            end
        end
    end

	numOfTargets = #G_Level.targets
	if numOfTargets > 0 then
		hitTargets = 0	
		for key,val in pairs(G_Level.targets) do
			if val.delivered == true then
				hitTargets = hitTargets + 1
			end	
		end
		 
		if hitTargets == numOfTargets then
			if G_IsChangingLevel == false then
				G_IsChangingLevel = true
				G_VictoryTime = 0

				local sfx = love.audio.newSource("audio/sfx-steam-whistle.wav", "stream")
				love.audio.play(sfx)
			end		
			if G_IsChangingLevel == true and G_VictoryTime > 2 then
				G_Level = loadLevel(G_Level.nextlevel)
				G_IsChangingLevel = false
			end
			G_VictoryTime = G_VictoryTime + dt
		end	
	end	

	if isInDialogue == false then
		Boxes.updateBoxes(dt)
	end
    LoveFrames.update(dt)
end

function love.draw()
    love.graphics.setCanvas(G_screenCanvas)
    love.graphics.clear(0.651,0.529,0.408,1)

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

	if isInDialogue and #G_Level.dialogue > 0 then 
         love.graphics.draw(G_Level.dialogue[G_Level.dialogueProgress][1], 50+90, 50+302)
         love.graphics.printf(G_Level.dialogue[G_Level.dialogueProgress][3], G_font, 140+90, 75+302, 245)
         love.graphics.printf(G_Level.dialogue[G_Level.dialogueProgress][2], G_font, 94+90, 139+302, 100)
     end


    LoveFrames.draw()
end

function love.mousepressed(x, y, button)


    LoveFrames.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)


    LoveFrames.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
	if isInDialogue == false then	
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
	end

    LoveFrames.keypressed(key, unicode)
end

function love.keyreleased(key)


    LoveFrames.keyreleased(key)
end

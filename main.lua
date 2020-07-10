AnimLib = require("lib/animation")
bump = require("lib/bump/bump")
cron = require("lib/cron/cron")
MGL = require("lib/MGL/src/MGL")

G_Framerate = 0

G_ScreenWidth = 640
G_ScreenHeight = 480

function love.load()
	G_screenCanvas = love.graphics.newCanvas(640,480)

    love.window.setMode(G_ScreenWidth, G_ScreenHeight, {vsync=-1, resizable=true})
    love.graphics.setBackgroundColor(19/255, 20/255, 68/255)
end

-- love.update is given the timestep since the last update in seconds
-- love.timer.getFPS is also available
function love.update(dt)
    G_Framerate = 1/dt	
end

function love.draw()
	love.graphics.setCanvas(G_screenCanvas)
	love.graphics.clear(0,0,0,1)

	--SetCameraPosition(love, -Camera_x, -Camera_y)

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
end

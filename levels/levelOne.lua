local TileMath = require("tileMath")
local direction = TileMath.direction

local world = {}

world.rails = {{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 35, train = {dir = 5, speed = 1, trainType = "engine"}}, {id = 25}, {id = 245, hasLever = true}, {id = 25}, {id = 24}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 36, train = {dir = 6, speed = 1, trainType = "wagon"}}, {id = 0}, {id = 0}, {id = 14}, {id = 0}, {id = 14}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 36, train = {dir = 3, speed = 1, trainType = "wagonloaded"}}, {id = 0}, {id = 35}, {id = 25}, {id = 125}, {id = 24}, {id = 14}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 36, train = {dir = 3, speed = 1, trainType = "engine"}}, {id = 0}, {id = 36}, {id = 0}, {id = 0}, {id = 0}, {id = 13}, {id = 13}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 36}, {id = 0}, {id = 36}, {id = 0}, {id = 0}, {id = 0}, {id = 36}, {id = 36}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 46}, {id = 0}, {id = 46}, {id = 0}, {id = 0}, {id = 0}, {id = 36}, {id = 36}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 14}, {id = 0}, {id = 15}, {id = 25}, {id = 235}, {id = 26}, {id = 36}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 14}, {id = 0}, {id = 0}, {id = 36}, {id = 0}, {id = 36}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 15}, {id = 25}, {id = 256, hasLever = true}, {id = 25}, {id = 26}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
}
world.width = 16
world.height = 13

world.dialogueProgress = 1 
world.dialogueTimer = 0 
world.dialogue = {} --[[{{love.graphics.newImage("assets/UI/ui_textbox_01.png"), "Boss", "As my late father used to say, when he (like me) was the CEO of Crash Corp: \"There are no breaks on the train of progress!\""},
                {love.graphics.newImage("assets/UI/ui_textbox_02.png"), "You", "Isn't this a workplace safety violation? The advertisement was about long shifts."},
                {love.graphics.newImage("assets/UI/ui_textbox_01.png"), "Boss", "Don't you dare speak ill of my father's ideals. He was a very literal man. There will be no breaks."},
                {love.graphics.newImage("assets/UI/ui_textbox_02.png"), "You", "Who directs the tracks?"},
                {love.graphics.newImage("assets/UI/ui_textbox_01.png"), "Boss", "Phaw, I don't believe in middle managment. As my late father used to say: \"The cheapest traffic planning is divine intervention\""}}]]

--Where cargo should land, delivered becomes true when a box lands on it				
world.targets = {{x = 12, y = 10, delivered=false}}

world.nextlevel = "levels/mainmenu"

world.props = {{image = love.graphics.newImage("assets/PropExposedPipe.png"), x = 30, y = 70},
{image = love.graphics.newImage("assets/PropShroomGuy.png"), x = 130, y = 100},
{image = love.graphics.newImage("assets/PropLargeExposedPipe.png"), x = 500, y = 100},
{image = love.graphics.newImage("assets/landing.png"), x = 350, y = 230}}

return world

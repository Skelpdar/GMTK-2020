local TileMath = require("tileMath")
local direction = TileMath.direction

local world = {}

world.rails = {{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 25}, {id = 25}, {id = 25, train = {dir = 5, speed = 1, trainType = "wagonloaded"}}, {id = 25, train = {dir = 5, speed = 1, trainType = "engine"}}, {id = 24}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 15}, {id = 235, hasLever = true}, {id = 25}, {id = 245, hasLever = true}, {id = 25}, {id = 24}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 46}, {id = 0}, {id = 0}, {id = 13}, {id = 0}, {id = 14}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 35}, {id = 25, train = {dir = 5, speed = 1, trainType = "wagon"}}, {id = 25, train = {dir = 5, speed = 1, trainType = "engine"}}, {id = 235, hasLever = true}, {id = 125, hasLever = true}, {id = 25}, {id = 256, hasLever = true}, {id = 24}, {id = 0}, {id = 14}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 36}, {id = 0}, {id = 0}, {id = 36}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 134, hasLever = true}, {id = 0}, {id = 14}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 46}, {id = 0}, {id = 0}, {id = 36}, {id = 0}, {id = 0}, {id = 35}, {id = 25}, {id = 26}, {id = 14}, {id = 0}, {id = 14}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 14}, {id = 0}, {id = 36}, {id = 0}, {id = 0}, {id = 46}, {id = 0}, {id = 0}, {id = 0}, {id = 134, hasLever = true}, {id = 0}, {id = 13}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 14}, {id = 36}, {id = 0}, {id = 0}, {id = 0}, {id = 15}, {id = 25}, {id = 25}, {id = 26}, {id = 15}, {id = 26}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 1346}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 36, train = {speed = 1000000, trainType = "barrier"}}, {id = 14, train = {speed = 1000000, trainType = "barrier"}}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
}

world.width = 16
world.height = 13

world.targets = {{x=6, y=13, delivered=false}}

world.dialogue = {}

world.props = {
    {image = love.graphics.newImage("assets/landing.png"), x = 150, y = 310},
}

return world

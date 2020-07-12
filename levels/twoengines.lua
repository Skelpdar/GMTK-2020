local TileMath = require("tileMath")
local direction = TileMath.direction

local world = {}

world.rails = {{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 25, train = {dir = 5, speed = 1, trainType = "wagonloaded"}}, {id = 25, train = {dir = 5, speed = 1, trainType = "engine"}}, {id = 25}, {id = 24}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 15}, {id = 25}, {id = 235, hasLever = true}, {id = 25}, {id = 24}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 46}, {id = 0}, {id = 0}, {id = 134, hasLever = true}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 35}, {id = 25}, {id = 125, hasLever = true}, {id = 25}, {id = {246, 2}, hasLever = true}, {id = 15}, {id = 24}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 36}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 13}, {id = 0}, {id = 15}, {id = 24}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 36, train = {dir = 6, speed = 1, trainType = "engine"}}, {id = 0}, {id = 35}, {id = 25}, {id = 25}, {id = {246, 2}, hasLever = true}, {id = 0}, {id = 0}, {id = 0}, {id = 13}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 46}, {id = 0}, {id = 35}, {id = 25}, {id = 125, hasLever = true}, {id = 25}, {id = 25}, {id = 26}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 15}, {id = 26}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
{{id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, {id = 0}, },
}

world.width = 16
world.height = 13

world.targets = {{x=1, y=9, delivered=false}}

return world

local TileMath = require("tileMath")
local direction = TileMath.direction

local world = {}

world.rails = {{{id = 1346},    {id = 35},     {id = 25},     {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 25}},
               {{id = 46},		{id = {246, 2}},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 13},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 13},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 13, train = {dir = direction.DownLeft, speed = 1, trainType="wagon"}},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46, train = {dir = direction.DownRight, speed = 1}},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 13},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 35},		{id = 24},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 46},		{id = 0},		{id = 13},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 134, hasLever = true, toggled=true},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 13},		{id = 136},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46},		{id = 15},		{id = 25},		{id = 25},		{id = 0},		{id = 0},		{id = 136, toggled = false},		{id = 136},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 25},		{id = 15},		{id = 25},		{id = 25, train = {dir = direction.Right, speed = 1, trainType="wagonloaded"}},		{id = 25, train= {dir=direction.Right, speed=1, trainType="engine"}},		{id = 25},		{id = 26},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 26},		{id = 25}}}

world.width = 16
world.height = 13

world.targets = {}

world.dialogueProgress = 1 
world.dialogueTimer = 0 
world.dialogue = {}

return world

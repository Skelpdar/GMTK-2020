local TileMath = require("tileMath")
local direction = TileMath.direction

local world = {}

world.rails = {{{id = 1346},    {id = 35},     {id = 25},     {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 0},      {id = 25}},
               {{id = 46},		{id = {246, 2}},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 13},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 13},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 13},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46, train = {dir = direction.DownRight, speed = 1}},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 13},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 0},		{id = 13},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 46},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0},		{id = 0}},
               {{id = 25},		{id = 15},		{id = 25},		{id = 25, train = {dir = direction.Left, speed = 2}},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 25},		{id = 26},		{id = 25}}}

world.width = 16
world.height = 13

return world

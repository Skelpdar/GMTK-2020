local Cargo = {none = 0, blue = 1, purple = 2}

local Railwagon = {cargo = Cargo.none}

function Railwagon:new(object, cargoType)
    object = object or {}

    setmetatable(object, self)
    self.__index = self

    cargoType = cargoType or Cargo.none
    self.cargo = cargoType

    return object
end

local Train = {pos_x = 1, pos_y = 1, direction = 1, wagons = {}, speed = 1}

function Train:new(object, pos_x, pos_y, direction, wagons, speed)
    object = object or {}
    
    setmetatable(object, self)
    self.__index = self

    self.pos_x = pos_x or 1
    self.pos_y = pos_y or 1
    self.direction = direction or 1
    self.wagons = wagons or {}
    self.speed = speed or 1

    return object
end


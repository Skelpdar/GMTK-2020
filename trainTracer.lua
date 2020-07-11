local trainTracer = {}

trainTracer.sprites = {
    love.graphics.newImage("assets/trainLeft.png"),
    love.graphics.newImage("assets/trainUpLeft.png"),
    love.graphics.newImage("assets/trainUpRight.png"),
    love.graphics.newImage("assets/trainRight.png"),
}

trainTracer.currentSprite = 1

function trainTracer:nextSprite()
    self.currentSprite = self.currentSprite + 1
    if self.currentSprite == (table.getn(self.sprites) + 1) then
        self.currentSprite = 1
    end
end

function trainTracer:previousSprite()
    self.currentSprite = self.currentSprite - 1
    if self.currentSprite == 0 then
        self.currentSprite = table.getn(self.sprites)
    end
end

trainTracer.pos = {x = 1, y = 1}

function trainTracer:draw()
    love.graphics.draw(
        self.sprites[self.currentSprite], self.pos.x, self.pos.y)
end

function trainTracer:print()
    print("abs x: ", self.pos.x + 20, "mod x: ", (self.pos.x + 20) % 40)
    print("abs y: ", self.pos.y + 20, "mod y: ", (self.pos.y + 20) % 40)
end

trainTracer.stepSize = 1

return trainTracer
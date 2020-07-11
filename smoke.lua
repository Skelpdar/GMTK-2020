local M = {}

function M.newSmokestack(x,y)
	smokestack.smoke01 = newSmokeSystem(x, y, "assets/Particles/p_particle_01.png")
    smokestack.smoke02 = newSmokeSystem(x, y, "assets/Particles/p_particle_02.png")
    smokestack.smoke03 = newSmokeSystem(x, y, "assets/Particles/p_particle_03.png")
    smokestack.smoke04 = newSmokeSystem(x, y, "assets/Particles/p_particle_04.png")
    smokestack.smoke05 = newSmokeSystem(x, y, "assets/Particles/p_particle_05.png")
    smokestack.smoke06 = newSmokeSystem(x, y, "assets/Particles/p_particle_06.png")
    smokestack.smoke07 = newSmokeSystem(x, y, "assets/Particles/p_particle_07.png")
end		

function M.newSmokeSystem(x, y, path)
    smoke = {}

    smoke.pos_x = x 
    smoke.pos_y = y 

    --load sprites  
    local smokesprite = love.graphics.newImage(path)

    smoke.psystem = love.graphics.newParticleSystem(smokesprite, 1)

    smoke.psystem:setParticleLifetime(1, 3) -- Particles live at least 2s and at most 5s.
    smoke.psystem:setEmissionRate(2)
    smoke.psystem:setSizeVariation(1)
    smoke.psystem:setSpeed(10,15)
    smoke.psystem:setDirection(-3.14/2)
    smoke.psystem:setLinearAcceleration(0, 1, 0, 3) -- Random movement in all directions.
    smoke.psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

    smoke.psystem:moveTo(x,y)

    return smoke
end

function M.updateSmokeSystem(smoke,dt)
    if smoke.psystem:getCount() == 0 then
        smoke.psystem:start()
        smoke.psystem:setPosition(smoke.pos_x, smoke.pos_y)
    else
        smoke.psystem:pause()
    end
    smoke.psystem:update(dt)

end

function M.renderSmokestack(smokestack)
		for key, val in pairs(smokestack) do
				local x,y = val.psystem:getPosition()
				love.graphics.draw(val.psystem,x,y)
		end
end		

return M

local function createSwitch(entry, exits)
    local switch = {
        entry = entry, exits = exits, engaged = false,
        [entry] = exits[1]
    }

    function switch:toggle()
        self.engaged = self.engaged ~= true

        if(self.engaged) then
            self[entry] = exits[2]
        else
            self[entry] = exits[1]
        end
    end

    for position, exit in pairs(exits) do
        switch[exit] = entry
    end

    return switch
end

local M = {}
M.createSwitch = createSwitch

return M
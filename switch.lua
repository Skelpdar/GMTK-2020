local function createSwitch(entry, exits)
    local switch = {
        _entry = entry, _exits = exits, engaged = false,
        [entry] = exits[1]
    }

    if (table.getn(exits) == 2) then
        function switch:toggle()
            self.engaged = self.engaged ~= true

            if(self.engaged) then
                self[self._entry] = self._exits[2]
            else
                self[self._entry] = self._exits[1]
            end
        end
    else
        function switch:toggle()
        end
    end

    for position, exit in pairs(exits) do
        switch[exit] = entry
    end

    return switch
end

local function createCrossing(entries, exits)
    local switch = {
        _entries = entries, _exits = exits, enaged = false,
        [entries[1]] = exits[1], [entries[2]] = exits[2],
        [exits[1]] = entries[1], [exits[2]] = entries[2]
    }

    function switch:toggle()
    end

    return switch
end

local M = {}
M.createSwitch = createSwitch
M.createCrossing = createCrossing

return M
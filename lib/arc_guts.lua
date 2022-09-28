local Arc = {}
Arc.__index = Arc

function Arc.new()
    local a = {}
    a.arc = arc.connect()
    a.shift_mode = false
    setmetatable(a, Arc)
    a.arc.delta = function(n, d)
        a:delta(n, d)
    end
    return a
end

function Arc:key(n, z)
    if n == 1 then
        self.shift_mode = z == 1
    end
end

function Arc:get_param(i)
    return nil
end

function Arc:delta(n, d)
    if self:get_param(n) then
        self:get_param(n):delta(d * 0.01)
    end
end

function Arc:redraw()
    self.arc:all(0)
    for i = 1, 4 do
        local param = self:get_param(i)
        if param then
            local val = util.linlin(param.controlspec.minval, param.controlspec.maxval, 3, 61, param:get())
            self.arc:segment(i, 3, 61, 3)
            self.arc:segment(i, val - .1, val + .1, 15)
        end
    end
    self.arc:refresh()
end

return Arc

-- currently does nothing
Event = {
  n,
  q,
  c1,
  c2,
  -- effects of choosing 1
  pop1,
  pow1,
  mon1,
  -- effects of choosing 2
  pop2,
  pow2,
  mon2,
}

function Event:Create(event)
  local event = event or {}
  setmetatable(event, self)
  self.__index = self
  return event
end

function Event:Draw()
  lg.setFont(title)
  lg.printf(self.n, 0, 50, 800, "center")
  lg.setFont(normal)
  lg.printf(self.q, 0, 100, 800, "center")
  lg.printf("1. " .. self.c1 .. "\n2. " .. self.c2, 0, 528, 800, "center")
end

local function add(a, b)
  if a + b > 100 then
    return 100
  elseif a + b < 0 then
    return 0
  else
    return a + b
  end
end

function Event:Choose(choice)
  if gamestate == "normal" then
    if choice == 1 then
      pop = add(pop, self.pop1)
      pow = add(pow, self.pow1)
      mon = add(mon, self.mon1)
    elseif choice == 2 then
      pop = add(pop, self.pop2)
      pow = add(pow, self.pow2)
      mon = add(mon, self.mon2)
    end
    cur = cur + 1
  else
    if choice == 1 then
      setup()
    elseif choice == 2 then
      love.event.quit()
    end
  end
  -- check gamestate
  if cur > length then
    gamestate = "win"
    cur = 3
  end
  if pop == 100 or pow == 100 or mon == 100 then
    gamestate = "lost"
    cur = 2
  end
end

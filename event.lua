local class = require "middleclass"

Event = class('Event')

function Event:initialize(name, question, choice1, choice2, pop1, pow1, mon1, pop2, pow2, mon2)
  self.n = name
  self.q = question
  self.c1 = choice1
  self.c2 = choice2
  self.pop1 = pop1
  self.pow1 = pow1
  self.mon1 = mon1
  self.pop2 = pop2
  self.pow2 = pow2
  self.mon2 = mon2
end


function Event:draw()
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
    events[2].q = "\"...but, as he was ambitious, I slew him\"(3.2.42)."
  end
  if pop == 0 or pow == 0 or mon == 0 then
    gamestate = "start"
    cur = 2
    events[2].q = "Caesar fades to obsurity"
  end
end

return Event

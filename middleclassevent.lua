local class = require "middleclass"

local Event = class('Event')
function Event:Create(name, question, left, right)
  self.n = name
  self.q = question
  self.l = left
  self.r = right
end
function Event:Draw()
  -- love.graphics.printf(self.n, 0, 300, 800, "center")
  -- love.graphics.printf(self.q, 0, 400, 800, "center")
  -- love.graphics.printf(self.l, 10, 550, 790, "left")
  -- love.graphics.printf(self.r, 0, 550, 790, "right")
  print(self.n)
  print(self.q)
  print(self.l)
  print(self.r)
end
function asdf(x)
  print(x.n)
  print(x.q)
  print(x.l)
  print(x.r)
end

ss = Event:new("Soothsayer", "Beware the Ides of March.", "Yes", "No")
ss:Draw()
asdf(ss)

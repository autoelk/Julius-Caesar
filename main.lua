local class = require "middleclass"
require "event"

function love.load()
  lg = love.graphics
  lk = love.keyboard
  lm = love.math
  title = lg.newFont("assets/TrajanPro-Bold.otf", 50)
  normal = lg.newFont("assets/TrajanPro-Bold.otf", 24)
  img = {
    sky = lg.newImage("assets/sky.png"),
    court = lg.newImage("assets/court.png"),
    person = lg.newImage("assets/person.png"),
    gameover = lg.newImage("assets/gameover.png"),
    popularity = lg.newImage("assets/popularity.png"),
    power = lg.newImage("assets/power.png"),
    money = lg.newImage("assets/money.png"),
  }
  setup()
  gamestate = "start"
  cur = 1
  length = 3 + 6
  events = {}
  --  What is now amiss\nThat Caesar and his Senate must redress?
  table.insert(events, Event:Create{n = "Julius Caesar", q = "by Luke Tao", c1 = "Play", c2 = "Quit", pop1 = 0, pow1 = 0, mon1 = 0, pop2 = 0, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Game Over", q = "Then fall, Caesar!", c1 = "Retry", c2 = "Quit", pop1 = 0, pow1 = 0, mon1 = 0, pop2 = 0, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "You Win", q = "Caesar Reigns", c1 = "Replay", c2 = "Quit", pop1 = 0, pow1 = 0, mon1 = 0, pop2 = 0, pow2 = 0, mon2 = 0})

  table.insert(events, Event:Create{n = "Soothsayer", q = "Beware the ides of March.", c1 = "He speaks truth", c2 = "He is a dreamer", pop1 = -10, pow1 = 0, mon1 = 0, pop2 = 10, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Antony", q = "I present you a kingly crown (1)", c1 = "Accept", c2 = "Refuse", pop1 = 100, pow1 = 100, mon1 = 0, pop2 = 10, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Antony", q = "I present you a kingly crown (2)", c1 = "Accept", c2 = "Refuse", pop1 = 100, pow1 = 100, mon1 = 0, pop2 = 10, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Antony", q = "I present you a kingly crown (3)", c1 = "Accept", c2 = "Refuse", pop1 = 100, pow1 = 100, mon1 = 0, pop2 = 10, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Calpurnia", q = "You are not to set foot out of the house today", c1 = "Mark Antony shall say I am not well,", c2 = "And Caesar shall go forth.", pop1 = -25, pow1 = -25, mon1 = 0, pop2 = 100, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Decius", q = "And know it now, the Senate have concluded\nTo give this day a crown to mighty Caesar.", c1 = "How foolish do your fears seem now, Calpurnia!", c2 = "Decius, go tell them Caesar will not come.", pop1 = 0, pow1 = 100, mon1 = 0, pop2 = -25, pow2 = -25, mon2 = 0})
  table.insert(events, Event:Create{n = "Artemidorus", q = "Delay not, Caesar; read [this document] instantly.", c1 = "Accept", c2 = "What, is this man mad?", pop1 = -10, pow1 = -10, mon1 = -10, pop2 = 10, pow2 = 0, mon2 = 0})
end

function setup()
  gamestate = "normal"
  pop = 0 -- popularity
  pow = 0 -- power
  mon = 0 -- money
  cur = 4
end

function love.keypressed(key, scancode, isrepeat)
  -- exit game
  if key == "escape" or ((key == "lctrl" or key == "rctrl") and key == "w") then
    love.event.quit()
  end

  -- choices
  if key == "1" or key == "up" then
    events[cur]:Choose(1);
  end
  if key == "2" or key == "down" then
    events[cur]:Choose(2);
  end
end

function love.update(dt)
  -- body...
end

function love.draw()
  lg.setColor(1, 1, 1)
  -- draw background
  lg.draw(img.sky, 0, 0)
  lg.draw(img.court, 0, 0)
  -- draw meters
  lg.draw(img.popularity, 40, pop * 4.25 - 700)
  lg.draw(img.power, 280, pow * 4.25 - 700)
  lg.draw(img.money, 510, mon * 4.25 - 700)
  -- draw people
  if gamestate == "normal" then
    lg.draw(img.person, 0, 0)
  elseif gamestate == "lost" then
    lg.draw(img.gameover, 0, 0)
  end
  -- draw text
  lg.setColor(0, 0, 0)
  events[cur]:Draw()
end

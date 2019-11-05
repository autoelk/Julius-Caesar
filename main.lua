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
  length = 3 + 19
  events = {}
  -- Menu Events
  table.insert(events, Event:Create{n = "Julius Caesar", q = "by Luke Tao", c1 = "Play", c2 = "Quit", pop1 = 0, pow1 = 0, mon1 = 0, pop2 = 0, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Game Over", q = "\"...but, as he was ambitious, I slew him\"(3.2.42).", c1 = "Retry", c2 = "Quit", pop1 = 0, pow1 = 0, mon1 = 0, pop2 = 0, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "You Win", q = "Thanks for playing", c1 = "Replay", c2 = "Quit", pop1 = 0, pow1 = 0, mon1 = 0, pop2 = 0, pow2 = 0, mon2 = 0})
  -- Rise of Caesar
  table.insert(events, Event:Create{n = "Pompey & Crassus", q = "Would you like to join the First Triumvirate", c1 = "Yes", c2 = "No", pop1 = 0, pow1 = 10, mon1 = -10, pop2 = 0, pow2 = -10, mon2 = 10})
  table.insert(events, Event:Create{n = "", q = "Redistribute land to the poor?", c1 = "Yes", c2 = "No", pop1 = 10, pow1 = 0, mon1 = 10, pop2 = -10, pow2 = 0, mon2 = -10})
  table.insert(events, Event:Create{n = "", q = "Invade Gaul?", c1 = "Yes", c2 = "No", pop1 = 10, pow1 = 10, mon1 = 10, pop2 = -10, pow2 = -10, mon2 = -10})
  table.insert(events, Event:Create{n = "", q = "Pillage?", c1 = "Yes", c2 = "No", pop1 = -10, pow1 = 0, mon1 = 10, pop2 = 10, pow2 = 0, mon2 = -10})
  table.insert(events, Event:Create{n = "Pompey", q = "Disband your army and return to Rome", c1 = "Obey", c2 = "cross the Rubicon", pop1 = -10, pow1 = -50, mon1 = 0, pop2 = 10, pow2 = 10, mon2 = 0})
  table.insert(events, Event:Create{n = "", q = "Pursue Pompey to Egypt", c1 = "Yes", c2 = "No", pop1 = 10, pow1 = 10, mon1 = -10, pop2 = -10, pow2 = -10, mon2 = 10})
  table.insert(events, Event:Create{n = "", q = "Become Dictator Perpetuus", c1 = "Yes", c2 = "No", pop1 = 10, pow1 = 10, mon1 = 10, pop2 = -10, pow2 = -10, mon2 = -10})
  table.insert(events, Event:Create{n = "", q = "Name Quintilis after yourself", c1 = "Add July to the Calendar", c2 = "No", pop1 = -10, pow1 = 0, mon1 = 0, pop2 = -10, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "", q = "Reform the tax system", c1 = "Yes", c2 = "No", pop1 = 10, pow1 = 0, mon1 = -10, pop2 = -10, pow2 = 0, mon2 = 10})
  -- Fall of Caesar
  table.insert(events, Event:Create{n = "Soothsayer", q = "\"Beware the ides of March\"(1.2.3).", c1 = "He speaks truth", c2 = "\"He is a dreamer;\"(1.2.4).", pop1 = -10, pow1 = 0, mon1 = 0, pop2 = 10, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Antony", q = "I present you a kingly crown (1)", c1 = "Accept", c2 = "Refuse", pop1 = 100, pow1 = 100, mon1 = 100, pop2 = -10, pow2 = -10, mon2 = -5})
  table.insert(events, Event:Create{n = "Antony", q = "I present you a kingly crown (2)", c1 = "Accept", c2 = "Refuse", pop1 = 100, pow1 = 100, mon1 = 100, pop2 = -10, pow2 = -10, mon2 = -5})
  table.insert(events, Event:Create{n = "Antony", q = "I present you a kingly crown (3)", c1 = "Accept", c2 = "Refuse", pop1 = 100, pow1 = 100, mon1 = 100, pop2 = -10, pow2 = -10, mon2 = -5})
  table.insert(events, Event:Create{n = "Calpurnia", q = "\"You shall not stir out of your house today\"(2.2.26)", c1 = "\"Mark Antony shall say I am not well\"(2.2.27).", c2 = "\"Yet Caesar shall go forth\"(2.2.26).", pop1 = -10, pow1 = -10, mon1 = 0, pop2 = 10, pow2 = 10, mon2 = 0})
  table.insert(events, Event:Create{n = "Decius", q = "\"And know it now, the Senate have concluded\nTo give this day a crown to mighty Caesar\"(2.2.28).", c1 = "\"How foolish do your fears seem now...\"(2.2.28).", c2 = "\"Decius, go tell them Caesar will not come\"(2.2.27).", pop1 = 10, pow1 = 10, mon1 = 0, pop2 = -10, pow2 = -10, mon2 = 0})
  table.insert(events, Event:Create{n = "", q = "Default on debts", c1 = "Yes", c2 = "No", pop1 = -10, pow1 = 0, mon1 = 50, pop2 = 10, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Artemidorus", q = "\"Delay not, Caesar; read [this document] instantly\"(3.1.33).", c1 = "Accept", c2 = "\"What, is the fellow mad?\"(3.1.33).", pop1 = -10, pow1 = -10, mon1 = -10, pop2 = 10, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Caesar", q = "\"What is now amiss\nThat Caesar and his Senate must redress?\"(3.1.34).", c1 = "Continue", c2 = "Continue", pop1 = 0, pow1 = 0, mon1 = 0, pop2 = 0, pow2 = 0, mon2 = 0})
  table.insert(events, Event:Create{n = "Metellus Cimber", q = "\"For the repealing of my banish'd brother?\"(3.1.34).", c1 = "\"Caesar allows his repeal\"(3.1.34).", c2 = "I must prevent thee, Cimber", pop1 = -10, pow1 = -10, mon1 = 0, pop2 = 10, pow2 = 10, mon2 = 0})
end

function setup()
  gamestate = "normal"
  pop = 25 -- popularity
  pow = 25 -- power
  mon = 25 -- money
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
    -- lg.draw(img.person, 0, 0)
  elseif gamestate == "lost" then
    lg.draw(img.gameover, 0, 0)
  end
  -- draw text
  lg.setColor(0, 0, 0)
  events[cur]:Draw()
end

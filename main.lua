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
  events = {}
  -- Menu Events
  table.insert(events, Event:new("Julius Caesar", "by Luke Tao", "Play", "Quit", 0, 0, 0, 0, 0, 0))
  table.insert(events, Event:new("Game Over", "", "Retry", "Quit", 0, 0, 0, 0, 0, 0))
  table.insert(events, Event:new("You Win", "Thanks for playing", "Replay", "Quit", 0, 0, 0, 0, 0, 0))
  -- Rise of Caesar
  table.insert(events, Event:new( "Pompey & Crassus", "We can make you consul if you promise to pass all of our laws", "Accept", "Refuse", 0, 10, - 10, 0, - 10, 10))
  table.insert(events, Event:new( "", "Redistribute land to the poor?", "Yes", "No", 10, 0, 10, - 10, 0, - 10))
  table.insert(events, Event:new( "", "Invade Gaul?", "Yes", "No", 10, 10, 10, - 10, - 10, - 10))
  table.insert(events, Event:new( "", "Pillage?", "Yes", "No", - 10, 0, 10, 10, 0, - 10))
  table.insert(events, Event:new( "Pompey", "Disband your army and return to Rome", "Obey", "cross the Rubicon", - 10, - 50, 0, 10, 10, 0))
  table.insert(events, Event:new( "", "Pursue Pompey to Egypt", "Yes", "No", 10, 10, - 10, - 10, - 10, 10))
  table.insert(events, Event:new( "", "Pardon everyone?", "Yes", "No", 10, 10, 0, - 10, - 10, 0))
  table.insert(events, Event:new( "", "Become Dictator Perpetuus", "Yes", "No", 10, 10, 10, - 10, - 10, - 10))
  table.insert(events, Event:new( "", "Name Quintilis after yourself", "Add July to the Calendar", "No", - 10, 0, 0, - 10, 0, 0))
  table.insert(events, Event:new( "", "Reform the tax system", "Yes", "No", 10, 0, - 10, - 10, 0, 10))
  -- Fall of Caesar
  table.insert(events, Event:new( "Soothsayer", "\"Beware the ides of March\"(1.2.3).", "He speaks truth", "\"He is a dreamer;\"(1.2.4).", - 10, 0, 0, 10, 0, 0))
  table.insert(events, Event:new( "Antony", "I present you a kingly crown (1)", "Accept", "Refuse", 100, 100, 100, - 10, - 10, - 5))
  table.insert(events, Event:new( "Antony", "I present you a kingly crown (2)", "Accept", "Refuse", 100, 100, 100, - 10, - 10, - 5))
  table.insert(events, Event:new( "Antony", "I present you a kingly crown (3)", "Accept", "Refuse", 100, 100, 100, - 10, - 10, - 5))
  table.insert(events, Event:new( "Calpurnia", "\"You shall not stir out of your house today\"(2.2.26)", "\"Mark Antony shall say I am not well\"(2.2.27).", "\"Yet Caesar shall go forth\"(2.2.26).", - 10, - 10, 0, 10, 10, 0))
  table.insert(events, Event:new( "Decius", "\"And know it now, the Senate have concluded\nTo give this day a crown to mighty Caesar\"(2.2.28).", "\"How foolish do your fears seem now...\"(2.2.28).", "\"Decius, go tell them Caesar will not come\"(2.2.27).", 10, 10, 0, - 10, - 10, 0))
  table.insert(events, Event:new( "", "Default on debts", "Yes", "No", - 10, 0, 50, 10, 0, 0))
  table.insert(events, Event:new( "Artemidorus", "\"Delay not, Caesar; read [this document] instantly\"(3.1.33).", "Accept", "\"What, is the fellow mad?\"(3.1.33).", - 10, - 10, - 10, 10, 0, 0))
  table.insert(events, Event:new( "Caesar", "\"What is now amiss\nThat Caesar and his Senate must redress?\"(3.1.34).", "Continue", "Continue", 0, 0, 0, 0, 0, 0))
  table.insert(events, Event:new( "Metellus Cimber", "\"For the repealing of my banish'd brother?\"(3.1.34).", "\"Caesar allows his repeal\"(3.1.34).", "I must prevent thee, Cimber", - 10, - 10, 0, 10, 10, 0))
  length = table.getn(events)
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
  events[cur]:draw()
end

Vector = require "librairies/vector"
MathUtils = require "librairies/vector"

Raycast = require "raycast"
Level = require "level"
Player = require "player"
Minimap = require "minimap"


function love.load()

  -- Theeme
  doomE1m1 = love.audio.newSource("resources/audio/doom.wav", "stream")
  doomE1m1:setLooping(true)
  doomE1m1:setVolume(0.5)
  doomE1m1:play()

  love.mouse.setRelativeMode(true)
  love.mouse.setPosition(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
  love.mouse.setGrabbed(true)

  Level:init()
  Player:init(15, 0)
  Raycast:init(60,800)

  Minimap:init(20, 20, 175, 100)

  mode = "3D"
  displayCasting = true

end



function love.update(dt)
  Player:update(dt)
  Raycast:update(dt)
end




function love.keypressed(key, scancode, isrepeat)

   -- Touche "Quitter"
   if key == "escape" then
     love.event.quit(0)
   elseif key == "m" then
     if mode == "3D" then
       mode = "2D"
     elseif mode == "2D" then
       mode = "3D"
     end
   elseif key == "c" then
     if displayCasting then
       displayCasting = false
     else
       displayCasting = true
     end
   end

end


function love.draw()

  if mode == "2D" then
    Level:draw()
    if displayCasting then Raycast:draw2D() end
    Player:draw2D()
  elseif mode == "3D" then
    Raycast:draw3D()
    Minimap:draw()
  end

end

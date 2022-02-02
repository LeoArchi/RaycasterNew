Raycast = require "raycast"
Level = require "level"
Player = require "player"

function love.load()

  love.mouse.setRelativeMode(true)
  love.mouse.setPosition(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
  love.mouse.setGrabbed(true)

  Player:init(love.graphics.getWidth()/2+25, love.graphics.getHeight()/2+25, 15, 0)
  Raycast:init(60,100)
  Level:init()

end



function love.update(dt)
  Player:update(dt)
  Raycast:update(dt)
end




function love.keypressed(key, scancode, isrepeat)

   -- Touche "Quitter"
   if key == "escape" then
     love.event.quit(0)
   end

end


function love.draw()

  Level:draw()
  Raycast:draw()
  Player:draw()

end

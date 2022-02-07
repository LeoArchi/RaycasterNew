local HUD = {

  x,
  y,
  width,
  height,

  init = function(self)

    self.x = 0
    self.y = love.graphics.getHeight() - 100
    self.width = love.graphics.getWidth()
    self.height = 100


  end,

  update = function(self, dt)
    heartAnimation.currentTime = heartAnimation.currentTime + dt
    if heartAnimation.currentTime >= heartAnimation.duration then
        heartAnimation.currentTime = heartAnimation.currentTime - heartAnimation.duration
    end
  end,


  draw = function(self)

    Minimap:draw()

    love.graphics.setColor(0.15, 0.15, 0.15, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    love.graphics.setLineWidth(3)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)

    local spriteNum = math.floor(heartAnimation.currentTime / heartAnimation.duration * #heartAnimation.quads) + 1
    love.graphics.draw(heartAnimation.spriteSheet, heartAnimation.quads[spriteNum], 17, love.graphics.getHeight() - 87, 0, 0.3, 0.3)

    love.graphics.line(love.graphics.getWidth()/2 - 10, love.graphics.getHeight()/2, love.graphics.getWidth()/2 + 10, love.graphics.getHeight()/2)
    love.graphics.line(love.graphics.getWidth()/2, love.graphics.getHeight()/2 - 10, love.graphics.getWidth()/2, love.graphics.getHeight()/2 + 10)
    love.graphics.circle('line', love.graphics.getWidth()/2, love.graphics.getHeight()/2, 15, 32)
  end

}


return HUD
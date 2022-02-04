local function myStencilFunction()
   love.graphics.rectangle("fill", 20, 20, 175, 100)
end


local Minimap = {

  x,
  y,
  width,
  height,
  scale,

  init = function(self, x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.scale = 0.4
    self.center = {}
    self.center.x = self.width/2 + self.x
    self.center.y = self.height/2 + self.y
  end,

  draw = function(self)

    love.graphics.setLineWidth(3)

    -- draw a rectangle as a stencil. Each pixel touched by the rectangle will have its stencil value set to 1. The rest will be 0.
    love.graphics.stencil(myStencilFunction, "replace", 1)

    -- Only allow rendering on pixels which have a stencil value greater than 0.
    love.graphics.setStencilTest("greater", 0)

    love.graphics.push()

    -- Commenter ces lignes pour passer la carte en plein écran
    love.graphics.translate(self.center.x - Player.x1*self.scale, self.center.y - Player.y1*self.scale)
    love.graphics.scale(self.scale, self.scale)

    Level:draw()
    --Raycast:draw2D()
    Player:draw2D()

    love.graphics.pop()

    -- Commenter ces lignes pour passer la carte en plein écran
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)

    love.graphics.setStencilTest()

  end


}

return Minimap

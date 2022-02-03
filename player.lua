local Player = {

  r,
  a,
  x1,
  y1,
  x2,
  y2,

  init = function(self, x1, y1, r, a)
    self.x1 = x1
    self.y1 = y1
    self.r = r
    self.a = a
    self.x2 = self.x1 + self.r
    self.y2 = self.y1
  end,

  update = function(self, dt)
    if self.a > 2 * math.pi then
      self.a = self.a - 2 * math.pi
    elseif self.a < 0 then
      self.a = self.a + 2 * math.pi
    end

    self.x2 = self.x1 + math.cos(self.a) * self.r
    self.y2 = self.y1 - math.sin(self.a) * self.r

  end,

  draw2D = function(self)
    love.graphics.setColor(252/255, 186/255, 3/255, 1)
    love.graphics.rectangle("fill", self.x1-5, self.y1-5, 10, 10)
    love.graphics.line(self.x1, self.y1, self.x2, self.y2)
  end

}

function love.mousemoved( x, y, dx, dy, istouch )

  if dx < 0 then
    Player.a = Player.a + math.abs(dx) * 0.02
  else
    Player.a = Player.a - math.abs(dx) * 0.02
  end

end

return Player

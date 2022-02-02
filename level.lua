local Level = {

  top={},
  walls={},
  floor={},

  init = function(self)

    self.walls = {
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1},
      {1,0,0,0,1,1,0,0,0,1,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }


  end,


  draw = function(self)

    for i, row in ipairs(self.walls) do
      for j, column in ipairs(row) do

        if self.walls[i][j] == 0 then
          love.graphics.setColor(0.1, 0.1, 0.1, 1)
          love.graphics.rectangle('fill', 50*(j-1), 50*(i-1), 50, 50)
          love.graphics.setColor(0.3, 0.3, 0.3, 1)
          love.graphics.rectangle('line', 50*(j-1), 50*(i-1), 50, 50)
        elseif self.walls[i][j] == 1 then
          love.graphics.setColor(0.9, 0.9, 0.9, 1)
          love.graphics.rectangle('fill', 50*(j-1), 50*(i-1), 50, 50)
          love.graphics.setColor(0.3, 0.3, 0.3, 1)
          love.graphics.rectangle('line', 50*(j-1), 50*(i-1), 50, 50)
        end
      end
    end

  end

}

return Level

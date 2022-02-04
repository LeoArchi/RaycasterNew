local Level = {

  width,
  height,

  squareSize,

  top={},
  walls={},
  floor={},

  init = function(self)

    self.width = 16
    self.height = 12
    self.squareSize = 50

    self.walls = {
      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
      1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,
      1,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,
      1,0,0,1,1,1,1,0,0,1,0,0,0,0,0,1,
      1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,
      1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,
      1,0,0,0,0,0,2,0,0,0,0,0,1,0,0,1,
      1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,
      1,0,0,1,1,1,0,0,0,0,1,1,1,0,0,1,
      1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,
      1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,
      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    }


  end,


  draw = function(self)

    for y=1, self.height do
      for x=1, self.width do

        local _square  = self.walls[(y-1)*self.width+x]
        local _squareX = (x-1) * self.squareSize
        local _squareY = (y-1) * self.squareSize

        if _square == 0 then
          love.graphics.setColor(255/255, 228/255, 163/255, 1)
        elseif _square == 1 then
          love.graphics.setColor(0.8, 0.4, 0.4, 1) -- Rouge "Vertical"
        elseif _square == 2 then
          love.graphics.setColor(0.4, 0.4, 0.8, 1) -- Bleu "Vertical"
        end

        love.graphics.rectangle('fill', _squareX, _squareY, self.squareSize, self.squareSize)
        love.graphics.setColor(0.3, 0.3, 0.3, 1)
        love.graphics.rectangle('line', _squareX, _squareY, self.squareSize, self.squareSize)


      end
    end

  end

}

return Level

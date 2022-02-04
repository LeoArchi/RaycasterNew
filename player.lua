local Player = {

  r,
  a,
  x1,
  y1,
  x2,
  y2,
  speed,
  vectors,

  init = function(self, x1, y1, r, a)
    self.x1 = x1
    self.y1 = y1
    self.r = r
    self.a = a
    self.x2 = self.x1 + self.r
    self.y2 = self.y1
    self.speed = 100
    self.vectors = {}
  end,

  update = function(self, dt)

    -- Recorrection de l'angle entre 0 et 2 PI radians

    if self.a > 2 * math.pi then
      self.a = self.a - 2 * math.pi
    elseif self.a < 0 then
      self.a = self.a + 2 * math.pi
    end

    -- Calcul des vecteurs de déplacement
    -- Calcul "vecteur" Avant
    vector_front = {}
    vector_front.x = math.cos(self.a) * self.speed
    vector_front.y = math.sin(self.a) * self.speed
    self.vectors['z'] = vector_front

    -- Calcul "vecteur" Arrière
    vector_back = {}
    vector_back.x = math.cos(self.a+math.pi) * self.speed
    vector_back.y = math.sin(self.a+math.pi) * self.speed
    self.vectors['s'] = vector_back

    -- Calcul "vecteur" Gauche
    vector_left = {}
    vector_left.x = math.cos(self.a+math.pi/2) * self.speed
    vector_left.y = math.sin(self.a+math.pi/2) * self.speed
    self.vectors['q'] = vector_left

    -- Calcul "vecteur" Droite
    vector_right = {}
    vector_right.x = math.cos(self.a+3*math.pi/2) * self.speed
    vector_right.y = math.sin(self.a+3*math.pi/2) * self.speed
    self.vectors['d'] = vector_right

    local newX = self.x1
    local newY = self.y1

    -- Déplacement du joueur
    if love.keyboard.isDown("z") then
      newX = self.x1 + self.vectors['z'].x*dt
      newY = self.y1 - self.vectors['z'].y*dt
    end
    if love.keyboard.isDown("s") then
      newX = self.x1 + self.vectors['s'].x*dt
      newY = self.y1 - self.vectors['s'].y*dt
    end
    if love.keyboard.isDown("q") then
      newX = self.x1 + self.vectors['q'].x*dt
      newY = self.y1 - self.vectors['q'].y*dt
    end
    if love.keyboard.isDown("d") then
      newX = self.x1 + self.vectors['d'].x*dt
      newY = self.y1 - self.vectors['d'].y*dt
    end

    self.x1 = newX
    self.y1 = newY

    -- Calcul de la position du témoin d'orientation
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

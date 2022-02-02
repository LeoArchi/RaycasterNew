local Raycast = {

  fov, -- en degrés
  res,
  rays = {},

  dots = {},


  init = function(self, fov, res)
    self.fov = fov
    self.res = res

  end,

  update = function(self ,dt)

    self.dots = {}
    self.rays = {}

    -- Calcul de l'angle du joueur en degrés
    local _playerAngleDegrees = Player.a * 180 / math.pi

    for i=(_playerAngleDegrees - self.fov/2), (_playerAngleDegrees + self.fov/2), (self.fov/(self.res-1)) do

      -- Reconversion de l'angle du joueur en radians
      local _rayAngleRad = i * math.pi / 180

      -- Ajustement de l'angle en radians entre 0 et 2*PI
      if _rayAngleRad > 2 * math.pi then
        _rayAngleRad = _rayAngleRad - 2 * math.pi
      elseif _rayAngleRad < 0 then
        _rayAngleRad = _rayAngleRad + 2 * math.pi
      end

      -- Déclaration du rayon, le point de départ est égal à la position du joueur
      ray = {}
      ray.x1 = Player.x1
      ray.y1 = Player.y1

      -- Initialisation du nombre maximum de cases que pourra parcourir le rayon (la taille du niveau)
      local _nbMaxCases = 0

      -- VERIFICATION DES LIGNES HORIZONTALES

      -- Regarde en haut
      if _rayAngleRad > 0 and  _rayAngleRad < math.pi then

        ray.y2 = math.floor(Player.y1/Level.squareSize) * Level.squareSize -- calcul de la composante y de la première intersection avec une ligne horizontale en arrondissant au plus proche 50ème vers 0
        ray.x2 = (ray.y1 - ray.y2) / math.tan(_rayAngleRad) + ray.x1 -- calcul de la composante x avec la trigo

        offsetX = ray.x2 - ray.x1
        offsetY = Level.squareSize * (-1)

        -- Test calcul de la prochaine intersection
        ray.y2 = ray.y2 + offsetY*2
        ray.x2 = ray.x2 + offsetX*2

      end

      -- Regarde en bas
      if _rayAngleRad > math.pi and _rayAngleRad < math.pi*2 then

        ray.y2 = math.ceil(Player.y1/Level.squareSize) * Level.squareSize -- calcul de la composante y de la première intersection avec une ligne horizontale en arrondissant au plus proche 50ème vers 0
        ray.x2 = (ray.y1 - ray.y2) / math.tan(_rayAngleRad) + ray.x1 -- calcul de la composante x avec la trigo

        offsetX = ray.x2 - ray.x1
        offsetY = Level.squareSize

        -- Test calcul de la prochaine intersection
        ray.y2 = ray.y2 + offsetY*2
        ray.x2 = ray.x2 + offsetX*2

      end

      -- Regarde pile à gauche ou pile à droite
      if _rayAngleRad == 0 or _rayAngleRad == math.pi or _rayAngleRad == math.pi*2 then
        _nbMaxCases = 16
        ray.x2 = ray.x1
        ray.y2 = ray.y1
      end

      -- On ajoute les points pour le rendu
      local _dot = {}
      _dot.x = ray.x2
      _dot.y = ray.y2

      table.insert(self.dots,_dot)


      while _nbMaxCases < 16 do

        -- Todo récupérer la case du tableau

        --local _case = Level.walls[1][1]

        _nbMaxCases = _nbMaxCases+1
      end

      table.insert(self.rays,ray)
    end


  end,

  draw = function(self)
    love.graphics.setColor(5/255, 242/255, 171/255, 0.5)

    for i,ray in ipairs(self.rays) do
      love.graphics.line(ray.x1, ray.y1, ray.x2, ray.y2)
    end

    for i,dot in ipairs(self.dots) do
      love.graphics.circle('fill', dot.x, dot.y, 3, 32)
      love.graphics.circle('line', dot.x, dot.y, 6, 32)
    end

  end

}

return Raycast

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

        local _deltaY =             Player.y1 % 50
        local _deltaX = _deltaY / math.tan(_rayAngleRad)

        --Fonctionnel pour trouver la première ligne horizontale
        nextX = Player.x1 + _deltaX
        nextY = Player.y1 - _deltaY

        --Test pour trouver la seconde ligne horizontale
        --nextX = Player.x1 + _deltaX + _deltaX
        --nextY = Player.y1 - _deltaY - 50 -- On retire la taille d'une case

      end

      -- Regarde en bas
      if _rayAngleRad > math.pi and _rayAngleRad < math.pi*2 then

        local _deltaY

        if Player.y1 % 50 > 0 then
          _deltaY = 50 - Player.y1 % 50
        else
          _deltaY = Player.y1
        end

        local _deltaX = _deltaY / math.tan(_rayAngleRad)

        --Fonctionnel pour trouver la première ligne horizontale
        nextX = Player.x1 - _deltaX
        nextY = Player.y1 + _deltaY

        --Test pour trouver la seconde ligne horizontale
        --nextX = Player.x1 - _deltaX - _deltaX
        --nextY = Player.y1 + _deltaY + 50 -- On ajoute la taille d'une case

      end

      -- Regarde pile à gauche ou pile à droite
      if _rayAngleRad == 0 or _rayAngleRad == math.pi or _rayAngleRad == math.pi*2 then
        _nbMaxCases = 16
      end

      -- On ajoute les points pour le rendu
      local _dot = {}
      _dot.x = nextX
      _dot.y = nextY

      table.insert(self.dots,_dot)


      while _nbMaxCases < 16 do

        -- Todo récupérer la case du tableau

        local _case = Level.walls[1][1]

        _nbMaxCases = _nbMaxCases+1
      end

      ray.x2 = Player.x1 + math.cos(_rayAngleRad) * 1000
      ray.y2 = Player.y1 - math.sin(_rayAngleRad) * 1000


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

local function checkHorizontalLines(ray, dots)

  -- Initialisation des offsets
  local offsetY
  local offsetX

  -- Initialisation du nombre maximum de cases que pourra parcourir le rayon (la taille du niveau)
  local nbCases = 0

  -- Regarde en haut
  if ray.angle > 0 and  ray.angle < math.pi then
    ray.y2 = math.floor(Player.y1/Level.squareSize) * Level.squareSize -- calcul de la composante y de la première intersection avec une ligne horizontale en arrondissant au plus proche 50ème vers 0
    ray.x2 = (ray.y1 - ray.y2) / math.tan(ray.angle) + ray.x1 -- calcul de la composante x avec la trigo
    offsetY = Level.squareSize * (-1)
    offsetX = offsetY * (-1) / math.tan(ray.angle+math.pi)
  end

  -- Regarde en bas
  if ray.angle > math.pi and ray.angle < math.pi*2 then
    ray.y2 = math.ceil(Player.y1/Level.squareSize) * Level.squareSize -- calcul de la composante y de la première intersection avec une ligne horizontale en arrondissant au plus proche 50ème vers 0
    ray.x2 = (ray.y1 - ray.y2) / math.tan(ray.angle) + ray.x1 -- calcul de la composante x avec la trigo
    offsetY = Level.squareSize
    offsetX = offsetY * (-1) / math.tan(ray.angle+math.pi)
  end

  -- Regarde pile à gauche ou pile à droite
  if ray.angle == 0 or ray.angle == math.pi or ray.angle == math.pi*2 then
    nbCases = 16
    ray.x2 = ray.x1
    ray.y2 = ray.y1
  end

  while nbCases < 16 do

    -- Récupération de la case du tableau
    local mapX = math.floor(ray.x2 / Level.squareSize) +1
    local mapY = (ray.y2/Level.squareSize)
    if offsetY > 0 then
      mapY = mapY + 1
    end

    local mapSquare = Level.walls[(mapY-1)*Level.width+mapX]

    -- On ajoute les points pour le rendu
    local dot = {}
    dot.x = ray.x2
    dot.y = ray.y2
    table.insert(dots,dot)

    if mapSquare == 0 then
      -- Calcul de la prochaine intersection, à faire seulement si le contenu de la case est 0
      ray.y2 = ray.y2 + offsetY
      ray.x2 = ray.x2 + offsetX
      nbCases = nbCases+1
    else
      nbCases = 16
    end

  end

  local result = {}
  result.dist = math.sqrt(math.pow(ray.x2 - ray.x1, 2)+math.pow(ray.y2 - ray.y1, 2))
  result.x = ray.x2
  result.y = ray.y2

  return result

end

local function checkVerticalLines(ray, dots)
  -- Initialisation des offsets
  local offsetY
  local offsetX

  -- Initialisation du nombre maximum de cases que pourra parcourir le rayon (la taille du niveau)
  local nbCases = 0

  -- Regarde à gauche
  if ray.angle > math.pi/2 and  ray.angle < 3*math.pi/2 then

    ray.x2 = math.floor(Player.x1/Level.squareSize) * Level.squareSize
    ray.y2 = ray.y1 - (ray.x2 - ray.x1) * math.tan(ray.angle)
    offsetX = Level.squareSize * (-1)
    offsetY = offsetX * math.tan(ray.angle)

    --ray.y2 = math.floor(Player.y1/Level.squareSize) * Level.squareSize -- calcul de la composante y de la première intersection avec une ligne horizontale en arrondissant au plus proche 50ème vers 0
    --ray.x2 = (ray.y1 - ray.y2) / math.tan(ray.angle) + ray.x1 -- calcul de la composante x avec la trigo
    --offsetY = Level.squareSize * (-1)
    --offsetX = offsetY * (-1) / math.tan(ray.angle+math.pi)
  end

  -- Regarde à droite
  if (ray.angle > 3*math.pi/2 and ray.angle <= math.pi*2) or (ray.angle >= 0 and ray.angle < math.pi/2) then

    ray.x2 = math.ceil(Player.x1/Level.squareSize) * Level.squareSize
    ray.y2 = ray.y1 - (ray.x2 - ray.x1) * math.tan(ray.angle)
    offsetX = Level.squareSize
    offsetY = offsetX * math.tan(ray.angle)

    --ray.y2 = math.ceil(Player.y1/Level.squareSize) * Level.squareSize -- calcul de la composante y de la première intersection avec une ligne horizontale en arrondissant au plus proche 50ème vers 0
    --ray.x2 = (ray.y1 - ray.y2) / math.tan(ray.angle) + ray.x1 -- calcul de la composante x avec la trigo
    --offsetY = Level.squareSize
    --offsetX = offsetY * (-1) / math.tan(ray.angle+math.pi)
  end

  -- Regarde pile en haut ou pile en bas
  if ray.angle == math.pi/2 or ray.angle == 3*math.pi/2 then

    nbCases = 16
    ray.x2 = ray.x1
    ray.y2 = ray.y1
  end


  while nbCases < 16 do

    -- Récupération de la case du tableau
    local mapY = math.floor(ray.y2 / Level.squareSize) +1 --(ray.y2/Level.squareSize)

    local mapX = (ray.x2/Level.squareSize) --math.floor(ray.x2 / Level.squareSize) +1

    if offsetX > 0 then
      mapX = mapX + 1
    end

    local mapSquare = Level.walls[(mapY-1)*Level.width+mapX]


    -- On ajoute les points pour le rendu
    local dot = {}
    dot.x = ray.x2
    dot.y = ray.y2
    dot.square = {}
    dot.square.x = mapX
    dot.square.y = mapY
    table.insert(dots,dot)

    if mapSquare == 0 then
      -- Calcul de la prochaine intersection, à faire seulement si le contenu de la case est 0
      ray.x2 = ray.x2 + offsetX
      ray.y2 = ray.y2 - offsetY
      nbCases = nbCases+1
    else
      nbCases = 16
    end

  end

  local result = {}
  result.dist = math.sqrt(math.pow(ray.x2 - ray.x1, 2)+math.pow(ray.y2 - ray.y1, 2))
  result.x = ray.x2
  result.y = ray.y2

  return result
end


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
      if _rayAngleRad >= 2 * math.pi then
        _rayAngleRad = _rayAngleRad - 2 * math.pi
      elseif _rayAngleRad < 0 then
        _rayAngleRad = _rayAngleRad + 2 * math.pi
      end

      -- Déclaration du rayon, le point de départ est égal à la position du joueur
      ray = {}
      ray.x1 = Player.x1
      ray.y1 = Player.y1
      ray.angle = _rayAngleRad

      local resultH = checkHorizontalLines(ray, self.dots)
      local resultV = checkVerticalLines(ray, self.dots)

      if resultH.dist < resultV.dist then
        ray.x2 = resultH.x
        ray.y2 = resultH.y
        ray.dist = resultH.dist
        ray.isVertical = false
      else
        ray.x2 = resultV.x
        ray.y2 = resultV.y
        ray.dist = resultV.dist
        ray.isVertical = true
      end

      table.insert(self.rays,ray)
    end


  end,

  draw2D = function(self)
    love.graphics.setColor(5/255, 242/255, 171/255, 0.5)

    for i,ray in ipairs(self.rays) do
      love.graphics.line(ray.x1, ray.y1, ray.x2, ray.y2)
    end

    for i,dot in ipairs(self.dots) do
      --love.graphics.print("x:".. dot.square.x .. " y:" .. dot.square.y, dot.x + 5, dot.y - 20)
      --love.graphics.circle('fill', dot.x, dot.y, 3, 32)
      --love.graphics.circle('line', dot.x, dot.y, 6, 32)
    end

    love.graphics.setColor(1, 0, 0, 1)

  end,

  draw3D = function(self)

    for i,ray in ipairs(self.rays) do

      local distCorr = math.cos(ray.angle - Player.a) * ray.dist
      local lineHeight = Level.squareSize * 300 / distCorr

      if ray.isVertical then
        love.graphics.setColor(0.8, 0.3, 0.3, 1)
      else
        love.graphics.setColor(0.8, 0.2, 0.2, 1)
      end

      love.graphics.rectangle('fill', love.graphics.getWidth()-(i*love.graphics.getWidth()/self.res), love.graphics.getHeight()/2-lineHeight/2, love.graphics.getWidth()/self.res, lineHeight)

    end

  end

}

return Raycast

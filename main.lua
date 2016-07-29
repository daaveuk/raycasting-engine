debug = true

player = {}
player.x = 32;
player.y = 32;
player.h = 16;
player.direction = 0;
player.fov = 60;
player.size = 8;
player.speed = {
  x = 4.2;
  y = 80;
}
player.rect = function()
  love.graphics.setColor(0, 0, 255, 255)
  love.graphics.circle('fill', player.x, player.y, player.size, player.size)
end
player.move = function(dt)
    inputs = ''
   if love.keyboard.isDown('w') then
      inputs = inputs .. "w"
      player.x = player.x + math.cos(player.direction) * player.speed.y * dt
      player.y = player.y + math.sin(player.direction) * player.speed.y * dt
   end
   if love.keyboard.isDown('a') then
      player.direction = player.direction - player.speed.x*dt
      inputs = player.direction
   end
   if love.keyboard.isDown('s') then
      inputs = inputs .. "s"
      player.x = player.x - math.cos(player.direction) * player.speed.y * dt
      player.y = player.y - math.sin(player.direction) * player.speed.y * dt
   end
   if love.keyboard.isDown('d') then
     player.direction = player.direction + player.speed.x*dt
     inputs = player.direction
   end
    text = inputs
end

function renderView()
  viewLeft = player.direction - (player.fov / 2)
  viewRight = player.direction + (player.fov / 2)
  count = 0;
  while count < 800 do
    count = count + 1
    love.graphics.print(count, 300, 300)
  end
end

render = {}
render.sq = 64;


map={
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,3,0,0,0,3,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,5,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
};

function renderMap(map)
	y = 0;
	for yPlane, row in pairs(map) do
    x = 0;
    for xPlane, block in pairs(row) do
      if block > 0 then
        if block == 1 then
          love.graphics.setColor(255, 255, 255, 255)
        elseif block == 2 then
          love.graphics.setColor(255, 0, 255, 255)
        elseif block == 3 then
          love.graphics.setColor(5, 200, 25, 255)
        else
          love.graphics.setColor(255, 255, 0, 255)
        end
        love.graphics.rectangle( 'line', x, y, 16, 16 )
      end
      x = xPlane * 16;
    end
    y = yPlane * 16;
	end
end


function love.load(arg)
end

function love.draw(dt)
  renderMap(map)
  renderView()
  player.rect()
  love.graphics.print(text, 60, 60)
end

function love.update(dt)
  player.move(dt)
end

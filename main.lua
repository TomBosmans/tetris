local Grid = require('grid')

function love.draw()
   grid:draw()
end

function love.load()
   grid = Grid.create { columns=18, rows=10, blockSize=20 }

   love.graphics.setColor(.87, .87, .87)
   love.graphics.setBackgroundColor(255, 255, 255)
end

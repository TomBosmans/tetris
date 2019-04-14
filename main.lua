BLOCK_TYPES = { 'i', 'j', 'l', 'o', 's', 't', 'z' }
BLOCK_COLORS = require('block_colors')
BLOCK_SHAPES = require('block_shapes')

local Grid = require('grid')

function love.draw()
   grid:draw()
   grid.currentBlock:draw()
end

function love.load()
   love.graphics.setBackgroundColor(255, 255, 255)

   timer = 0
   grid = Grid.create { columns=10, rows=18, cellSize=20, }
end

function love.update(dt)
   grid.currentBlock:drop(dt)
   grid:removeCompleteRows()
end

function love.keypressed(key)
   if key == 'w' then
      grid.currentBlock:rotateRight()
   elseif key == 'q' then
      grid.currentBlock:rotateLeft()
   elseif key == 'a' then
      grid.currentBlock:moveLeft()
   elseif key == 'd' then
      grid.currentBlock:moveRight()
   elseif key == 's' then
      grid.currentBlock:moveDown()
   end
end

BLOCK_COLORS = require('block_colors')
BLOCK_SHAPES = require('block_shapes')

local Grid = require('grid')
local Block = require('block')

function love.draw()
   grid:draw()
   block:draw()
end

function love.load()
   love.graphics.setBackgroundColor(255, 255, 255)

   grid = Grid.create {
      columns=18,
      rows=10,
      cellSize=20,
   }

   block = Block.create {
      type='z',
      rotation=1,
      grid=grid
   }
end

BLOCK_TYPES = { 'i', 'j', 'l', 'o', 's', 't', 'z' }
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

   timer = 0

   grid = Grid.create {
      columns=10,
      rows=18,
      cellSize=20,
   }

   block = Block.create {
      rotation=1,
      offsetX=3,
      offsetY=0,
      grid=grid
   }
end

function love.update(dt)
   timer = timer + dt
   local timerLimit = 0.5
   if timer >= timerLimit then
      timer = timer - timerLimit
      if not block:moveDown() then
	 block:rest()
	 block = Block.create {
	    rotation=1,
	    offsetX=3,
	    offsetY=0,
	    grid=grid
	 }
      end
   end

   grid:removeCompleteRows()
end

function love.keypressed(key)
   if key == 'w' then
      block:rotateRight()
   elseif key == 'q' then
      block:rotateLeft()
   elseif key == 'a' then
      block:moveLeft()
   elseif key == 'd' then
      block:moveRight()
   elseif key == 's' then
      block:moveDown()
   end
end

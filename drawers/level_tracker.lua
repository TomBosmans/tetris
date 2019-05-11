function drawLevelTracker(grid, currentLevel)
   local cellSize = grid.cellSize
   local offsetX = grid.offsetX
   local offsetY = grid.offsetY

   local width = 4 * cellSize
   local height = 3 * cellSize

   local x = (offsetX * cellSize) - width - 3
   local y = (offsetY * cellSize)

   -- box
   love.graphics.setColor(1, 1, 1)
   love.graphics.rectangle('line', x, y, width, height)

   -- content
   local font = love.graphics.newFont(30)
   love.graphics.setFont(font)
   love.graphics.printf('LEVEL', x, y  + cellSize/2, width, 'center')
   love.graphics.printf(currentLevel, x, y  + (1.5 * cellSize), width, 'center')
end

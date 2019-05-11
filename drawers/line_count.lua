function drawLineCount(grid, totalLines)
   local cellSize = grid.cellSize
   local offsetX = grid.offsetX
   local offsetY = grid.offsetY

   local x = (offsetX * cellSize) + (grid.columns * cellSize) + 3
   local y = (offsetY * cellSize) + (3 * cellSize)

   local width = 4 * cellSize
   local height = 3 * cellSize

   -- box
   love.graphics.setColor(1, 1, 1)
   love.graphics.rectangle('line', x, y, width, height)

   -- content
   local font = love.graphics.newFont(30)
   love.graphics.setFont(font)
   love.graphics.printf('LINE', x, y + cellSize/2, width, 'center')
   love.graphics.printf(totalLines, x, y + (1.5 * cellSize), width, 'center')
end

function drawScoreCount(grid, totalScore)
   local cellSize = grid.cellSize
   local offsetX = grid.offsetX
   local offsetY = grid.offsetY

   local x = (offsetX * cellSize)
   local y = (offsetY * cellSize) - (3 * cellSize) - 3

   local width = grid.columns * cellSize
   local height = 3 * cellSize

   -- box
   love.graphics.setColor(1, 1, 1)
   love.graphics.rectangle('line', x, y, width, height)

   -- content
   local font = love.graphics.newFont(30)
   love.graphics.setFont(font)
   love.graphics.printf('SCORE', x, y  + cellSize/2, width, 'center')
   love.graphics.printf(totalScore, x, y  + (1.5 * cellSize), width, 'center')
end

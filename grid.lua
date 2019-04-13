local Grid = {}
Grid.__index = Grid

function Grid:create(...)
   local grid = {}
   setmetatable(grid,Grid)

   grid.columns = self.columns
   grid.rows = self.rows
   grid.blockSize = self.blockSize

   return grid
end

function Grid:draw()
   for rowIndex = 1, self.rows do
      for columnIndex = 1, self.columns do
	 self:drawCell(rowIndex, columnIndex)
      end
   end
end

function Grid:drawCell(rowIndex, columnIndex)
   x = (rowIndex - 1) * self.blockSize
   y = (columnIndex -1) * self.blockSize

   width = self.blockSize - 1
   height = width

   love.graphics.rectangle('fill', x, y, width, height)
end

return Grid

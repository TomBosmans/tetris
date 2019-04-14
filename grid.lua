local Grid = {}
Grid.__index = Grid

function Grid:create(...)
   local grid = {}
   setmetatable(grid,Grid)

   grid.columns = self.columns
   grid.rows = self.rows
   grid.cellSize = self.cellSize
   grid.inert = grid:createInert()

   return grid
end

function Grid:draw()
   for rowIndex = 1, self.rows do
      for columnIndex = 1, self.columns do
	 cell = self.inert[rowIndex][columnIndex]
	 self:drawCell(cell, columnIndex, rowIndex)
      end
   end
end

function Grid:drawCell(cell, columnIndex, rowIndex)
   x = (columnIndex -1) * self.cellSize
   y = (rowIndex - 1) * self.cellSize

   width = self.cellSize - 1
   height = width

   love.graphics.setColor(BLOCK_COLORS[cell])
   love.graphics.rectangle('fill', x, y, width, height)
end

function Grid:createInert()
   local inert = {}

   for rowIndex = 1, self.rows do
      inert[rowIndex] = {}
      for columnIndex = 1, self.columns do
	 inert[rowIndex][columnIndex] = ' '
      end
   end

   return inert
end

return Grid

local Grid = {}
Grid.__index = Grid

function Grid:create(...)
   setmetatable(self,Grid)
   return self
end

function Grid:draw()
   for rowIndex = 1, self.rows do
      self:drawRow(rowIndex)
   end
end

function Grid:drawRow(rowIndex)
   for columnIndex = 1, self.columns do
      self:drawCell(rowIndex, columnIndex)
   end
end

function Grid:drawCell(rowIndex, columnIndex)
   x = (rowIndex - 1) * self.blockSize
   y = (columnIndex -1) * self.blockSize

   width = self.blockSize - 1
   height = self.blockSize - 1

   love.graphics.rectangle('fill', x, y, width, height)
end

return Grid

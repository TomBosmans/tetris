local Inert = require('inert')
local Block = require('block')

local Grid = {}
Grid.__index = Grid

function Grid:create(...)
   local grid = {}
   setmetatable(grid, Grid)

   grid.columns = self.columns
   grid.rows = self.rows
   grid.cellSize = self.cellSize

   grid.currentBlock = Block.create { grid=grid }
   grid.nextBlock = Block.create { grid=grid }

   grid.inert = Inert.create {
      columns=grid.columns,
      rows = grid.rows
   }

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

function Grid:removeCompleteRows()
   for rowIndex = 1, self.rows do
      local complete = true
      for columnIndex = 1, self.columns do
	 if self.inert[rowIndex][columnIndex] == ' ' then
	    complete = false
	 end
      end

      if complete then
	 for removeRowIndex = rowIndex, 2, -1 do
	    for removeColumnIndex = 1, self.columns do
	       self.inert[removeRowIndex][removeColumnIndex] = self.inert[removeRowIndex - 1][removeColumnIndex]
	    end
	 end
	 
	 for removeColumnIndex = 1, self.columns do
	    self.inert[1][removeColumnIndex] = ' '
	 end
      end
   end
end

function Grid:next()
   self.currentBlock = self.nextBlock
   self.nextBlock = Block.create { grid=self }
end

return Grid

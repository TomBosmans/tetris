require('drawers.cell')

local Inert = require('inert')
local Block = require('block')

local Grid = {}
Grid.__index = Grid

function Grid:create(...)
   local grid = {}
   setmetatable(grid, Grid)

   grid.columns = 10
   grid.rows = 18
   grid.cellSize = 30

   grid.offsetX = self.offsetX/grid.cellSize - grid.columns/2
   grid.offsetY = self.offsetY/grid.cellSize - grid.rows/2

   grid.currentBlock = Block.create { grid=grid }
   grid.nextBlock = Block.create { grid=grid }
   grid.inert = Inert.create {columns=grid.columns, rows=grid.rows}

   return grid
end

function Grid:draw()
   love.graphics.setColor(1, 1, 1)
   love.graphics.rectangle('line', self.offsetX * self.cellSize, self.offsetY * self.cellSize, self.columns * self.cellSize, self.rows * self.cellSize)

   for rowIndex = 1, self.rows do
      for columnIndex = 1, self.columns do
	 local cell = self.inert[rowIndex][columnIndex]
	 self:drawCell(cell, columnIndex, rowIndex)
      end
   end
end

function Grid:drawCell(cell, columnIndex, rowIndex)
   local x = (columnIndex + self.offsetX -1) * self.cellSize
   local y = (rowIndex + self.offsetY - 1) * self.cellSize

   local size = self.cellSize - 1
   local color = BLOCK_COLORS[cell]
   drawCell(x, y, size, color)
end

function Grid:removeCompleteRows()
   local total = 0

   for rowIndex = 1, self.rows do
      local complete = true

      for columnIndex = 1, self.columns do
	 if self.inert[rowIndex][columnIndex] == ' ' then
	    complete = false
	 end
      end

      if complete then
	 total = total + 1

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

   return total
end

function Grid:next()
   self.currentBlock = self.nextBlock
   self.nextBlock = Block.create { grid=self }

   if not self.nextBlock:canMove() then
      love.load()
   end
end

return Grid

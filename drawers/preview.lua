require('drawers.cell')

function drawPreview(grid)
   local block = grid.nextBlock

   local cellSize = grid.cellSize
   local offsetX = grid.offsetX
   local offsetY = grid.offsetY
   local columns = grid.columns
   local rows = grid.rows

   local offset_per_type = {
      ['i'] = { ['x'] = 0,          ['y'] = 0 },
      ['j'] = { ['x'] = cellSize/2, ['y'] = cellSize/2 },
      ['l'] = { ['x'] = cellSize/2, ['y'] = cellSize/2 },
      ['o'] = { ['x'] = 0,          ['y'] = cellSize/2 },
      ['s'] = { ['x'] = cellSize/2, ['y'] = cellSize/2 },
      ['t'] = { ['x'] = cellSize/2, ['y'] = cellSize/2 },
      ['z'] = { ['x'] = cellSize/2, ['y'] = cellSize/2 }
   }

   local width = (cellSize * columns)/2
   local height = (cellSize * rows)

   local x = (offsetX * cellSize) + (grid.columns * cellSize) + 3
   local y = (offsetY * cellSize)

   local shape = BLOCK_SHAPES[block.type][1]
   local size = cellSize - 1
   local color = BLOCK_COLORS[block.type]

   love.graphics.setColor(1, 1, 1)
   love.graphics.rectangle('line', x, y, 4 * cellSize, 3 * cellSize)

   for rowIndex = 1, 4 do
      for columnIndex = 1, 4 do
	 local cell = shape[rowIndex][columnIndex]
	 if cell ~= ' ' then
	    local otherX = ((columnIndex - 1) * cellSize) + x + offset_per_type[block.type]['x']
	    local otherY = ((rowIndex -1) * cellSize) + y - offset_per_type[block.type]['y']

	    drawCell(otherX, otherY, size, color)
	 end
      end
   end
end

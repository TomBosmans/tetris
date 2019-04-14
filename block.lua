local Block = {}
Block.__index = Block

function Block:create(...)
   local block = {}
   setmetatable(block, Block)

   block.type = self.type
   block.rotation = self.rotation
   block.grid = self.grid

   return block
end

function Block:draw()
   local shape = BLOCK_SHAPES[self.type][self.rotation]

   for rowIndex = 1, 4 do
      for columnIndex = 1, 4 do
 
	 local cell = shape[columnIndex][rowIndex]
	 self.grid:drawCell(cell, rowIndex, columnIndex)
      end
   end
end

return Block

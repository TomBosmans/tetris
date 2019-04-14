local Block = {}
Block.__index = Block

function Block:create(...)
   local block = {}
   setmetatable(block, Block)

   block.type = BLOCK_TYPES[love.math.random(7)]
   block.rotation = self.rotation
   block.grid = self.grid
   block.offsetX = self.offsetX
   block.offsetY = self.offsetY

   return block
end

function Block:draw()
   local shape = BLOCK_SHAPES[self.type][self.rotation]

   for rowIndex = 1, 4 do
      for columnIndex = 1, 4 do 
	 local cell = shape[rowIndex][columnIndex]
	 local x = columnIndex + self.offsetX
	 local y = rowIndex + self.offsetY

	 if cell ~= ' ' then
	    self.grid:drawCell(cell, x, y)
	 end
      end
   end
end

function Block:rotateRight()
   local rotation = self.rotation + 1

   if rotation > #BLOCK_SHAPES[self.type] then
      rotation = 1
   end

   if self:canMove { rotation=rotation } then
      self.rotation = rotation
   end
end

function Block:rotateLeft()
   local rotation = self.rotation - 1

   if rotation < 1 then
      rotation = #BLOCK_SHAPES[self.type]
   end

   if self:canMove { rotation=rotation } then
      self.rotation = rotation
   end
end

function Block:moveLeft()
   local offsetX = self.offsetX - 1

   if self:canMove { offsetX=offsetX } then
      self.offsetX = offsetX
   end
end

function Block:moveRight()
   local offsetX = self.offsetX + 1

   if self:canMove { offsetX=offsetX } then
      self.offsetX = offsetX
   end
end

function Block:moveDown()
   local offsetY = self.offsetY + 1

   if self:canMove { offsetY=offsetY } then
      self.offsetY = offsetY
      return true
   end

   return false
end

function Block:canMove(args)
   local offsetX = args.offsetX or self.offsetX
   local offsetY = args.offsetY or self.offsetY
   local rotation = args.rotation or self.rotation

   local shape = BLOCK_SHAPES[self.type][rotation]

   for rowIndex = 1, 4 do
      for columnIndex = 1, 4 do
   	 local testBlockX = offsetX + rowIndex
   	 local testBlockY = offsetY + columnIndex

   	 if shape[columnIndex][rowIndex] ~= ' ' and (
   	    testBlockX < 1 -- left border
   	       or testBlockX > self.grid.columns -- right border
   	       or testBlockY > self.grid.rows -- bottom border
   	       or self.grid.inert[testBlockY][testBlockX] ~= ' ' -- already filled
   	 ) then
   	    return false
   	 end
      end
   end
   
   return true
end

function Block:rest()
   local shape = BLOCK_SHAPES[self.type][self.rotation]

   for rowIndex = 1, 4 do
      for columnIndex = 1, 4 do
	 local cell = shape[rowIndex][columnIndex]
	 if cell ~= ' ' then
	    self.grid.inert[self.offsetY + rowIndex][self.offsetX + columnIndex] = cell
	 end
      end
   end
end

return Block

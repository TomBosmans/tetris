local Grid = require('grid')

local Playfield = {}
Playfield.__index = Playfield

function Playfield:create(...)
   local playfield = {}
   setmetatable(playfield, Playfield)

   playfield.timerLimit = self.timerLimit
   playfield.keyBindings = self.keyBindings

   playfield.grid = Grid.create { offsetX=self.offsetX, offsetY=self.offsetY }
   playfield.timer = 0
   playfield.score = 0
   playfield.level = self.level or 0
   playfield.lines = 0
   playfield:setTimerLimit()

   return playfield
end

function Playfield:draw()
   self.grid:draw()
   self.grid.currentBlock:draw()
   self:drawPreview()
end

function Playfield:update(dt)
   self.timer = self.timer + dt

   if self.timer >= self.timerLimit then
      self.timer = self.timer - self.timerLimit
      self.grid.currentBlock:moveDown()
      local total = self.grid:removeCompleteRows()
      if total > 0 then
	 self.lines = self.lines + total
	 self:increaseScore(total)
	 newLevel = math.floor(self.lines/10)
	 if newLevel > self.level then
	    self.level = newLevel
	 end
	 self:setTimerLimit()
      end
   end
end

function Playfield:increaseScore(lines)
   self.score = self.score + SCORES_PER_LINES[lines] * (self.level + 1)
end

function Playfield:setTimerLimit()
   if self.level < table.getn(SPEED_PER_LEVEL) then
      self.timerLimit = SPEED_PER_LEVEL[self.level + 1]/60
   else
      self.timerLimit = SPEED_PER_LEVEL[#SPEED_PER_LEVEL]/60
   end
end

function Playfield:keypressed(key)
   if key == self.keyBindings.rotateRight then
      self.grid.currentBlock:rotateRight()
   elseif key == self.keyBindings.rotateLeft then
      self.grid.currentBlock:rotateLeft()
   elseif key == self.keyBindings.moveLeft then
      self.grid.currentBlock:moveLeft()
   elseif key == self.keyBindings.moveRight then
      self.grid.currentBlock:moveRight()
   elseif key == self.keyBindings.moveDown then
      self.grid.currentBlock:moveDown()
   end
end

function Playfield:drawPreview()
   local grid = self.grid
   local block = grid.nextBlock

   local cellSize = grid.cellSize
   local offsetX = grid.offsetX
   local offsetY = grid.offsetY
   local columns = grid.columns
   local rows = grid.rows

   local width = (cellSize * columns)/2
   local height = (cellSize * rows)

   local x = (offsetX * cellSize) + (2 * width)
   local y = offsetY * cellSize

   love.graphics.setColor({.75, .75, .75})
   love.graphics.rectangle('fill', x, y, width, height)

   love.graphics.setColor({255, 255, 255})
   love.graphics.print('Next', x, y)

   love.graphics.print("lines: " .. self.lines, x, y + 4 * cellSize)
   love.graphics.print("level: " .. self.level, x, y + 5 * cellSize)
   love.graphics.print("score: " .. self.score, x, y + 6 * cellSize)

   local shape = BLOCK_SHAPES[block.type][1]

   for rowIndex = 1, 4 do
      for columnIndex = 1, 4 do
	 local cell = shape[rowIndex][columnIndex]
	 if cell ~= ' ' then
	    local size = cellSize - 1

	    otherX = ((columnIndex - 1) * cellSize) + x + cellSize
	    otherY = ((rowIndex -1) * cellSize) + y

	    love.graphics.setColor(BLOCK_COLORS[cell])
	    love.graphics.rectangle('fill', otherX, otherY, size, size)
	 end
      end
   end
end


return Playfield

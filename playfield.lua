require('drawers.preview')
require('drawers.line_count')
require('drawers.score_count')
require('drawers.level_tracker')

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
   drawLineCount(self.grid, self.lines)
   drawPreview(self.grid)
   drawScoreCount(self.grid, self.score)
   drawLevelTracker(self.grid, self.level)
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

return Playfield

local Grid = require('grid')

local Playfield = {}
Playfield.__index = Playfield

function Playfield:create(...)
   local playfield = {}
   setmetatable(playfield, Playfield)

   playfield.timer = self.timer
   playfield.timerLimit = self.timerLimit
   playfield.keyBindings = self.keyBindings

   playfield.grid = Grid.create { offsetX=self.offsetX, offsetY=self.offsetY }

   return playfield
end

function Playfield:draw()
   self.grid:draw()
   self.grid.currentBlock:draw()
end

function Playfield:update(dt)
   self.timer = self.timer + dt

   if self.timer >= self.timerLimit then
      self.timer = self.timer - self.timerLimit
      self.grid.currentBlock:moveDown()
      self.grid:removeCompleteRows()
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

BLOCK_TYPES = { 'i', 'j', 'l', 'o', 's', 't', 'z' }
BLOCK_COLORS = require('block_colors')
BLOCK_SHAPES = require('block_shapes')
SCORES_PER_LINES = { 40, 100, 300, 1200 }
SPEED_PER_LEVEL = {
   48, 43, 38, 33, 28, 23, 18, 13, 8, 6,
   5, 5, 5, 4, 4, 4, 3, 3, 3,
   2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
   1
}

local Playfield = require('playfield')

function love.draw()
   love.graphics.setBackgroundColor(.04, .04, .04)
   playfield:draw()
end

function love.load()
   love.window.setFullscreen(true, "desktop")
   local width, height = love.graphics.getDimensions()

   keyBindings= {
      rotateRight='w',
      rotateLeft='q',
      moveLeft='a',
      moveRight='d',
      moveDown='s'
   }

   playfield = Playfield.create {
      level=5,
      keyBindings=keyBindings,
      offsetX=width/2,
      offsetY=height/2
   }
end

function love.update(dt)
   playfield:update(dt)
end

function love.keypressed(key)
   playfield:keypressed(key)
end

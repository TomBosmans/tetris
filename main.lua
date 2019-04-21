-- https://simplegametutorials.github.io/blocks/

BLOCK_TYPES = { 'i', 'j', 'l', 'o', 's', 't', 'z' }
BLOCK_COLORS = require('block_colors')
BLOCK_SHAPES = require('block_shapes')

local Playfield = require('playfield')

function love.draw()
   playfield:draw()
end

function love.load()
   love.graphics.setBackgroundColor(255, 255, 255)

   keyBindings= {
      rotateRight='w',
      rotateLeft='q',
      moveLeft='a',
      moveRight='d',
      moveDown='s'
   }

   playfield = Playfield.create {
      timer=0,
      timerLimit=0.5,
      keyBindings=keyBindings,
      offsetX=2,
      offsetY=5
   }
end

function love.update(dt)
   playfield:update(dt)
end

function love.keypressed(key)
   playfield:keypressed(key)
end

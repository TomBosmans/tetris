function drawCell(x, y, size, color)
   love.graphics.setColor(color[1] * .60, color[2] * .60, color[3] * .60)
   love.graphics.rectangle('fill', x, y, size, size)

   love.graphics.setColor(color[1] * .255, color[2] * .255, color[3] * .255)
   love.graphics.rectangle('fill', x + 2, y + 2, size - 4, size - 4)

   love.graphics.setColor(color[1] * .160, color[2] * .160, color[3] * .160)
   love.graphics.rectangle('fill', x + 6, y + 6, size - 12, size - 12)
end



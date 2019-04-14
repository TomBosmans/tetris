local Inert = {}
Inert.__index = Inert

function Inert:create(...)
   local inert = {}
   setmetatable(inert, Inert)

   for rowIndex = 1, self.rows do
      inert[rowIndex] = {}
      for columnIndex = 1, self.columns do
	 inert[rowIndex][columnIndex] = ' '
      end
   end

   return inert
end

return Inert

--[[
-- This mod simply allows the time in the game to pause when you
-- look through the crafting with a controller. Mouse action is 
-- not affected
--]]

--local require = GLOBAL.require
--require "mainfunctions"


-- I learned how to modify functions from 
-- RPG HUD' CTabs function
local function MyCraftTabs(self)
  local oldOpenControllerCrafting = self.OpenControllerCrafting
  local oldCloseControllerCrafting = self.CloseControllerCrafting

  function self:OpenControllerCrafting()
    oldOpenControllerCrafting(self)
    GLOBAL.SetPause(true, "Controller Crafting")
  end

  function self:CloseControllerCrafting()
    oldCloseControllerCrafting(self)
    GLOBAL.SetPause(false)
  end
end

AddClassPostConstruct("widgets/crafttabs", MyCraftTabs)

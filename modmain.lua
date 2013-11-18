--[[
-- This mod simply allows the time in the game to pause when you
-- look through the crafting with a controller. Mouse action is 
-- not affected
--]]

--local require = GLOBAL.require

local function MyControllerCrafting(self)
  local oldClose                   = self.Close
  local oldOpenRecipeTab           = self.OpenRecipeTab

  function self:Close(fn)
    oldClose(self, fn)
    GLOBAL.SetPause(false)
  end

  -- You can't simply call pause in Open
  -- because when you scroll down, it actually calls Crafting.Close
  -- Which will unpause the game.
  -- So you do it in OpenRecipeTab, that way, it will pause the game 
  -- again RIGHT after it is unpaused
  function self:OpenRecipeTab(idx)
    local tab = oldOpenRecipeTab(self, idx)
    GLOBAL.SetPause(true)
    return tab
  end
end

AddClassPostConstruct("widgets/controllercrafting", MyControllerCrafting)





local function MyCrafting(self, num_slots)
  local oldOpen = self.Open
  local oldClose = self.Close

  local oldScrollUp = self.ScrollUp
  local oldScrollDown = self.ScrollDown

  function self:Open(fn)
    oldOpen(self, fn)
    GLOBAL.SetPause(true, "Menu Crafting")
  end
  function self:Close(fn)
    oldClose(self, fn)
    GLOBAL.SetPause(false)
  end

  -- For some reason, the code checks if the state of the game is paused during these.
  -- Instead of changing the core of the functions (probably be broken by updates)
  -- We do this instead
  function self:ScrollUp()
    GLOBAL.SetPause(false)
    oldScrollUp(self)
    GLOBAL.SetPause(true)
  end
  function self:ScrollDown()
    GLOBAL.SetPause(false)
    oldScrollDown(self)
    GLOBAL.SetPause(true)
  end
end

AddClassPostConstruct("widgets/crafting", MyCrafting)

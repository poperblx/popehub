local funcName = "left_click"
local func
for i,v in pairs(getgc()) do
    if type(v) == 'function' and getinfo(v).name and getinfo(v).name == funcName then
        func = v
        break;
    end
end

func(5);

local funcName = "left_click"
local func
for i,v in pairs(getgc()) do
    if type(v) == 'function' and getinfo(v).name then
        print(i,v)
    end
end

-- local response = func()
-- if type(response) == 'table' then
--     for i,v in pairs(response) do
--         print(i,v)
--     end
-- else
--     print(response)
-- end

for i,v in pairs(workspace.Worlds.Raids:FindFirstChild("1"):GetDescendants()) do
    if v.Name == "ChristmasChest" and v.Parent then
        print(v.Parent.Parent.Position)
    end
end
-- func(workspace.Worlds.Raids:FindFirstChild("1").Zone7.Chests.ChristmasChest);
--send_pets
--Godly
--Secret
--Mythical
--World
--do_barrier_damage
--GetData
--SetLocalData
--GetTargetPosition
--do_local_drops
--left_click
--getEquippedUnits
--attempt_open_chest
--item_clicked
--updatePlayerPosition
--TalentReroll
--PassiveReroll
--SummonSecret
--SetBaseValue
--WorldChests
--autoEscape
--get_current_game_state
--GetAllRewards
--set_equip_slot
--toggle_equip_pet
--CheckPets
--checkPet
--TouchStart
--TouchEnded
--player.PlayerGui.MainGui.MainGuiHandler.HUD.BottomButtons.Clicker.FakeClick()
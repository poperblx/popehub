local remote = game:GetService("ReplicatedStorage").Remote;
local player = game.Players.LocalPlayer;

-- *********************** RESPAWN PETS ***********************
function respawnPets()
    for index,pet in pairs(player.Pets:GetChildren()) do
        key = tostring(index)
        remote.Data.SetEquipSlot:FireServer(key);
        wait(0.5);
        remote.Data.SetEquipSlot:FireServer(key,tostring(pet.Value));
        wait();
    end
end
-- *********************** RESPAWN PETS ***********************

respawnPets();
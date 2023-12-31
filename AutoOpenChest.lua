local funcName = "attempt_open_chest";
local func;

function openChests()
    for i,v in pairs(getgc()) do
        if type(v) == 'function' and getinfo(v).name and getinfo(v).name == funcName then
            func = v;
            break;
        end
    end
    
    for i,v in pairs(workspace.Worlds.Raids:FindFirstChild("1"):GetDescendants()) do
        if v.Name == "ChristmasChest" and v.Parent then
            func(v);
            wait(0.1);
        end
    end
end
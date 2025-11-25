repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

local place = game.PlaceId
local BLOXFRUITS_PLACES = {
    [2753915549] = true,  -- Sea 1
    [4442272183] = true,  -- Sea 3
    [7449423635] = true,  -- Sea 2
}

if BLOXFRUITS_PLACES[place] then
    pcall(function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/monster-hub-lol/MonsterHub/refs/heads/main/src/bloxfruits.lua"))()

else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/monster-hub-lol/MonsterHub/refs/heads/main/src/allinone.lua"))()
end

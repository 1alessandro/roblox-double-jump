local MaxJumps = 2
local JumpCooldown = 0.2

local UIS = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Char:WaitForChild("Humanoid")
local NumJumps = 0
local canjump = false

Humanoid.StateChanged:Connect(function(_, newstate)
	if newstate == Enum.HumanoidStateType.Landed then
		NumJumps = 0
		canjump = false
	elseif newstate == Enum.HumanoidStateType.Freefall then
		wait(JumpCooldown)
		canjump = true
	elseif newstate == Enum.HumanoidStateType.Jumping then
		canjump = false
		NumJumps = NumJumps + 1
	end
end)

UIS.JumpRequest:Connect(function()
	if canjump and NumJumps < MaxJumps then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

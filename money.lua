local args = {
    [1] = "money",
    [2] = 9999999999999999999999999999999
}

game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer(unpack(args))

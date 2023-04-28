--- 敏感词检测插件
--- 适用于NyaBot
--- 作者：Nagato1337(isNagatoYuki)
--- 使用该插件需要保证NyaBot执行文件的目录下有一个名为BannedMessage.txt的文件

local file = io.open("BannedMessage.txt", "r")
local bannedMessage = {}
if not file then
    print("BannedMessage.txt not found")
    return
end
for line in file:lines() do
    table.insert(bannedMessage, line)
end

for i = 1, #bannedMessage do
    if string.find(Callback.CqCall.MessageData, bannedMessage[i]) then
        CqAct:GroupBan(Callback.CqCall.GroupID, Callback.CqCall.UserID, 60, false)
        reason = "Suspicious Account Activity"
        CqMsg:SendMsg("用户 " .. Callback.CqCall.UserID .. " 被NagatoAntiCheat封禁了!\n封禁原因：" .. reason, Callback.CqCall.GroupID, true)
    end
end
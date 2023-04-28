--- 群成员昵称修改器
--- 作者: Nagato1337(isNagatoYuki)
--- 适用于NyaBot
--- 设置admin_userid为指定的管理员QQ号，只有管理员才能使用该功能。当管理员使用了".rename <昵称>"后，群内所有成员的昵称都会被修改为类似于Discord的<昵称>#<序号>的格式。
local admin_userid = 3245433516

function split(text, delim)
    -- returns an array of fields based on text and delimiter (one character only)
    local result = {}
    local magic = "().%+-*?[]^$"

    if delim == nil then
        delim = "%s"
    elseif string.find(delim, magic, 1, true) then
        -- escape magic
        delim = "%"..delim
    end

    local pattern = "[^"..delim.."]+"
    for w in string.gmatch(text, pattern) do
        table.insert(result, w)
    end
    return result
end

if string.sub(Callback.CqCall.MessageData, 1, 7) == ".rename" and Callback.CqCall.UserID == admin_userid then
    CqMsg:SendMsg("主播在改了，你先别急", Callback.CqCall.GroupID, true)
    splitRes = split(string.gsub(Callback.CqCall.MessageData, ".rename%s", ""), "%s")

    GroupMemberIDS = CqGet:GetGroupMembers(Callback.CqCall.GroupID)
    for i = 1, #GroupMemberIDS do
        CqAct:SetGroupInfo(Callback.CqCall.GroupID, "", "", GroupMemberIDS[i].UserID, splitRes[1] .. "#" .. string.format("%04d", i), "", 3)
    end
    CqMsg:SendMsg("主播改完了", Callback.CqCall.GroupID, true)
end
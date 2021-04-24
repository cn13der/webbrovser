addEventHandler("onPlayerLogin", root, function()
	if isPlayerInACLGroup(source, "Admin") or isPlayerInACLGroup(source, "Console") then
		triggerClientEvent(source, "IAmAdmin", source, true)
	end
end)
addEventHandler("onPlayerLogout", root, function()
	triggerClientEvent(source, "IAmAdmin", source, false)
end)

function isPlayerInACLGroup(thePlayer, group)
     if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup(group)) then
     	return true
     else
     	return false
     end
end


local base = dbConnect("sqlite", "bookmarks.db")

addEvent("AddBookmark", true)
addEventHandler("AddBookmark", root, function(...)
	addBookmark(...)
end)

function addBookmark(id, text, url, color)
	local queru = string.format('UPDATE `Bookmarks` SET Title="%s", URL="%s", Color="%s" WHERE ID=%i', text, url, color, id)
	dbExec(base, queru)
end

function getBookmarks()
	local queru = "SELECT * FROM `Bookmarks`"
	local query = dbQuery(base, queru)
	local result = dbPoll(query, -1)

	local tab = {}
	for i in pairs(result) do
		tab[tonumber(i)] = {}
		tab[tonumber(i)].title = result[i]["Title"]
		tab[tonumber(i)].url = result[i]["URL"]
		tab[tonumber(i)].color = result[i]["Color"]
	end

	--outputDebugString(tab[1].title)
	--outputDebugString(tab[2].url)
	--outputDebugString(tab[5].color)

	return tab
end

addEventHandler("onResourceStart", root, function(res)
	if res ~= getThisResource() then return false end

	setTimer(function()
		local tab = getBookmarks()
		triggerClientEvent(root, "AllBookmarks", root, tab)
		
		for _, v in ipairs(getElementsByType("player")) do
			if isPlayerInACLGroup(v, "Admin") or isPlayerInACLGroup(v, "Console") then
				triggerClientEvent(v, "IAmAdmin", v, true)
			end
		end
	end, 1000, 1)
end)

addEvent("getMarks", true)
addEventHandler("getMarks", root, function()
	local tab = getBookmarks()
	triggerClientEvent(root, "AllBookmarks", root, tab)
end)
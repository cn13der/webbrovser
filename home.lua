local Browser = getBrowser()
local Sizes = getSizes()
Sizes[2] = Sizes[2] - 42

local pane = "imgs/pane.png" --Основное изображение
local round = "imgs/round.png" --Окружность

local isPlayerAdmin = false

local Home = GuiStaticImage.create(0, 32, Sizes[1], Sizes[2], pane, false, Browser.Frame)
Home:setProperty("ImageColours", "tl:0 tr:0 bl:0 br:0")
local HomeCenter = GuiStaticImage.create(0, 0, Sizes[1], Sizes[2], pane, false, Home)
HomeCenter:setProperty("ImageColours", "tl:0 tr:0 bl:0 br:0")

function bringFront()
	Home:bringToFront()
end

local HomeTitle = GuiLabel.create(0, 10, Sizes[1], 40, "Welcome, "..getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "").."!", false, HomeCenter)
HomeTitle:setFont(guiCreateFont(Font.OpenSansLight, 24))
HomeTitle:setColor(fromHEXToRGB("EEEEEE"))
HomeTitle:setVerticalAlign("center")
HomeTitle:setHorizontalAlign("center")

local HomeInfo = GuiLabel.create(0, 50, Sizes[1], 24, "This bookmarks is actual for this server. Enjoy!", false, HomeCenter)
HomeInfo:setFont(guiCreateFont(Font.OpenSansLight, 12))
HomeInfo:setColor(fromHEXToRGB("EEEEEE"))
HomeInfo:setHorizontalAlign("center")

local SettsInfo = GuiLabel.create(0, 0, 1, 0.1, "Settings  ", true, Home)
SettsInfo:setFont(guiCreateFont(Font.OpenSansRegular, 9))
SettsInfo:setColor(fromHEXToRGB("EEEEEE"))
SettsInfo:setHorizontalAlign("right")

local FrameEditBookmark = GuiStaticImage.create(Sizes[1]/2-150, (Sizes[2]+42)/2-90, 300, 180, pane, false, getSettsPane())
function getFrameZ() return FrameEditBookmark end
local TitleDiv = GuiStaticImage.create(0, 29, 300, 1, pane, false, FrameEditBookmark)
TitleDiv:setProperty("ImageColours", "tl:FFCCCCCC tr:FFCCCCCC bl:FFCCCCCC br:FFCCCCCC")

local MainFrame = GuiStaticImage.create(0, 30, 300, 150, pane, false, FrameEditBookmark)
MainFrame:setProperty("ImageColours", "tl:FFEEEEEE tr:FFEEEEEE bl:FFEEEEEE br:FFEEEEEE")

local MainTitle = GuiLabel.create(0, 0, 300, 29, "New Bookmark", false, FrameEditBookmark)
MainTitle:setFont(guiCreateFont(Font.OpenSansRegular, 11))
MainTitle:setColor(fromHEXToRGB("4F4F4F"))
MainTitle:setVerticalAlign("center")
MainTitle:setHorizontalAlign("center")

local TitleInfo = GuiLabel.create(5, 5, 30, 30, "Title", false, MainFrame)
TitleInfo:setFont(guiCreateFont(Font.OpenSansRegular, 9))
TitleInfo:setColor(fromHEXToRGB("4F4F4F"))
TitleInfo:setVerticalAlign("center")
TitleInfo:setHorizontalAlign("right")

local Theme = "D62727"  --Цветовая тема
local TitleEdit = guiCreateQuadEdit(40, 5, 255, 30, "", false, MainFrame)
TitleEdit:setFont(guiCreateFont(Font.OpenSansRegular, 9)) --Шрифтик
TitleEdit:setProperty("NormalTextColour", "FF4F4F4F")
TitleEdit:setProperty("ActiveSelectionColour", "FF"..Theme)

local URLInfo = GuiLabel.create(5, 40, 30, 30, "URL", false, MainFrame)
URLInfo:setFont(guiCreateFont(Font.OpenSansRegular, 9))
URLInfo:setColor(fromHEXToRGB("4F4F4F"))
URLInfo:setVerticalAlign("center")
URLInfo:setHorizontalAlign("right")

local URLEdit = guiCreateQuadEdit(40, 40, 255, 30, "", false, MainFrame)
URLEdit:setFont(guiCreateFont(Font.OpenSansRegular, 9)) --Шрифтик
URLEdit:setProperty("NormalTextColour", "FF4F4F4F")
URLEdit:setProperty("ActiveSelectionColour", "FF"..Theme)

local ColorInfo = GuiLabel.create(5, 75, 30, 30, "Color", false, MainFrame)
ColorInfo:setFont(guiCreateFont(Font.OpenSansRegular, 9))
ColorInfo:setColor(fromHEXToRGB("4F4F4F"))
ColorInfo:setVerticalAlign("center")
ColorInfo:setHorizontalAlign("right")

local ColorEdit = guiCreateQuadEdit(40, 75, 255-30, 30, "", false, MainFrame)
ColorEdit:setFont(guiCreateFont(Font.OpenSansRegular, 9)) --Шрифтик
ColorEdit:setProperty("NormalTextColour", "FF4F4F4F")
ColorEdit:setProperty("ActiveSelectionColour", "FF"..Theme)

local ColorChanger = GuiStaticImage.create(255+40-30, 75, 30, 30, pane, false, MainFrame)
ColorChanger:setProperty("ImageColours", "tl:FF6600FF tr:FF6600FF bl:FF6600FF br:FF6600FF")

local ButtonApply = GuiLabel.create(0, 110, 150, 40, "Apply", false, MainFrame)
ButtonApply:setFont(guiCreateFont(Font.OpenSansRegular, 10))
ButtonApply:setColor(fromHEXToRGB("4F4F4F"))
ButtonApply:setVerticalAlign("center")
ButtonApply:setHorizontalAlign("center")

local ButtonClear = GuiLabel.create(150, 110, 150, 40, "Clear", false, MainFrame)
ButtonClear:setFont(guiCreateFont(Font.OpenSansRegular, 10))
ButtonClear:setColor(fromHEXToRGB("4F4F4F"))
ButtonClear:setVerticalAlign("center")
ButtonClear:setHorizontalAlign("center")

local SelectedBookmark = 0

addEventHandler("onClientMouseEnter", root, function()
	if source == ButtonApply or source == ButtonClear then source:setColor(fromHEXToRGB(Theme)) end
end)
addEventHandler("onClientMouseLeave", root, function()
	ButtonApply:setColor(fromHEXToRGB("4F4F4F"))
	ButtonClear:setColor(fromHEXToRGB("4F4F4F"))
end)
local Bookmarks = {}

addEventHandler("onClientGUIClick", root, function()
	if source == ButtonClear then
		MainTitle:setText("New Bookmark")
		TitleEdit:setText("")
		URLEdit:setText("")
		ColorEdit:setText("")
		ColorChanger:setProperty("ImageColours", "tl:FFFFFFFF tr:FFFFFFFF bl:FFFFFFFF br:FFFFFFFF")
	end
	if source == ButtonApply then
		showSettings(2)
		local color = ColorEdit:getText()
		local title = TitleEdit:getText()
		local urles = URLEdit:getText()
		addBookmark(SelectedBookmark, title, urles, color)
		triggerServerEvent("AddBookmark", root, SelectedBookmark, title, urles, color)
	end
end)

function getTitleEdit() return TitleEdit end
function getURLEdit() return URLEdit end
function getColorEdit() return ColorEdit end
addEventHandler("onClientGUIChanged", root, function()
	if source == ColorEdit then
		if ColorEdit:getText():len() >= 6 then
			local len = ColorEdit:getText():len()
			local text = ColorEdit:getText()
			text = text:sub(len-5, len)
			ColorEdit:setText(text)
			ColorChanger:setProperty("ImageColours", "tl:FF"..text.." tr:FF"..text.." bl:FF"..text.." br:FF"..text)
		end
	end
end)

addEventHandler("onClientResourceStart", root, function(res)
	if res ~= getThisResource() then return false end
	setTimer(function()
		triggerServerEvent("getMarks", root)
	end, 1000, 1)
end)

local Coordinates = {
	[1] = {200, 120},
	[2] = {350, 120},
	[3] = {500, 120},
	[4] = {275, 270},
	[5] = {425, 270}
}
for int = 1, 5 do
	local i = int
	Bookmarks[i] = {}
	Bookmarks[i].Icon = GuiStaticImage.create(Coordinates[i][1], Coordinates[i][2], 100, 100, round, false, HomeCenter)

	Bookmarks[i].Title = GuiLabel.create(Coordinates[i][1]-10, Coordinates[i][2]+100, 120, 30, "", false, HomeCenter)
	Bookmarks[i].Title:setFont(guiCreateFont(Font.OpenSansRegular, 15))
	Bookmarks[i].Title:setColor(fromHEXToRGB("EEEEEE"))
	Bookmarks[i].Title:setHorizontalAlign("center")

	Bookmarks[i].Link = GuiLabel.create(Coordinates[i][1]-10, Coordinates[i][2]+125, 120, 20, "", false, HomeCenter)
	Bookmarks[i].Link:setFont(guiCreateFont(Font.OpenSansLight, 9))
	Bookmarks[i].Link:setColor(fromHEXToRGB("EEEEEE"))

	addEventHandler("onClientGUIClick", root, function(but)
		if source == Bookmarks[i].Icon then 

			if but ~= "right" then
				local int = getSelectedTab()
				local text = Bookmarks[i].Link:getText()
				if not text or text == "" then return false end

				if but == "middle" or getNumberOpenedTabs() == 0 then
					int = createTab(true)
				end
				loadWebURL(int, text, true)
			
			else
				if isPlayerAdmin then
					showSettings(1, 2)
					SelectedBookmark = i

					local titl = Bookmarks[i].Title:getText()
					local urls = Bookmarks[i].Link:getText()
					local colr, cols = fromPropertyToHEX(Bookmarks[i].Icon)
					MainTitle:setText(titl ~= "" and titl or "New Bookmark")
					TitleEdit:setText(titl ~= "" and titl or "")
					URLEdit:setText(urls ~= "" and urls or "")
					ColorEdit:setText(cols == "FFFFFF" and "" or cols)
					ColorChanger:setProperty("ImageColours", "tl:"..colr.." tr:"..colr.." bl:"..colr.." br:"..colr)
				end
			end

		end
	end)
	addEventHandler("onClientMouseEnter", root, function()
		if source == Bookmarks[i].Icon then 
			if Bookmarks[i].Title:getText() == "" then 
				if not isPlayerAdmin then return false end 
			end
			source:setAlpha(0.5) 
		end
	end)
	addEventHandler("onClientMouseLeave", root, function()
		Bookmarks[i].Icon:setAlpha(1)
	end)

	--Bookmarks[i].Icon:setEnabled(false)
	--outputDebugString("false, "..i)
end

function addBookmark(id, title, link, color)
	
	Bookmarks[id].Title:setText(title or "")
	Bookmarks[id].Link:setText(link or "")

	if not title and not link and not color then
		color = "FFFFFF"
		Bookmarks[id].Icon:setProperty("ImageColours", "tl:FF"..color.." tr:FF"..color.." bl:FF"..color.." br:FF"..color)
		--Bookmarks[id].Icon:setEnabled(false)
		--outputDebugString("false, "..id)
		return false
	else
		--Bookmarks[id].Icon:setEnabled(true)
		--outputDebugString("true, "..id)
	end

	if not link or not title or not color then color = "FFFFFF" end
	if color == "" then color = "FFFFFF" end
	Bookmarks[id].Icon:setProperty("ImageColours", "tl:FF"..color.." tr:FF"..color.." bl:FF"..color.." br:FF"..color)
	Bookmarks[id].Title:setColor(fromHEXToRGB(color))

	for _, v in ipairs(getElementsByType("player")) do
		if v == localPlayer then return false end
		triggerEvent("addBookmark", v, id, title, link, color)
	end
end

addEvent("addBookmark", true)
addEventHandler("addBookmark", root, addBookmark)

--addBookmark(1, "Youtube", "http://youtube.com", "FC2222")
--addBookmark(5, "Google", "http://google.com/ncr", "5566FF")

function setHomeSize(w, h)
	Home:setSize(w, h-42, false)
	HomeCenter:setPosition((w/2)-(Sizes[1]/2), ((h-42)/2)-(Sizes[2]/2), false)
end

function changeHomeTheme(text)
	HomeInfo:setColor(fromHEXToRGB(text))
	HomeTitle:setColor(fromHEXToRGB(text))
	SettsInfo:setColor(fromHEXToRGB(text))
	for i in pairs(Bookmarks) do
		Bookmarks[i].Link:setColor(fromHEXToRGB(text))
	end
end

addEvent("IAmAdmin", true)
addEventHandler("IAmAdmin", root, function(bool)
	isPlayerAdmin = bool
end)

addEvent("AllBookmarks", true)
addEventHandler("AllBookmarks", root, function(tables)
	for i in pairs(tables) do
		addBookmark(i, tables[i].title, tables[i].url, tables[i].color)
	end
end)
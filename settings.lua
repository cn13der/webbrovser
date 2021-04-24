local Browser = getBrowser()
local Colors = getColors()
local Theme = "D62727"  --Цветовая тема
local Sizes = getSizes()
local Width, Height = guiGetScreenSize()
local BrowserStory = {}

local pane = "imgs/pane.png" --Основное изображение

--Задняя часть окна настроек
local BackGround = GuiStaticImage.create(0, 0, 1, 1, pane, true, Browser.Window)
BackGround:setProperty("ImageColours", "tl:66000000 tr:66000000 bl:66000000 br:66000000")
BackGround:setProperty("AlwaysOnTop", "True") --Поверх всего
Browser:setMoveElement(BackGround) --Добавляем окну элементы перемещения

local FrontPanel = GuiStaticImage.create(200, 100, 400, 400, pane, false, BackGround)

local MainSettings = GuiLabel.create(0, 0, 0.25, 0.1, "Settings", true, FrontPanel)
MainSettings:setFont(guiCreateFont(Font.OpenSansRegular, 10))
MainSettings:setColor(fromHEXToRGB(Theme))
MainSettings:setVerticalAlign("center")
MainSettings:setHorizontalAlign("center")

local History = GuiLabel.create(0.25, 0, 0.25, 0.1, "History", true, FrontPanel)
History:setFont(guiCreateFont(Font.OpenSansRegular, 10))
History:setColor(fromHEXToRGB("4F4F4F"))
History:setVerticalAlign("center")
History:setHorizontalAlign("center")

local About = GuiLabel.create(0.5, 0, 0.25, 0.1, "About", true, FrontPanel)
About:setFont(guiCreateFont(Font.OpenSansRegular, 10))
About:setColor(fromHEXToRGB("4F4F4F"))
About:setVerticalAlign("center")
About:setHorizontalAlign("center")

local Help = GuiLabel.create(0.75, 0, 0.25, 0.1, "Help", true, FrontPanel)
Help:setFont(guiCreateFont(Font.OpenSansRegular, 10))
Help:setColor(fromHEXToRGB("4F4F4F"))
Help:setVerticalAlign("center")
Help:setHorizontalAlign("center")

local Divider = GuiStaticImage.create(0, 400*0.1, 400, 1, pane, false, FrontPanel)
Divider:setProperty("ImageColours", "tl:FFCCCCCC tr:FFCCCCCC bl:FFCCCCCC br:FFCCCCCC")

local SettingsTab = GuiStaticImage.create(0, 400*0.1+1, 400, 400*0.9-1, pane, false, FrontPanel)
SettingsTab:setProperty("ImageColours", "tl:FFEEEEEE tr:FFEEEEEE bl:FFEEEEEE br:FFEEEEEE")

local HistoryTab = GuiStaticImage.create(400, 400*0.1+1, 400, 400*0.9-1, pane, false, FrontPanel)
HistoryTab:setProperty("ImageColours", "tl:FFEEEEEE tr:FFEEEEEE bl:FFEEEEEE br:FFEEEEEE")

local AboutTab = GuiStaticImage.create(400, 400*0.1+1, 400, 400*0.9-1, pane, false, FrontPanel)
AboutTab:setProperty("ImageColours", "tl:FFEEEEEE tr:FFEEEEEE bl:FFEEEEEE br:FFEEEEEE")

local InfoTab = GuiStaticImage.create(400, 400*0.1+1, 400, 400*0.9-1, pane, false, FrontPanel)
InfoTab:setProperty("ImageColours", "tl:FFEEEEEE tr:FFEEEEEE bl:FFEEEEEE br:FFEEEEEE")

local TitleInfo = GuiLabel.create(5, 5, 390, 60, [[To close this browser, press ]]..getKey()..[[ or press on round 
in top left corner]], false, InfoTab)
TitleInfo:setFont(guiCreateFont(Font.OpenSansRegular, 9))
TitleInfo:setColor(fromHEXToRGB("3F3F3F"))
TitleInfo:setHorizontalAlign("center")

local HelpFunctionLeft = GuiLabel.create(5, 60, 150, 400*0.9-60, 
[[Ctrl+N

Middle Mouse Button

Scroll MMB]], false, InfoTab)
HelpFunctionLeft:setFont(guiCreateFont(Font.OpenSansRegular, 9))
HelpFunctionLeft:setColor(fromHEXToRGB("3F3F3F"))
HelpFunctionLeft:setHorizontalAlign("right")

local HelpFunctionRight = GuiLabel.create(160, 60, 230, 400*0.9-60,
[[Open new tab in browser

By clicking MMB on the tab, it close

By scrolling MMB on tabs, it wil be
switching]], false, InfoTab)
HelpFunctionRight:setFont(guiCreateFont(Font.OpenSansRegular, 9))
HelpFunctionRight:setColor(fromHEXToRGB("6F6F6F"))

---НАСТРОЙКИ
local ColorText = GuiLabel.create(4, 5, 97, 30, "Color Scheme", false, SettingsTab)
ColorText:setFont(guiCreateFont(Font.OpenSansRegular, 9))
ColorText:setColor(fromHEXToRGB("4F4F4F"))
ColorText:setVerticalAlign("center")
ColorText:setHorizontalAlign("right")

local Schemes = {}
local Nums = 0
for i in pairs(Colors) do
	Schemes[i] = GuiStaticImage.create(104+Nums*35, 5, 30, 30, pane, false, SettingsTab)
	Schemes[i]:setProperty("ImageColours", "tl:FF"..Colors[i].Top.." tr:FF"..Colors[i].Top.." bl:FF"..Colors[i].Top.." br:FF"..Colors[i].Top)
	Nums = Nums + 1
end
local CustomText = GuiLabel.create(4, 40, 97, 30, "Custom size", false, SettingsTab)
CustomText:setFont(guiCreateFont(Font.OpenSansRegular, 9))
CustomText:setColor(fromHEXToRGB("4F4F4F"))
CustomText:setVerticalAlign("center")
CustomText:setHorizontalAlign("right")

local WidthEdit = guiCreateQuadEdit(104, 40, 50, 30, Sizes[1], false, SettingsTab)
local HeighEdit = guiCreateQuadEdit(154, 40, 50, 30, Sizes[2], false, SettingsTab)
WidthEdit:setFont(guiCreateFont(Font.OpenSansRegular, 9)) --Шрифтик
WidthEdit:setProperty("NormalTextColour", "FF4F4F4F")
WidthEdit:setProperty("ActiveSelectionColour", "FF"..Theme)
HeighEdit:setFont(guiCreateFont(Font.OpenSansRegular, 9)) --Шрифтик
HeighEdit:setProperty("NormalTextColour", "FF4F4F4F")
HeighEdit:setProperty("ActiveSelectionColour", "FF"..Theme)

local ApplyButton = GuiLabel.create(204, 40, 50, 30, "Apply", false, SettingsTab)
ApplyButton:setFont(guiCreateFont(Font.OpenSansRegular, 8))
ApplyButton:setColor(fromHEXToRGB("3F3F3F"))
ApplyButton:setVerticalAlign("center")
ApplyButton:setHorizontalAlign("center")

local MinimalSize = GuiLabel.create(30, 70, 80, 30, "800x600", false, SettingsTab)
MinimalSize:setFont(guiCreateFont(Font.OpenSansRegular, 8))
MinimalSize:setColor(fromHEXToRGB("3F3F3F"))
MinimalSize:setVerticalAlign("center")
MinimalSize:setHorizontalAlign("center")
local MaximalSize = GuiLabel.create(110, 70, 80, 30, Width.."x"..Height, false, SettingsTab)
MaximalSize:setFont(guiCreateFont(Font.OpenSansRegular, 8))
MaximalSize:setColor(fromHEXToRGB("3F3F3F"))
MaximalSize:setVerticalAlign("center")
MaximalSize:setHorizontalAlign("center")

local SearchText = GuiLabel.create(4, 105, 97, 30, "Search Engine", false, SettingsTab)
SearchText:setFont(guiCreateFont(Font.OpenSansRegular, 9))
SearchText:setColor(fromHEXToRGB("4F4F4F"))
SearchText:setVerticalAlign("center")
SearchText:setHorizontalAlign("right")
local SearchEdit = guiCreateQuadEdit(104, 105, 246, 30, getSearchEngine(), false, SettingsTab)
SearchEdit:setFont(guiCreateFont(Font.OpenSansRegular, 9)) --Шрифтик
SearchEdit:setProperty("NormalTextColour", "FF4F4F4F")
SearchEdit:setProperty("ActiveSelectionColour", "FF"..Theme)
local SearchButton = GuiLabel.create(350, 105, 50, 30, "Apply", false, SettingsTab)
SearchButton:setFont(guiCreateFont(Font.OpenSansRegular, 8))
SearchButton:setColor(fromHEXToRGB("3F3F3F"))
SearchButton:setVerticalAlign("center")
SearchButton:setHorizontalAlign("center")

local GoogleEngine = GuiLabel.create(30, 135, 80, 30, "Google", false, SettingsTab)
GoogleEngine:setFont(guiCreateFont(Font.OpenSansRegular, 8))
GoogleEngine:setColor(fromHEXToRGB("3F3F3F"))
GoogleEngine:setVerticalAlign("center")
GoogleEngine:setHorizontalAlign("center")
local YandexEngine = GuiLabel.create(110, 135, 80, 30, "Yandex", false, SettingsTab)
YandexEngine:setFont(guiCreateFont(Font.OpenSansRegular, 8))
YandexEngine:setColor(fromHEXToRGB("3F3F3F"))
YandexEngine:setVerticalAlign("center")
YandexEngine:setHorizontalAlign("center")
--[[local BingEngine = GuiLabel.create(190, 135, 80, 30, "Bing", false, SettingsTab)
BingEngine:setFont(guiCreateFont(Font.OpenSansRegular, 8))
BingEngine:setColor(fromHEXToRGB("3F3F3F"))
BingEngine:setVerticalAlign("center")
BingEngine:setHorizontalAlign("center")]]

local PageCodes = GuiLabel.create(4, 170, 150, 30, "Get page source code", false, SettingsTab)
PageCodes:setFont(guiCreateFont(Font.OpenSansRegular, 9))
PageCodes:setColor(fromHEXToRGB("3F3F3F"))
PageCodes:setVerticalAlign("center")
PageCodes:setHorizontalAlign("center")

local StoryList = ScrollMenu.create(0, 20, 400, 400*0.9-21, false, HistoryTab)
local ClearCache = GuiLabel.create(0, 0, 400, 20, "Empty", false, HistoryTab)
ClearCache:setFont(guiCreateFont(Font.OpenSansRegular, 9))
ClearCache:setColor(fromHEXToRGB("3F3F3F"))
ClearCache:setVerticalAlign("center")
ClearCache:setHorizontalAlign("center")
ClearCache:setEnabled(false)

local Logo = GuiStaticImage.create(150, 20, 100, 100, "imgs/logo.png", false, AboutTab)
local AboutInfo = GuiLabel.create(0, 120, 400, 30, "Lunix Web", false, AboutTab)
AboutInfo:setFont(guiCreateFont(Font.OpenSansRegular, 14))
AboutInfo:setColor(fromHEXToRGB("C21211"))
AboutInfo:setVerticalAlign("center")
AboutInfo:setHorizontalAlign("center")

local AboutInfoOne = GuiLabel.create(0, 160, 195, 80, "Author & Scripter\nDesigners\nThanks to", false, AboutTab)
AboutInfoOne:setFont(guiCreateFont(Font.OpenSansBold, 10))
AboutInfoOne:setColor(fromHEXToRGB("4F4F4F"))
AboutInfoOne:setVerticalAlign("center")
AboutInfoOne:setHorizontalAlign("right")

local AboutInfoTwo = GuiLabel.create(205, 160, 195, 80, "AriosJentu\nLarma Darma, AriosJentu\nMediym", false, AboutTab)
AboutInfoTwo:setFont(guiCreateFont(Font.OpenSansRegular, 10))
AboutInfoTwo:setColor(fromHEXToRGB("6F6F6F"))
AboutInfoTwo:setVerticalAlign("center")
AboutInfoTwo:setHorizontalAlign("left")

local LinkToChannel = GuiLabel.create(0, 250, 400, 80, "Our YouTube channel", false, AboutTab)
LinkToChannel:setFont(guiCreateFont(Font.OpenSansRegular, 11))
LinkToChannel:setColor(fromHEXToRGB(Theme))
LinkToChannel:setVerticalAlign("center")
LinkToChannel:setHorizontalAlign("center")

local Stories = {}
function addStoryLink(name, url)
	local id = #Stories + 1
	Stories[id] = {}

	ClearCache:setText("Clear")
	ClearCache:setEnabled(true)

	Stories[id].Name = GuiLabel.create(0, 0, 140, 20, name, false, StoryList.Menu)
	Stories[id].Name:setFont(guiCreateFont(Font.OpenSansRegular, 9))
	Stories[id].Name:setColor(fromHEXToRGB("6F6F6F"))
	Stories[id].Name:setVerticalAlign("center")
	Stories[id].Name:setHorizontalAlign("right")

	Stories[id].Link = GuiLabel.create(150, 0, 250, 20, url, false, StoryList.Menu)
	Stories[id].Link:setFont(guiCreateFont(Font.OpenSansRegular, 9))
	Stories[id].Link:setColor(fromHEXToRGB("3F3F3F"))
	Stories[id].Link:setVerticalAlign("center")

	StoryList:addElement(Stories[1].Link)
	StoryList:addScrollElement(Stories[id].Link, "y")
	StoryList:addScrollElement(Stories[id].Name, "y")

	Stories[id].URL = url

	for i in pairs(Stories) do
		Stories[#Stories-i+1].Name:setPosition(0, 20*(i-1), false)
		Stories[#Stories-i+1].Link:setPosition(150, 20*(i-1), false)
	end

	addEventHandler("onClientMouseEnter", root, function()
		if Stories[id] ~= nil then		
			if source == Stories[id].Link then
				Stories[id].Link:setColor(fromHEXToRGB(Theme))
			end
		end
	end)
	addEventHandler("onClientMouseLeave", root, function()
		if Stories[id] ~= nil then
			Stories[id].Link:setColor(fromHEXToRGB("3F3F3F"))
		end
	end)

	addEventHandler("onClientGUIClick", root, function()
		click(id)
	end)

end

function click(id)
	if Stories[id] ~= nil then
		if source == Stories[id].Link then
			local tab = createTab(true)
			showSettings(2)
			loadWebURL(tab, Stories[id].URL)
		end
	end
end

function clearAllHistory()
	for i in pairs(Stories) do
		destroyElement(Stories[i].Link)
		destroyElement(Stories[i].Name)
		Stories[i] = nil
		removeEventHandler("onClientGUIClick", root, function() click(i) end)
	end
end

addEventHandler("onClientBrowserLoadingStart", root, function(url)
	if url == "about:blank" then return false end
	addStoryLink(getBrowserTitle(source), url)
end)

local Movers = {}
local ListAnimation = 0
local ActiveWindow = SettingsTab
local ActiveTab = MainSettings
function doChanging(to)
	if to == ActiveWindow then return false end

	local num = 1
	if to == SettingsTab then num = 2 end
	if to == HistoryTab and (ActiveWindow == InfoTab or ActiveWindow == AboutTab) then num = 2 end
	if to == AboutTab and ActiveWindow == InfoTab then num = 2 end

	SettingsTab:setPosition(400, 400*0.1+1, false)
	HistoryTab:setPosition(400, 400*0.1+1, false)
	AboutTab:setPosition(400, 400*0.1+1, false)
	InfoTab:setPosition(400, 400*0.1+1, false)

	if num == 1 then
		ActiveWindow:setPosition(0, 400*0.1+1, false)
		to:setPosition(400, 400*0.1+1, false)
	else
		ActiveWindow:setPosition(0, 400*0.1+1, false)
		to:setPosition(-400, 400*0.1+1, false)
	end

	local id = ActiveWindow
	Movers = {id, to}
	ListAnimation = num
	ActiveWindow = to

	if to == SettingsTab then ActiveTab = MainSettings end
	if to == InfoTab then ActiveTab = Help end
	if to == HistoryTab then ActiveTab = History end
	if to == AboutTab then ActiveTab = About end
end

local Animation = 0
addEventHandler("onClientRender", root, function()
	if Animation == 1 then --Анимация открытия
		BackGround:setAlpha(BackGround:getAlpha()+0.1)
		BackGround:setVisible(true)
		
		if BackGround:getAlpha() >= 1 then
			Animation = 0
			local a, b, c, d, e, f = getTitleEdit(), getColorEdit(), getURLEdit(), SearchEdit, WidthEdit, HeighEdit
			local tab = {a,b,c,d,e,f}
			for i in pairs(tab) do
				tab[i]:setVisible(true)
			end
		end
	elseif Animation == 2 then --Анимация закрытия
		BackGround:setAlpha(BackGround:getAlpha()-0.1)
		
		if BackGround:getAlpha() <= 0 then
			BackGround:setVisible(false)
			Animation = 0
		end
	end

	if ListAnimation == 1 then
		local x, y = Movers[2]:getPosition(false)
		x = x-20
		if x < 0 then x = 0 end
		Movers[1]:setPosition(x-400, y, false)
		Movers[2]:setPosition(x, y, false)

		if x == 0 then
			ListAnimation = 0
			Movers[1]:setPosition(400, y, false)
		end
	elseif ListAnimation == 2 then
		local x, y = Movers[2]:getPosition(false)
		x = x+20
		if x > 0 then x = 0 end
		Movers[1]:setPosition(x+400, y, false)
		Movers[2]:setPosition(x, y, false)

		if x == 0 then
			ListAnimation = 0
			Movers[1]:setPosition(400, y, false)
		end
	end
end)

addEvent("onClientStaticWindowFullClosed", true)
addEvent("onClientStaticWindowResize", true)

addEventHandler("onClientGUIClick", root, function()
	if source == BackGround then showSettings(2) SearchEdit:setText(getSearchEngine()) end
	if source == MainSettings then
		MainSettings:setColor(fromHEXToRGB(Theme))
		History:setColor(fromHEXToRGB("4F4F4F"))
		About:setColor(fromHEXToRGB("4F4F4F"))
		Help:setColor(fromHEXToRGB("4F4F4F"))
		doChanging(SettingsTab)
	elseif source == History then
		History:setColor(fromHEXToRGB(Theme))
		MainSettings:setColor(fromHEXToRGB("4F4F4F"))
		About:setColor(fromHEXToRGB("4F4F4F"))
		Help:setColor(fromHEXToRGB("4F4F4F"))
		doChanging(HistoryTab)
	elseif source == About then
		About:setColor(fromHEXToRGB(Theme))
		MainSettings:setColor(fromHEXToRGB("4F4F4F"))
		History:setColor(fromHEXToRGB("4F4F4F"))
		Help:setColor(fromHEXToRGB("4F4F4F"))
		doChanging(AboutTab)
	elseif source == Help then
		Help:setColor(fromHEXToRGB(Theme))
		MainSettings:setColor(fromHEXToRGB("4F4F4F"))
		About:setColor(fromHEXToRGB("4F4F4F"))
		History:setColor(fromHEXToRGB("4F4F4F"))
		doChanging(InfoTab)
	end

	if source == ClearCache then
		ClearCache:setEnabled(false)
		ClearCache:setText("Empty")
		ClearCache:setColor(fromHEXToRGB("3F3F3F"))
		clearAllHistory()
	end

	for i in pairs(Schemes) do
		if source == Schemes[i] then
			setBrowserTheme(i)
		end
	end

	if source == LinkToChannel then
		local tab = createTab(true)
		showSettings(2)
		loadWebURL(tab, "https://www.youtube.com/c/EasyLuaRus")
	end

	if source == ApplyButton then
		local w, h = tonumber(WidthEdit:getText()), tonumber(HeighEdit:getText())
		if w < 800 then w = 800 end
		if h < 600 then h = 600 end
		if w > Width then w = Width end
		if h > Height then h = Height end

		if w == Width and h == Height then
			setBrowserFullScreened(true)
		else
			setBrowserFullScreened(false, w, h)
		end
	end

	if source == SearchButton then setSearchEngine(SearchEdit:getText()) end

	if source == GoogleEngine then
		setSearchEngine("https://www.google.com/webhp?tab=ww#q=")
		SearchEdit:setText("https://www.google.com/webhp?tab=ww#q=")
	elseif source == YandexEngine then
		setSearchEngine("https://yandex.ru/search/?text=")
		SearchEdit:setText("https://yandex.ru/search/?text=")
	--[[elseif source == BingEngine then
		setSearchEngine("http://www.bing.com/search?q=")
		SearchEdit:setText("http://www.bing.com/search?q=")]]
	end

	if source == MinimalSize then 
		setBrowserFullScreened(false, 800, 600)
	end
	if source == MaximalSize then 
		setBrowserFullScreened(true)
	end

	if source == PageCodes then

		local text = getBrowserURL(guiGetBrowser(getSelectedBrowser()))
		local Frames = StaticWindow.create(200, 200, 300, 300, text ~= "" and text or "about:blank", false)
		Frames:setColorScheme(Theme, "FFFFFF", "FFFFFF")
		local Dividers = GuiStaticImage.create(0, 19, 300, 1, pane, false, Frames.Window)
		Dividers:setProperty("AlwaysOnTop", "True")
		Dividers:setProperty("ImageColours", "tl:FFB61717 tr:FFB61717 bl:FFB61717 br:FFB61717")

		local memo = guiCreateQuadMemo(0, 0, 300, 280, "Empty", false, Frames.Frame)
		memo:setFont(guiCreateFont(Font.OpenSansRegular, 9)) --Шрифтик
		memo:setProperty("NormalTextColour", "FF4F4F4F")
		memo:setProperty("ActiveSelectionColour", "FF"..Theme)
		
		setTimer(function() 
			Frames:open() 
		end, 500, 1)

		--outputDebugString(tostring(Frames))
		
		getBrowserSource(guiGetBrowser(getSelectedBrowser()), function(code)
			if code == "" or code == " " then code = "Empty" end
			memo:setText(code)
		end)

		--[[addEventHandler("onClientStaticWindowFullClosed", root, function(window)
			if window == Frames.Frame then
				destroyElement(memo)
				destroyWindow(Frames.Frame)
			end
		end)]]

		addEventHandler("onClientStaticWindowResize", root, function(window, w, h)
			if window == Frames.Frame then
				guiQuadElementSetSize(memo, w, h-20, false)
			end
		end)
	end
end)

addEventHandler("onClientMouseEnter", root, function()
	if source == ActiveTab then return false end
	if source == MainSettings 
		or source == History 
		or source == About 
		or source == Help 
		or source == ApplyButton
		or source == MinimalSize 
		or source == MaximalSize
		or source == SearchButton
		or source == GoogleEngine
		or source == YandexEngine
		--or source == BingEngine
		or source == PageCodes
			then source:setColor(fromHEXToRGB("8D8D8D")) end

	for i in pairs(Schemes) do
		if source == Schemes[i] then
			Schemes[i]:setProperty("ImageColours", "tl:FF"..Colors[i].Divider.." tr:FF"..Colors[i].Divider.." bl:FF"..Colors[i].Divider.." br:FF"..Colors[i].Divider)
		end
	end
	if source == ClearCache then
		source:setColor(fromHEXToRGB(Theme))
	end

	if source == LinkToChannel then
		source:setAlpha(0.5)
	end
end)
addEventHandler("onClientMouseLeave", root, function()
	MainSettings:setColor(fromHEXToRGB("4F4F4F"))
	History:setColor(fromHEXToRGB("4F4F4F"))
	Help:setColor(fromHEXToRGB("4F4F4F"))
	About:setColor(fromHEXToRGB("4F4F4F")) 
	ActiveTab:setColor(fromHEXToRGB(Theme))
	ApplyButton:setColor(fromHEXToRGB("3F3F3F"))
	MinimalSize:setColor(fromHEXToRGB("3F3F3F"))
	MaximalSize:setColor(fromHEXToRGB("3F3F3F"))
	SearchButton:setColor(fromHEXToRGB("3F3F3F"))
	GoogleEngine:setColor(fromHEXToRGB("3F3F3F"))
	YandexEngine:setColor(fromHEXToRGB("3F3F3F"))
	--BingEngine:setColor(fromHEXToRGB("3F3F3F"))
	PageCodes:setColor(fromHEXToRGB("3F3F3F"))
	ClearCache:setColor(fromHEXToRGB("3F3F3F"))
	LinkToChannel:setAlpha(1)

	for i in pairs(Schemes) do
		Schemes[i]:setProperty("ImageColours", "tl:FF"..Colors[i].Top.." tr:FF"..Colors[i].Top.." bl:FF"..Colors[i].Top.." br:FF"..Colors[i].Top)
	end
end)


function showSettings(num, types)
	local a, b, c, d, e, f = getTitleEdit(), getColorEdit(), getURLEdit(), SearchEdit, WidthEdit, HeighEdit
	local tab = {a,b,c,d,e,f}
	for i in pairs(tab) do
		tab[i]:setVisible(false)
	end

	Animation = num
	if num == 1 then
		if not types then
			getFrameZ():setVisible(false)
			FrontPanel:setVisible(true)
		else
			getFrameZ():setVisible(true)
			FrontPanel:setVisible(false)
		end
	end
end

function getSettsPane()
	return BackGround
end

BackGround:setVisible(false) --Невидим в браузере
BackGround:setAlpha(0) --Невидим для совершения анимации

addEvent("onBrowserChangeSize", true)
addEventHandler("onBrowserChangeSize", root, function(w, h)
	FrontPanel:setPosition(w/2-200, h/2-200, false)
	getFrameZ():setPosition(w/2-150, h/2-90, false)
	WidthEdit:setText(w)
	HeighEdit:setText(h)
end)
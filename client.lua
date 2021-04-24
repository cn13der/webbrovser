local Width, Height = guiGetScreenSize() --Получаем разрешение экрана
local color = "D62727"  --Цветовая тема
local pane = "imgs/pane.png" --Основное изображение
local Icons = { --Иконочки
	Start = "imgs/go.png", --Кнопка отправки на страницу
	Refrs = "imgs/refresh.png", --Кнопка обновления страницы
	Searc = "imgs/find.png", --Кнопка поиска
	Setts = "imgs/setts.png", --Кнопка настроек
	Stops = "imgs/stop.png", --Кнопка остановки загрузки
	But = "imgs/but.png", --Кнопка закрытия вкладки
	ButB = "imgs/butback.png", --И её фон
	Adds = "imgs/add.png", --Кнопка добавить вкладку
	Backs = "imgs/prev.png" --Кнопка вернуться назад
}

local OpenKey = "F3"
local FullScreened = false

local SearchEngine = "https://www.google.com/webhp?tab=ww#q=" --Поисковый сервис

local ColorScheme = {
	Dark = {
		Top = "3F3F3F",
		Main = "4F4F4F",
		Inac = "454545",
		Text = "EEEEEE",
		But = "FFFFFF",
		ButDis = "AAAAAA",
		Divider = "6F6F6F",
		ButEnt = "CCCCCC"
	},
	Light = {
		Top = "DDDDDD",
		Main = "EEEEEE",
		Inac = "DDDDDD",
		Text = "4F4F4F",
		But = "3F3F3F",
		ButDis = "AAAAAA",
		Divider = "CCCCCC",
		ButEnt = "7F7F7F"
	}
}

local DefCol = ColorScheme.Dark --Основной цвет

local DefaultScreenSize = {800, 600} --Основное разрешение экрана, оно может редактироваться, так-же его можно будет в браузере установить в ручную
local PositionsScreen = {}
local SavedSize = {800, 600}

--Создаём окно браузера
local Browser = StaticWindow.create(50, 50, DefaultScreenSize[1], DefaultScreenSize[2], "HUI PIZDA EBU SOBAK", false)
Browser:setColorScheme(DefCol.Top, DefCol.Main, ""..DefCol.Text.."") --Делаем ему цветовую схему
Browser:setTitleHeight(25) --Уменьшаем размер титуля
Browser:setSizable(false) --И делаем неизменяемым в размерах

destroyElement(Browser.Title)

--Титульная часть - на неё помещаются вкладки
local TitleBar = GuiStaticImage.create(0, 0, DefaultScreenSize[1], 25, pane, false, Browser.Window)
TitleBar:setProperty("ImageColours", "tl:FF"..DefCol.Top.." tr:FF"..DefCol.Top.." bl:FF"..DefCol.Top.." br:FF"..DefCol.Top.."")

--Скроллер вкладок
local TabScroll = ScrollMenu.create(31, 0, DefaultScreenSize[1]-31, 25, false, TitleBar)

--Кнопка "Добавить вкладку"
local AddTab = GuiStaticImage.create(0, 0, 23, 25, Icons.Adds, false, TabScroll.Menu)
AddTab:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But.."")

--Преразделитель - ограничитель для кнопок управления окном
local TabPreDiv = GuiStaticImage.create(0, 24, 31, 1, pane, false, TitleBar)
TabPreDiv:setEnabled(false) --Делаем его ненажимаемым
TabPreDiv:setProperty("ImageColours", "tl:FF"..DefCol.Divider.." tr:FF"..DefCol.Divider.." bl:FF"..DefCol.Divider.." br:FF"..DefCol.Divider.."")

--Разделитель между вкладками и панелью управления окном
local TabDiv = GuiStaticImage.create(0, 24, DefaultScreenSize[1], 1, pane, false, TabScroll.Back)
TabDiv:setEnabled(false) --Делаем его ненажимаемым
TabDiv:setProperty("ImageColours", "tl:FF"..DefCol.Divider.." tr:FF"..DefCol.Divider.." bl:FF"..DefCol.Divider.." br:FF"..DefCol.Divider.."")

--Разделитель между кнопкой закрытия и владками
local TabConDiv = GuiStaticImage.create(30, 0, 1, 25, pane, false, TitleBar)
TabConDiv:setEnabled(false) --Делаем его ненажимаемым
TabConDiv:setProperty("ImageColours", "tl:FF"..DefCol.Divider.." tr:FF"..DefCol.Divider.." bl:FF"..DefCol.Divider.." br:FF"..DefCol.Divider.."")

--Панель элементов управления
local ControlElements = GuiStaticImage.create(0, 2, DefaultScreenSize[1], 30, pane, false, Browser.Frame)
ControlElements:setProperty("ImageColours", "tl:FF"..DefCol.Main.." tr:FF"..DefCol.Main.." bl:FF"..DefCol.Main.." br:FF"..DefCol.Main.."")

--Разделитель между браузером и верхней панелью
local ConDiv = GuiStaticImage.create(0, 29, DefaultScreenSize[1], 1, pane, false, ControlElements)
ConDiv:setEnabled(false) --Делаем её недоступной
ConDiv:setProperty("ImageColours", "tl:FF"..DefCol.Divider.." tr:FF"..DefCol.Divider.." bl:FF"..DefCol.Divider.." br:FF"..DefCol.Divider.."")

--Кнопка закрытия браузера
local CloseBrows = GuiStaticImage.create(4, 4, 10, 20, Icons.ButB, false, TitleBar)
CloseBrows:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
local CloseBroTop = GuiStaticImage.create(0, 0, 10, 20, Icons.But, false, CloseBrows)
CloseBroTop:setProperty("ImageColours", "tl:FF"..DefCol.Text.." tr:FF"..DefCol.Text.." bl:FF"..DefCol.Text.." br:FF"..DefCol.Text.."")
--Кнопка Fullscreen
local FulscBrows = GuiStaticImage.create(16, 4, 10, 20, Icons.ButB, false, TitleBar)
FulscBrows:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
local FulscBroTop = GuiStaticImage.create(0, 0, 10, 20, Icons.But, false, FulscBrows)
FulscBroTop:setProperty("ImageColours", "tl:FF"..DefCol.Text.." tr:FF"..DefCol.Text.." bl:FF"..DefCol.Text.." br:FF"..DefCol.Text.."")

addEventHandler("onClientMouseEnter", root, function()
	if source == CloseBroTop then
		CloseBrows:setProperty("ImageColours", "tl:FFD2451F tr:FFD2451F bl:FFD2451F br:FFD2451F")
	elseif source == FulscBroTop then
		if FullScreened then
			FulscBrows:setProperty("ImageColours", "tl:FFCCDD00 tr:FFCCDD00 bl:FFCCDD00 br:FFCCDD00")
		else
			FulscBrows:setProperty("ImageColours", "tl:FF269800 tr:FF269800 bl:FF269800 br:FF269800")
		end
	end
end)
addEventHandler("onClientMouseLeave", root, function()
	CloseBrows:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
	FulscBrows:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
end)

function setBrowserFullScreened(bool, w, h)
	FullScreened = bool
	if bool then
		local ws, hs = Browser:getSize(false)
		Browser:setBorderSize(0)
		changeBrowserSize(Width, Height)
		PositionsScreen = {Browser:getPosition(false)}
		Browser:setPosition(0, 0, false)
		Browser:setMovable(false)
		SavedSize = {ws, hs}
	else
		Browser:setBorderSize(2)
		if w and h then
			changeBrowserSize(w, h)
		else
			changeBrowserSize(SavedSize[1], SavedSize[2])
		end
		Browser:setMovable(true)

		local x, y = Browser:getPosition(false)
		Browser:setPosition(PositionsScreen[1] or x, PositionsScreen[2] or y, false)

		PositionsScreen = {}
	end
end


---- ТИТУЛЬНЫЕ ЭЛЕМЕНТЫ (ПЕРЕХОДЫ, ССЫЛКИ) ----
--Кнопка "на страницу назад"
local PreviousLink = GuiStaticImage.create(0, 1, 23, 25, Icons.Backs, false, ControlElements)
PreviousLink:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But.."")
--Кнопка "на страницу вперёд"
local NextLink = GuiStaticImage.create(23, 1, 23, 25, Icons.Start, false, ControlElements)
NextLink:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But.."")
--Кнопка "обновить страницу"
local ReloadPage = GuiStaticImage.create(46, 1, 23, 25, Icons.Refrs, false, ControlElements)
ReloadPage:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But.."")
--Поле ввода ссылки
--Сначала фон
local LinkBack = GuiStaticImage.create(69, 1, DefaultScreenSize[1]-(23*4), 25, pane, false, ControlElements)
LinkBack:setProperty("ImageColours", "tl:FF"..DefCol.Divider.." tr:FF"..DefCol.Divider.." bl:FF"..DefCol.Divider.." br:FF"..DefCol.Divider.."")
--Затем само поле
local LinkEnter = guiCreateQuadEdit(1, 1, DefaultScreenSize[1]-(23*4) - 2, 23, "home", false, LinkBack)
LinkEnter:setFont(guiCreateFont(Font.OpenSansRegular, 8)) --Шрифтик
LinkEnter:setProperty("NormalTextColour", "FF4F4F4F")
LinkEnter:setProperty("ActiveSelectionColour", "FF"..color)
--Кнопка настроек
local BrowserParams = GuiStaticImage.create(DefaultScreenSize[1]-23, 1, 23, 25, Icons.Setts, false, ControlElements)
BrowserParams:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But.."")
--Кнопка поиска
local SearchBut = GuiStaticImage.create(DefaultScreenSize[1]-(23*5), -2, 23, 25, Icons.Searc, false, LinkEnter)
SearchBut:setProperty("ImageColours", "tl:FF4F4F4F tr:FF4F4F4F bl:FF4F4F4F br:FF4F4F4F")

local Tabs = {} --Таблица информации о всех вкладках
local SelectedTab = 1 --Выбранная вкладка, чтобы производить ключевые манипуляции

function setSearchEngine(web)
	SearchEngine = web
end
function getSearchEngine() return SearchEngine end

--Функция для поиска через строку ввода
function search()
	if LinkEnter:getText():find("%.") then
		if LinkEnter:getText():find("http://") 
			or LinkEnter:getText():find("https://")
			or LinkEnter:getText():find("url://")
			or LinkEnter:getText():find("local://")
			or LinkEnter:getText():find("mta://") then
				Tabs[SelectedTab].Link = LinkEnter:getText()
		else		
			Tabs[SelectedTab].Link = "http://"..LinkEnter:getText() 
		end
		loadWebURL(SelectedTab, Tabs[SelectedTab].Link)
	--[[elseif LinkEnter:getText() == "google.com" 
		or LinkEnter:getText() == "http://google.com" 
		or LinkEnter:getText() == "http://google.com/" 
		or LinkEnter:getText() == "https://google.com" 
		or LinkEnter:getText() == "https://google.com/" 
		or LinkEnter:getText() == "google" then
			Tabs[SelectedTab].Link = "http://google.com/ncr"
			loadWebURL(SelectedTab, "http://google.com/ncr")]]
	else
		Tabs[SelectedTab].Link = SearchEngine..LinkEnter:getText()
		loadWebURL(SelectedTab, Tabs[SelectedTab].Link)
	end
	--outputDebugString(Tabs[SelectedTab].Link)
end

addEventHandler("onClientMouseEnter", root, function()
	if source == PreviousLink 
		or source == NextLink 
		or source == ReloadPage
		or source == AddTab
		or source == BrowserParams
		then 
			source:setProperty("ImageColours", "tl:FF"..DefCol.ButEnt.." tr:FF"..DefCol.ButEnt.." bl:FF"..DefCol.ButEnt.." br:FF"..DefCol.ButEnt)
	end
end)

addEventHandler("onClientMouseLeave", root, function()
	if PreviousLink:getEnabled() then 
		PreviousLink:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But)
	else
		PreviousLink:setProperty("ImageColours", "tl:FF"..DefCol.ButDis.." tr:FF"..DefCol.ButDis.." bl:FF"..DefCol.ButDis.." br:FF"..DefCol.ButDis)
	end
	if NextLink:getEnabled() then 
		NextLink:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But)
	else
		NextLink:setProperty("ImageColours", "tl:FF"..DefCol.ButDis.." tr:FF"..DefCol.ButDis.." bl:FF"..DefCol.ButDis.." br:FF"..DefCol.ButDis)
	end
	if ReloadPage:getEnabled() then 
		ReloadPage:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But)
	else
		ReloadPage:setProperty("ImageColours", "tl:FF"..DefCol.ButDis.." tr:FF"..DefCol.ButDis.." bl:FF"..DefCol.ButDis.." br:FF"..DefCol.ButDis)
	end
	AddTab:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But)
	BrowserParams:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But)
end)


addEventHandler("onClientGUIClick", root, function()
	if source == AddTab then --Если нажата кнопка новой вкладки
		createTab(true) --Открыть новую вкладку
	end

	if source == SearchBut then --Если нажата кнопка поиска
		search() --То искать
	end

	if source == PreviousLink then
		if Tabs[SelectedTab].Position < 1 then return false end
		Tabs[SelectedTab].Position = Tabs[SelectedTab].Position - 1

		if Tabs[SelectedTab].Position <= 1 then setButtonEnabled(PreviousLink, false)
		else setButtonEnabled(PreviousLink, true) end

		loadBrowserURL(guiGetBrowser(Tabs[SelectedTab].Browser), Tabs[SelectedTab].Cache[Tabs[SelectedTab].Position], false)
	end

	if source == NextLink then
		if Tabs[SelectedTab].Position > #Tabs[SelectedTab].Cache then return false end
		Tabs[SelectedTab].Position = Tabs[SelectedTab].Position + 1

		if Tabs[SelectedTab].Position >= #Tabs[SelectedTab].Cache then setButtonEnabled(NextLink, false)
		else setButtonEnabled(NextLink, true) end

		loadBrowserURL(Tabs[SelectedTab].Browser, Tabs[SelectedTab].Cache[Tabs[SelectedTab].Position], false)
	end

	if source == ReloadPage then
		if getBrowserURL(guiGetBrowser(Tabs[SelectedTab].Browser)) == "" then setButtonEnabled(ReloadPage, false) 
		else setButtonEnabled(ReloadPage, true) end
		setBrowserRenderingPaused(guiGetBrowser(Tabs[id].Browser), false)
		if Tabs[SelectedTab].Type == "Refresh" then loadBrowserURL(Tabs[SelectedTab].Browser, getBrowserURL(guiGetBrowser(Tabs[SelectedTab].Browser)), false)
		else guiStaticImageLoadImage(ReloadPage, Icons.Refrs) setBrowserRenderingPaused(guiGetBrowser(Tabs[id].Browser), true) end
	end

	if source == BrowserParams then showSettings(1) end

	if source == CloseBroTop then Browser:close() showCursor(false) end
	if source == FulscBroTop then setBrowserFullScreened(not FullScreened) end
end)
addEventHandler("onClientGUIAccepted", root, function()
	if source == LinkEnter then search() end --Если нажат энтер у поля ввода ссылки, то начать поиск
end)

addEventHandler("onClientStaticWindowFullClosed", root, function(window)
	if window == Browser then showCursor(false) end
end)

addEventHandler("onClientGUIDoubleClick", root, function()
	if source == TitleBar or source == TabScroll.Menu then
		setBrowserFullScreened(not FullScreened)
	end
end)


--Функция для изменения размера браузера
function changeBrowserSize(w, h)
	Browser:setSize(w, h, false, true) --Для браузера
	TitleBar:setSize(w, 25, false) --Для титуля вкладок
	TabScroll:setSize(w-31, 25, false) --Для их скроллера
	TabDiv:setSize(w, 1, false) --Для разделителя
	ControlElements:setSize(w, 30, false) --Для панели браузера
	ConDiv:setSize(w, 1, false) --И её разделителя
	LinkBack:setSize(w-(23*4), 25, false) --Для фона поля ввода сылки
	--LinkEnter:setSize(w-(23*4) - 2, 23, false) --И для самого поля
	guiQuadElementSetSize(LinkEnter, w-(23*4) - 2, 23, false) --Вот для поля
	BrowserParams:setPosition(w-23, 1, false) --И новые позиции для параметров
	SearchBut:setPosition(w-(23*5), -2, false) --А так-же для кнопки поиска

	DefaultScreenSize = {w, h}

	setHomeSize(w, h)

	triggerEvent("onBrowserChangeSize", localPlayer, w, h)

	for id in pairs(Tabs) do
		if not Tabs[id].Closed then
			local url = getBrowserURL(guiGetBrowser(Tabs[id].Browser))
			destroyElement(Tabs[id].Browser)
			Tabs[id].Browser = GuiBrowser.create(0, 32, w, h-42, false, false, false, Browser.Frame)
			--Tabs[id].Browser:setProperty("AlwaysOnTop", "True")
			--Tabs[id].Browser:setVisible(false)
			loadWebURL(id, url, false)
			bringFront()
		end
	end

	if not Tabs[SelectedTab].Closed then
		Tabs[SelectedTab].Browser:setVisible(true)
	end
end

--Создание вкладки
function createTab(active) --Аргумент отвечает за активную вкладку (после открытия переключиться на неё)
	local id = #Tabs+1 --Идентификатор вкладки
	Tabs[id] = { --Создаём ему параметры
		Link = "", --Ссылка, актуальная на вкладке на данный момент
		Closed = false, --Закрыта ли вкладка
		Cache = {}, --Кеш страниц этой вкладки
		Position = 0, --Позиция страницы в кеше
		Type = "Refresh", --Тип загрузки страницы
		SaveInCache = true
	}

	local OpenedTabs = getNumberOpenedTabs() --Получить номер открытых вкладок

	--Сама вкладка
	Tabs[id].Back = GuiStaticImage.create(120*(OpenedTabs-1), 0, 120, 25, pane, false, TabScroll.Menu)
	--Её задняя часть, типа окантовки
	Tabs[id].Back:setProperty("ImageColours", "tl:FF"..DefCol.Divider.." tr:FF"..DefCol.Divider.." bl:FF"..DefCol.Divider.." br:FF"..DefCol.Divider.."")
	AddTab:setPosition(120*OpenedTabs, 0, false) --После создания сразу кнопку новой вкладки смещаем вправо

	ConDiv:setVisible(false)
	TabConDiv:setVisible(true)
	--И переносим вкладку на передний план
	Tabs[id].Back:bringToFront()

	--Создаём поверхность вкладки - собственно то, что окантовывается
	Tabs[id].Top = GuiStaticImage.create(0, 0, 119, 24, pane, false, Tabs[id].Back)
	Tabs[id].Top:setProperty("ImageColours", "tl:FF"..DefCol.Inac.." tr:FF"..DefCol.Inac.." bl:FF"..DefCol.Inac.." br:FF"..DefCol.Inac.."")
	Browser:setMoveElement(Tabs[id].Top)

	--Работаем со скроллером вкладок
	TabScroll:addElement(Tabs[id].Back) --Добавляем окантовку в скроллер
	--TabScroll:addScrollElement(Tabs[id].Top, "x") --Делаем верхушку вкладки сенсорной по оси X, для того, чтобы скроллить
	TabScroll:addElement(AddTab) --И добавляем в скроллер обязательно кнопку добавления вкладки

	--Титуль для вкладки
	Tabs[id].Title = GuiLabel.create(16, 0, 118-16, 20, "New Tab", false, Tabs[id].Top)
	Tabs[id].Title:setFont(guiCreateFont(Font.SegoeUIRegular, 9)) --Шрифтик
	Tabs[id].Title:setVerticalAlign("center") --Вертикаль
	Tabs[id].Title:setColor(fromHEXToRGB(DefCol.Text))
	Tabs[id].Title:setEnabled(false) --Доступность к нажатию - не нужна
	if active then bringFront() end

	--Кнопка закрытия вкладки
	Tabs[id].CloseBack = GuiStaticImage.create(3, 4, 10, 20, Icons.ButB, false, Tabs[id].Top)
	Tabs[id].CloseBack:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
	Tabs[id].Close = GuiStaticImage.create(0, 0, 10, 20, Icons.But, false, Tabs[id].CloseBack)
	Tabs[id].Close:setProperty("ImageColours", "tl:FF"..DefCol.Text.." tr:FF"..DefCol.Text.." bl:FF"..DefCol.Text.." br:FF"..DefCol.Text.."")

	addEventHandler("onClientMouseEnter", root, function()
		if not Tabs[id].Closed then
			if source == Tabs[id].Close then
				Tabs[id].CloseBack:setProperty("ImageColours", "tl:FFD2451F tr:FFD2451F bl:FFD2451F br:FFD2451F")
			end
		end
	end)
	addEventHandler("onClientMouseLeave", root, function()
		if not Tabs[id].Closed then
			Tabs[id].CloseBack:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")
		end
	end)

	--Здесь создаётся браузерный элемент самого браузера
	Tabs[id].Browser = GuiBrowser.create(0, 32, DefaultScreenSize[1], DefaultScreenSize[2], false, false, false, Browser.Frame)
	--Tabs[id].Browser:setProperty("AlwaysOnTop", "True")
	--Tabs[id].Browser:setVisible(false)

	--Событие по нажатию на вкладку

	addEventHandler("onClientGUIDoubleClick", root, function()
		if source == Tabs[id].Top then
			setBrowserFullScreened(not FullScreened)
		end
	end)
	addEventHandler("onClientGUIClick", root, function(but)
		if source == Tabs[id].Top then --Если нажата вкладка
			for i in pairs(Tabs) do --То циклим вкладки для уменьшения их размера, чтобы вкладка была не выделена
				if Tabs[i].Top ~= nil and isElement(Tabs[i].Top) then --Если такая вкладка существует
					Tabs[i].Top:setSize(119, 24, false) --То изменить размер
					Tabs[i].Top:setProperty("ImageColours", "tl:FF"..DefCol.Inac.." tr:FF"..DefCol.Inac.." bl:FF"..DefCol.Inac.." br:FF"..DefCol.Inac.."")
					Tabs[i].Browser:setVisible(false) --И скрыть браузер
				end
			end
			Tabs[id].Top:setSize(119, 25, false) --Убираем границу между вкладкой и панелью страницы
			Tabs[id].Top:setProperty("ImageColours", "tl:FF"..DefCol.Main.." tr:FF"..DefCol.Main.." bl:FF"..DefCol.Main.." br:FF"..DefCol.Main.."")
			Tabs[id].Browser:bringToFront() --Переносим браузер этой вкладки на передний фон
			Tabs[id].Browser:setVisible(true) --И делаем его видимым
			SelectedTab = id --Делаем выбранную вкладку нажатой
			local text = getBrowserURL(guiGetBrowser(Tabs[id].Browser)) --Получим ссылку браузера данной вкладки
			LinkEnter:setText(text ~= "" and text or Tabs[id].Link or "about:blank") --Установить текст полю ввода ссылки
			if text == "" or text == "about:blank" then 
				ConDiv:setVisible(false)
				bringFront()
				--Tabs[id].Browser:setVisible(false)
			else
				ConDiv:setVisible(true)
			end

			--Для позиционирования
			local x1, fz = TabScroll.Menu:getPosition(false)
			local ax = TabScroll.Back:getSize(false)
			local ay = TabScroll.Menu:getSize(false)
			local x2 = Tabs[id].Back:getPosition(false)

			if x2-x1+120+23 > ax then x1 = (ax-(x2-x1))-120-23 end
			if x2-math.abs(x1) < 0 then x1 = -x2 end
			--outputDebugString("id: "..id.."; "..x2-x1.." ")
			TabScroll.Menu:setPosition(x1, fz, false)

			--Работаем с кешэм
			if Tabs[id].Position >= #Tabs[id].Cache then setButtonEnabled(NextLink, false)
			else setButtonEnabled(NextLink, true) end

			if Tabs[id].Position <= 1 then setButtonEnabled(PreviousLink, false)
			else setButtonEnabled(PreviousLink, true) end

			if text == "" then setButtonEnabled(ReloadPage, false) 
			else setButtonEnabled(ReloadPage, true) end


			if Tabs[id].Type == "Refresh" then --Если страница полностью загружена
				guiStaticImageLoadImage(ReloadPage, Icons.Refrs) --То кнопка будет иметь иконку обновления
			else
				guiStaticImageLoadImage(ReloadPage, Icons.Stops) --Иначе иконку крестика				
			end
		end
		if source == Tabs[id].Close then closeTab(id) end --Если это кнопка закрытия вкладки, то мы её закрываем
		if source == Tabs[id].Browser then Tabs[id].SaveInCache = true end --Делаем сохранялку кеша

		if but == "middle" then --По нажатию средней кнопки мыши
			if source == Tabs[id].Top then --На вкладке
				closeTab(id) --Она закрывается
			end
		end
	end)

	addEventHandler("onClientMouseWheel", root, function(num)
		local u = true
		if source ~= Tabs[id].Top then return false end
		if num == 1 then
			for i = SelectedTab+1, #Tabs do
				if u then
					if not Tabs[i].Closed then
						u = false
						triggerEvent("onClientGUIClick", Tabs[i].Top)
					end
				else break end
			end
		else
			for i = SelectedTab-1, 1, -1 do
				if u then
					if not Tabs[i].Closed then
						u = false
						triggerEvent("onClientGUIClick", Tabs[i].Top)
					end
				else break end
			end
		end
	end)

	--Когда ссылка загружена
	addEventHandler("onClientBrowserDocumentReady", root, function(url)
		if not isElement(Tabs[id].Browser) then return false end
		if source == guiGetBrowser(Tabs[id].Browser) then --Если загрузилась в определённом браузере
			Tabs[id].Type = "Refresh" --То делаем для этого браузера тип "обновлено"
			if SelectedTab == id then --Если выбраный браузер находится в выбраной вкладке
				guiStaticImageLoadImage(ReloadPage, Icons.Refrs) --То и иконочку сразу поменяем
				LinkEnter:setText(url) --И в поле ввода установим ссылку
			end

			local text = getBrowserURL(guiGetBrowser(Tabs[id].Browser)) --Получим ссылку браузера данной вкладки
			Tabs[id].Title:setText(getBrowserTitle(guiGetBrowser(Tabs[id].Browser))) --Обновим титуль
			if SelectedTab == id then
				LinkEnter:setText(url) --И поле ввода
				Tabs[id].Browser:bringToFront()
				Tabs[id].Browser:setVisible(true)
			end
		end
	end)

	--Когда ссылка начала грузиться
	addEventHandler("onClientBrowserLoadingStart", root, function()
		if not isElement(Tabs[id].Browser) then return false end
		if source == guiGetBrowser(Tabs[id].Browser) then --В том же браузере
			Tabs[id].Type = "Load" --Делаем ему статус "загружается"
			local text = getBrowserURL(guiGetBrowser(Tabs[id].Browser)) --Получим ссылку браузера данной вкладки

			if id == SelectedTab then
				if Tabs[id].Position >= #Tabs[id].Cache then setButtonEnabled(NextLink, false)
				else setButtonEnabled(NextLink, true) end

				if Tabs[id].Position <= 1 then setButtonEnabled(PreviousLink, false)
				else setButtonEnabled(PreviousLink, true) end

				if text == "" then setButtonEnabled(ReloadPage, false) 
				else setButtonEnabled(ReloadPage, true) end
			end

			if Tabs[id].SaveInCache then
				table.insert(Tabs[id].Cache, getBrowserURL(guiGetBrowser(Tabs[id].Browser))) --Заносим в таблицу кэша данную вкладку
				Tabs[id].Position = Tabs[id].Position+1 --Обновляем позиции страницы
				Tabs[id].Link = getBrowserURL(guiGetBrowser(Tabs[id].Browser)) --И ссылочку тоже обновим
			end

			if SelectedTab == id then --Если это в выбраной вкладке
				guiStaticImageLoadImage(ReloadPage, Icons.Stops) --То здесь же и обновляем иконку
				LinkEnter:setText(getBrowserURL(guiGetBrowser(Tabs[id].Browser))) --И в поле ввода установим ссылку
				Tabs[id].Browser:bringToFront()
				Tabs[id].Browser:setVisible(true)
			end
			Tabs[id].Title:setText(getBrowserURL(guiGetBrowser(Tabs[id].Browser))) --И титуль
		end
	end)

	if active then --Если аргумент активной вкладки есть
		setSelectionTab(id) --Делаем созданную вкладку активной 
	end

	return id --Вернём ID вкладки
end
--Функция получения количества открытых вкладок
function getNumberOpenedTabs()
	local Opened = 0 --Количество
	for i in pairs(Tabs) do --Цикл всех вкладок
		if Tabs[i].Closed == false then Opened = Opened+1 end --Если параметр closed у вкладки не правдив, то добавляем к количеству 1, считая что эта вкладка открыта
	end
	return Opened --Возвращаем количество
end
--Функция получения первой активной вкладки
function getFirstTab()
	local ThatTab = 0 --Первая вкладка
	for i in pairs(Tabs) do --Цикл всех вкладок
		if Tabs[i].Closed == false then ThatTab = i break end --Если параметр closed у вкладки не правдив, то это первая вкладка, и закрываем цикл
	end
	return ThatTab --Возвращаем номер вкладки
end
--Функция для активации выбранной вкладки
function setSelectionTab(id)
	if id == 0 then return false end --Если вкладка нулевая (не существующая), то не делать ничего
	triggerEvent("onClientGUIClick", Tabs[id].Top) --Отправляем на эту вкладку событие нажатия
end

--Функция закрытия вкладки
function closeTab(id) --По идентификатору
	Tabs[id].Closed = true --Делаем этой вкладке параметр закрытости положительным
	--Tabs[id].Browser:setVisible(false)
	--Tabs[id].Back:setVisible(false)
	--setBrowserRenderingPaused(guiGetBrowser(Tabs[id].Browser), true)
	
	destroyElement(Tabs[id].Browser)
	destroyElement(Tabs[id].Back)

	local x, n = 0, 0 --Координата и количество вкладок
	for i in pairs(Tabs) do --Циклим вкладки
		if Tabs[i].Closed == false then --Если вкладка не закрыта
			n = n + 1 --Добавляем номер вкладки
			x = 120*(n-1) --Считаем координату
			Tabs[i].Back:setPosition(x, 0, false) --Обновляем положение вкладкам
		end
	end
	AddTab:setPosition(120*n, 0, false) --Ставим кнопку создания вкладки рядом
	if n == 0 then
		TabConDiv:setVisible(false)
		TabScroll.Menu:setPosition(0, 0, false)	
	end
	local w = 120*n+23 --Размер скроллера
	if w < DefaultScreenSize[1]-20 then w = DefaultScreenSize[1]-20 end 
	TabScroll.Menu:setSize(w, 25, false) --И уменьшаем размер размер скроллера
	setSelectionTab(getFirstTab()) --После закрытия открываем первую вкладку
end

--Горячие клавиши
--[[addEventHandler("onClientKey", root, function(key, press)
	if Browser.Back:getVisible() then --Если браузер виден
		if getKeyState("lctrl") then --То если мы зажимаем левый контрол
			if key == "n" and not press then --И нажимаем клавишу N (New)
				createTab(true) --Мы создаём новую вкладку
			end
		end
	end
end)]]
bindKey("n", "down", function()
	if Browser.Back:getVisible() then --Если браузер виден
		if getKeyState("lctrl") then --То если мы зажимаем левый контрол
			createTab(true) --Мы создаём новую вкладку
		end
	end
end)

--Функция загрузки URL в браузере
function loadWebURL(id, url, bool, ...) --Основные параметры
	if Tabs[id] then --Если таблица этой вкладки существует
		if Tabs[id].Closed == false then --Если вкладка не закрыта
			if url == "about:blank" or url == "home" then --Если выбираемая страница является домашней (пустой)
				--TODO открытие вкладки пустой
			else
				Tabs[id].SaveInCache = bool and true or false
				loadBrowserURL(guiGetBrowser(Tabs[id].Browser), url, ...) --Иначе загружаем владочному браузеру страницу
				if url ~= "" and url ~= "about:blank" then ConDiv:setVisible(true) end --И делаем дивайдер видимым
			end
		end
	else --Иначе, если такого параметра нет в таблице вкладок
		loadBrowserURL(id, url, ...) --То делаем обычную загрузку
	end
end

--Функция для того, чтобы кнопка была заблокирована
function setButtonEnabled(but, bool)
	if bool then --При разблокировке ставим светлый цвет и делаем доступной к нажатию
		but:setProperty("ImageColours", "tl:FF"..DefCol.But.." tr:FF"..DefCol.But.." bl:FF"..DefCol.But.." br:FF"..DefCol.But.."")
		but:setEnabled(true)
	else --И наоборот
		but:setProperty("ImageColours", "tl:BB"..DefCol.ButDis.." tr:BB"..DefCol.ButDis.." bl:BB"..DefCol.ButDis.." br:BB"..DefCol.ButDis.."")
		but:setEnabled(false)
	end
end

--Сделаем основные клавиши недоступными
addEventHandler("onClientResourceStart", root, function(res)
	if res ~= getThisResource() then return false end
	setButtonEnabled(PreviousLink, false)
	setButtonEnabled(NextLink, false)
	setButtonEnabled(ReloadPage, false)
	createTab(true)
	setBrowserTheme("Dark")
end)

--Функция для получения таблицы окна браузера (frame, title, etc)
function getBrowser() return Browser end


function setBrowserTheme(type)
	local Var = ColorScheme[type]
	if not Var then return false end

	DefCol = Var

	Browser:setColorScheme(Var.Top, Var.Main, Var.Text) 
	TitleBar:setProperty("ImageColours", "tl:FF"..Var.Top.." tr:FF"..Var.Top.." bl:FF"..Var.Top.." br:FF"..Var.Top.."")
	AddTab:setProperty("ImageColours", "tl:FF"..Var.But.." tr:FF"..Var.But.." bl:FF"..Var.But.." br:FF"..Var.But.."")
	TabDiv:setProperty("ImageColours", "tl:FF"..Var.Divider.." tr:FF"..Var.Divider.." bl:FF"..Var.Divider.." br:FF"..Var.Divider.."")
	TabPreDiv:setProperty("ImageColours", "tl:FF"..Var.Divider.." tr:FF"..Var.Divider.." bl:FF"..Var.Divider.." br:FF"..Var.Divider.."")
	ControlElements:setProperty("ImageColours", "tl:FF"..Var.Main.." tr:FF"..Var.Main.." bl:FF"..Var.Main.." br:FF"..Var.Main.."")
	ConDiv:setProperty("ImageColours", "tl:FF"..Var.Divider.." tr:FF"..Var.Divider.." bl:FF"..Var.Divider.." br:FF"..Var.Divider.."")
	TabConDiv:setProperty("ImageColours", "tl:FF"..Var.Divider.." tr:FF"..Var.Divider.." bl:FF"..Var.Divider.." br:FF"..Var.Divider.."")
	CloseBroTop:setProperty("ImageColours", "tl:FF"..Var.Text.." tr:FF"..Var.Text.." bl:FF"..Var.Text.." br:FF"..Var.Text.."")
	FulscBroTop:setProperty("ImageColours", "tl:FF"..Var.Text.." tr:FF"..Var.Text.." bl:FF"..Var.Text.." br:FF"..Var.Text.."")
	changeHomeTheme(Var.Text)

	LinkBack:setProperty("ImageColours", "tl:FF"..Var.Divider.." tr:FF"..Var.Divider.." bl:FF"..Var.Divider.." br:FF"..Var.Divider.."")
	BrowserParams:setProperty("ImageColours", "tl:FF"..Var.But.." tr:FF"..Var.But.." bl:FF"..Var.But.." br:FF"..Var.But.."")

	if PreviousLink:getEnabled() then
		PreviousLink:setProperty("ImageColours", "tl:FF"..Var.But.." tr:FF"..Var.But.." bl:FF"..Var.But.." br:FF"..Var.But.."")
	else
		PreviousLink:setProperty("ImageColours", "tl:FF"..Var.ButDis.." tr:FF"..Var.ButDis.." bl:FF"..Var.ButDis.." br:FF"..Var.ButDis.."")
	end
	if NextLink:getEnabled() then
		NextLink:setProperty("ImageColours", "tl:FF"..Var.But.." tr:FF"..Var.But.." bl:FF"..Var.But.." br:FF"..Var.But.."")
	else
		NextLink:setProperty("ImageColours", "tl:FF"..Var.ButDis.." tr:FF"..Var.ButDis.." bl:FF"..Var.ButDis.." br:FF"..Var.ButDis.."")
	end
	if ReloadPage:getEnabled() then
		ReloadPage:setProperty("ImageColours", "tl:FF"..Var.But.." tr:FF"..Var.But.." bl:FF"..Var.But.." br:FF"..Var.But.."")
	else
		ReloadPage:setProperty("ImageColours", "tl:FF"..Var.ButDis.." tr:FF"..Var.ButDis.." bl:FF"..Var.ButDis.." br:FF"..Var.ButDis.."")
	end

	for id in pairs(Tabs) do
		if not Tabs[id].Closed then
			Tabs[id].Back:setProperty("ImageColours", "tl:FF"..Var.Divider.." tr:FF"..Var.Divider.." bl:FF"..Var.Divider.." br:FF"..Var.Divider)
			if id ~= SelectedTab then
				Tabs[id].Top:setProperty("ImageColours", "tl:FF"..Var.Inac.." tr:FF"..Var.Inac.." bl:FF"..Var.Inac.." br:FF"..Var.Inac)
			else
				Tabs[id].Top:setProperty("ImageColours", "tl:FF"..Var.Main.." tr:FF"..Var.Main.." bl:FF"..Var.Main.." br:FF"..Var.Main.."")
			end
			Tabs[id].Title:setColor(fromHEXToRGB(Var.Text))
			Tabs[id].Close:setProperty("ImageColours", "tl:FF"..Var.Text.." tr:FF"..Var.Text.." bl:FF"..Var.Text.." br:FF"..Var.Text.."")
		end
	end
end


bindKey(OpenKey, "down", function() Browser:oc() showCursor(not Browser.Back:getVisible()) end)

addCommandHandler("browser", function() Browser:oc() showCursor(not Browser.Back:getVisible()) end)
--Browser:close(true)

function getColors() return ColorScheme end
function getSizes() return DefaultScreenSize end
function getSelectedBrowser() return Tabs[SelectedTab].Browser end
function getSelectedTab() return SelectedTab end
function getKey() return OpenKey end
Browser:setMoveElement(TabScroll.Menu) --Добавляем окну элементы перемещения
Browser:setMoveElement(Browser.BackTitle) --Добавляем окну элементы перемещения
Browser:setMoveElement(TitleBar) --Добавляем окну элементы перемещения
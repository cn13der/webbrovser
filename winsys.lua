local Width, Height = guiGetScreenSize()
local Windows = {}

local winid = 0

local main = "imgs/"
local fonr = "fonts/"

function createStaticWindow(x, y, w, h, title, rel, parent)

	--Function what create static window

	winid = winid+1 --Add window ID
	local id = winid --Create local ID for windows without error
	x = tonumber(x) or 0
	y = tonumber(y) or 0
	w = tonumber(w) and tonumber(w) >= 100 and tonumber(w) or 100
	h = tonumber(h) and tonumber(h) >= 50 and tonumber(h) or 50
	if rel and w>2 then rel = not rel end 

	Windows[id]={} --For Window array make other additions
	if rel then w, h = w*Width, h*Height end

	Windows[id]["Border"] = 2
	local Ramka = Windows[id]["Border"]
	local BB = math.floor(Ramka/2)

	Windows[id]["WinBack"] = GuiStaticImage.create(x-Ramka, y-Ramka, w+(Ramka*2), h+(Ramka*2), main.."pane.png", false, parent)
	Windows[id]["WinBack"]:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000") 
	
	Windows[id]["CentralBack"] = GuiStaticImage.create(BB, BB, w+(Ramka*2)-(BB*2), h+(Ramka*2)-(BB*2), main.."pane.png", false, Windows[id]["WinBack"])
	Windows[id]["CentralBack"]:setEnabled(false)
	Windows[id]["CentralBack"]:setProperty("ImageColours", "tl:20000000 tr:20000000 bl:20000000 br:20000000") 
	Windows[id]["CentralHorizont"] = GuiStaticImage.create(0, Ramka, w+(Ramka*2), h, main.."pane.png", false, Windows[id]["WinBack"])
	Windows[id]["CentralHorizont"]:setEnabled(false)
	Windows[id]["CentralHorizont"]:setProperty("ImageColours", "tl:12000000 tr:12000000 bl:12000000 br:12000000") 
	Windows[id]["CentralVertical"] = GuiStaticImage.create(Ramka, 0, w, h+(Ramka*2), main.."pane.png", false, Windows[id]["WinBack"])
	Windows[id]["CentralVertical"]:setEnabled(false)
	Windows[id]["CentralVertical"]:setProperty("ImageColours", "tl:12000000 tr:12000000 bl:12000000 br:12000000")

	Windows[id]["Window"] = GuiStaticImage.create(Ramka, Ramka, w, h, main.."pane.png", false, Windows[id]["WinBack"]) --Load background of window
	Windows[id]["Window"]:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000") 
	Windows[id]["Window"]:setProperty("AlwaysOnTop", "True")
	local w1, h1 = Width, Height
	if isElement(parent) then w1, h1 = parent:getSize(false) end

	Windows[id]["MoveElement"] = {}

	Windows[id]["MinSize"] = {w, h} --Setting window minimal size
	Windows[id]["MaxSize"] = {w1, h1} --Setting window maximal size

	Windows[id]["BackTitle"] = GuiStaticImage.create(0, 0, w, 20, main.."pane.png", rel, Windows[id]["Window"]) --Load background of titlebar
	Windows[id]["BackTitle"]:setProperty("ImageColours", "tl:FFEEEEEE tr:FFEEEEEE bl:FFEEEEEE br:FFEEEEEE") 
	Windows[id]["Title"] = GuiLabel.create(0, 0, w, 18, tostring(title), false, Windows[id]["BackTitle"]) --Create titlebar of window
	Windows[id]["Title"]:setHorizontalAlign("center")
	--Windows[id]["Title"]:setVerticalAlign("center")
	Windows[id]["Title"]:setFont(GuiFont.create(fonr.."OSR.ttf", 8))
	local r, g, b = fromHEXToRGB("333333")
	Windows[id]["Title"]:setColor(r, g, b)
	Windows[id]["Title"]:setProperty("AlwaysOnTop", "True")
	

	Windows[id]["FullscreenBack"] = GuiStaticImage.create(18, 0, 10, 20, main.."butback.png", false, Windows[id]["Title"]) --Create fullscreen backgroung of button on titlebar
	Windows[id]["Fullscreen"] = GuiStaticImage.create(0, 0, 10, 20, main.."but.png",false, Windows[id]["FullscreenBack"]) --Create fullscreen clickable element
	Windows[id]["FullscreenBack"]:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000") 
	Windows[id]["Fullscreen"]:setProperty("ImageColours", "tl:FF333333 tr:FF333333 bl:FF333333 br:FF333333") 

	Windows[id]["CloseBack"] = GuiStaticImage.create(6, 0, 10, 20, main.."butback.png", false, Windows[id]["Title"]) --Create backgroung of back button on titlebar
	Windows[id]["Close"] = GuiStaticImage.create(0, 0, 10, 20, main.."but.png",   false,   Windows[id]["CloseBack"]) --Create back clickable button
	Windows[id]["CloseBack"]:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000") 
	Windows[id]["Close"]:setProperty("ImageColours", "tl:FF333333 tr:FF333333 bl:FF333333 br:FF333333") 


	Windows[id]["Frame"] = GuiStaticImage.create(0, 20, w, h-20, main.."pane.png", false, Windows[id]["Window"]) --Create frame of window
	Windows[id]["Frame"]:setProperty("ImageColours", "tl:FFEEEEEE tr:FFEEEEEE bl:FFEEEEEE br:FFEEEEEE") 
	local thisWindow = Windows[id]["WinBack"] 
	local thisFrame = Windows[id]["Frame"]

	Windows[id]["Resizer"] = {}
	Windows[id]["Resizer"][1] = GuiStaticImage.create(0, 0, 3, h-20-3, main.."pane.png", false, Windows[id]["Frame"])
	Windows[id]["Resizer"][2] = GuiStaticImage.create(0, h-20-3, 3, 3, main.."pane.png", false, Windows[id]["Frame"])
	Windows[id]["Resizer"][3] = GuiStaticImage.create(3, h-20-3, w-6, 3, main.."pane.png", false, Windows[id]["Frame"])
	Windows[id]["Resizer"][4] = GuiStaticImage.create(w-3, h-20-3, 3, 3, main.."pane.png", false, Windows[id]["Frame"])
	Windows[id]["Resizer"][5] = GuiStaticImage.create(w-3, 0, 3, h-20-3, main.."pane.png", false, Windows[id]["Frame"])
	for i in pairs(Windows[id]["Resizer"]) do 
		Windows[id]["Resizer"][i]:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000") 
		Windows[id]["Resizer"][i]:setProperty("AlwaysOnTop", "True")
	end --Set resizers invisible and on top


	Windows[id]["Fullscreened"] = false --Set variable, when window non-fullscreened if created

	Windows[id]["Movable"] = true --Set window movable
	Windows[id]["Resizable"] = true --Set window sizable

	--Animated variables (for render event)
	Windows[id]["AnimateClose"] = false
	Windows[id]["AnimateOpen"] = false
	Windows[id]["AnimateFullscreen"] = false



	--Add events when mouse enter and leaving from buttons
	addEventHandler("onClientMouseEnter", root, function()

		if source == Windows[id]["Fullscreen"] then
			local FF = "FFCCDD00" --If window fullscreened set its button orange
			--if not Windows[id]["Fullscreened"] then FF = "FF269800" end --If window not fullscreened set its button green
			Windows[id]["FullscreenBack"]:setProperty("ImageColours", "tl:"..FF.." tr:"..FF.." bl:"..FF.." br:"..FF) --When enter, set button color
		end

		if source == Windows[id]["Close"] then
			Windows[id]["CloseBack"]:setProperty("ImageColours", "tl:FFD2451F tr:FFD2451F bl:FFD2451F br:FFD2451F") --When enter, set button color
		end

	end)

	addEventHandler("onClientMouseLeave", root, function()

		if source == Windows[id]["Fullscreen"] then
			Windows[id]["FullscreenBack"]:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000") --When leave, reset button color
		end

		if source == Windows[id]["Close"] then
			Windows[id]["CloseBack"]:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000") --When leave, reset button color
		end

	end)


	Windows[id]["Opened"] = true
	Windows[id]["Closed"] = false

	Windows[id]["DoAnimation"] = false

	--Add events when clicking buttons
	addEventHandler("onClientGUIClick", root, function()
		if source == Windows[id]["Fullscreen"] then
			if Windows[id]["AnimateFullscreen"] then return false end
			Windows[id]["AnimateFullscreen"] = true
		end

		if source == Windows[id]["Close"] then
			closeWindow(Windows[id]["Frame"])
		end
	end)

	local closeAnim = 0
	local savedParameters = {0, 0, 0, 0}
	addEventHandler("onClientRender", root, function()
		if Windows[id]["AnimateClose"] then

			Windows[id]["DoAnimation"] = true

			if Windows[id]["AnimateOpen"]
				or Windows[id]["AnimateFullscreen"]
				or Windows[id]["Closed"] then

					Windows[id]["DoAnimation"] = false
					Windows[id]["AnimateClose"] = false
					return false
			end
			--if Windows[id]["AnimateOpen"] then return false end
			--if Windows[id]["AnimateFullscreen"] then return false end
			--if Windows[id]["Closed"] then return false end --Windows[id]["AnimateClose"] = false end
			closeAnim = closeAnim+1

			if closeAnim == 11 then 
				closeAnim = 0
				thisWindow:setVisible(false)
				Windows[id]["AnimateClose"] = false
			 	Windows[id]["Closed"] = true
			 	Windows[id]["Opened"] = false
			 	Windows[id]["DoAnimation"] = false
			 	triggerEvent("onClientStaticWindowFullClosed", localPlayer, Windows[id]["Frame"])
			end	

			local x, y = getStaticWindowPosition(thisFrame, false)
			--local w, h = getStaticWindowSize(thisFrame, false)
			setStaticWindowPosition(thisFrame, x, y+closeAnim, false)
			--setStaticWindowSize(thisFrame, w-2, h-2, false, true)
			thisWindow:setAlpha(thisWindow:getAlpha()-0.1)

		end

		if Windows[id]["AnimateOpen"] then

			Windows[id]["DoAnimation"] = true

			if Windows[id]["AnimateClose"]
				or Windows[id]["AnimateFullscreen"]
				or Windows[id]["Opened"] then

					Windows[id]["DoAnimation"] = false
					Windows[id]["AnimateOpen"] = false
					return false
			end

			--if Windows[id]["AnimateClose"] then return false end
			--if Windows[id]["AnimateFullscreen"] then return false end
			--if Windows[id]["Opened"] then return false end --Windows[id]["AnimateOpen"] = false end
			closeAnim = closeAnim+1

			if closeAnim == 1 then
				thisWindow:setVisible(true)
			elseif closeAnim == 11 then 
				closeAnim = 0
				Windows[id]["AnimateOpen"] = false
			 	Windows[id]["Closed"] = false
			 	Windows[id]["Opened"] = true
			 	Windows[id]["DoAnimation"] = false
			 	triggerEvent("onClientStaticWindowFullOpened", localPlayer, Windows[id]["Frame"])
			end	

			local x, y = getStaticWindowPosition(thisFrame, false)
			--local w, h = getStaticWindowSize(thisFrame, false)
			local z = 11-closeAnim == 11 and 0 or 11-closeAnim
			setStaticWindowPosition(thisFrame, x, y-z, false)
			--setStaticWindowSize(thisFrame, w+2, h+2, false, true)
			thisWindow:setAlpha(thisWindow:getAlpha()+0.1)

		end

		if Windows[id]["AnimateFullscreen"] then

			Windows[id]["DoAnimation"] = true

			if Windows[id]["AnimateClose"] or Windows[id]["AnimateOpen"] 
				then
					Windows[id]["DoAnimation"] = false
					Windows[id]["AnimateFullscreen"] = false 
					return false
			end
			closeAnim = closeAnim+1
			
			if Windows[id]["Fullscreened"] then
				if closeAnim == 1 then
					triggerEvent("onClientStaticWindowLeavingFullScreen", localPlayer, thisFrame)		
					outputDebugString("Leaving Fullscreen")	
				end

				if closeAnim >=2 and closeAnim < 12 then
					local x, y = getStaticWindowPosition(thisFrame, false)
					--local w, h = getStaticWindowSize(thisFrame, false)
					setStaticWindowPosition(thisFrame, x, y+1, false)
					--setStaticWindowSize(thisFrame, w-2, h-2, false, true)
					thisWindow:setAlpha(thisWindow:getAlpha()-0.1)			
				end

				if closeAnim == 13 then
					setStaticWindowPosition(thisFrame, savedParameters[1]+10, savedParameters[2]+10, false)
					setStaticWindowSize(thisFrame, savedParameters[3]-20, savedParameters[4]-20, false, true)	
					setStaticWindowMovable(thisFrame, savedParameters[5])		
					setStaticWindowSizable(thisFrame, savedParameters[6])	
					triggerEvent("onClientStaticWindowFullscreenLeave", localPlayer, thisFrame)
					setStaticWindowBorderSize(Windows[id]["Frame"], savedParameters[7])
				end

				if closeAnim >= 15 and closeAnim < 25 then
					local x, y = getStaticWindowPosition(thisFrame, false)
					--local w, h = getStaticWindowSize(thisFrame, false)
					setStaticWindowPosition(thisFrame, x, y-1, false)
					--setStaticWindowSize(thisFrame, w+2, h+2, false, true)
					thisWindow:setAlpha(thisWindow:getAlpha()+0.1)
				end 

				if closeAnim == 26 then
					closeAnim = 0
					Windows[id]["AnimateFullscreen"] = false 
					Windows[id]["Fullscreened"] = false		
					Windows[id]["DoAnimation"] = false	
					triggerEvent("onClientStaticWindowLeavedFullScreen", localPlayer, thisFrame)
					outputDebugString("Leaved Fullscreen")	
				end

			else
				if closeAnim == 1 then
					local x, y = getStaticWindowPosition(thisFrame, false)
					local w, h = getStaticWindowSize(thisFrame, false)
					savedParameters = {x, y, w, h, getStaticWindowMovable(thisFrame), getStaticWindowSizable(thisFrame), Windows[id]["Border"]}
					triggerEvent("onClientStaticWindowEnteringFullScreen", localPlayer, thisFrame)
					outputDebugString("Entering Fullscreen")		
				end

				if closeAnim >= 2 and closeAnim < 12 then
					local x, y = getStaticWindowPosition(thisFrame, false)
					--local w, h = getStaticWindowSize(thisFrame, false)
					setStaticWindowPosition(thisFrame, x, y+1, false)
					--setStaticWindowSize(thisFrame, w-2, h-2, false, true)
					thisWindow:setAlpha(thisWindow:getAlpha()-0.1)
				end

				if closeAnim == 13 then
					setStaticWindowPosition(thisFrame, 0, 10, false)
					setStaticWindowSize(thisFrame, w1, h1, false, true)
					setStaticWindowMovable(thisFrame, false)
					setStaticWindowSizable(thisFrame, false)
					Windows[id]["FullscreenBack"]:setVisible(savedParameters[6])
					setStaticWindowBorderSize(Windows[id]["Frame"], 0)
					triggerEvent("onClientStaticWindowFullscreenEnter", localPlayer, thisFrame)
				end

				if closeAnim >= 14 and closeAnim < 24 then
					local x, y = getStaticWindowPosition(thisFrame, false)
					local w, h = getStaticWindowSize(thisFrame, false)
					setStaticWindowPosition(thisFrame, x-1, y-1, false)
					setStaticWindowSize(thisFrame, w+2, h+2, false, true)
					thisWindow:setAlpha(thisWindow:getAlpha()+0.1)
				end

				if closeAnim == 25 then					
					closeAnim = 0
					Windows[id]["AnimateFullscreen"] = false 
					Windows[id]["Fullscreened"] = true
					Windows[id]["DoAnimation"] = false
					triggerEvent("onClientStaticWindowEnteredFullScreen", localPlayer, thisFrame)
					outputDebugString("Entered Fullscreen")	
				end

			end
		end 

	end)


	local moving = false --Allows when mouse move window

	local resizing = {} 
	for i = 1, 5 do	resizing[i] = false	end--Allows when mouse resize window

	local getPositions = {0, 0} --Get click positions

	addEventHandler("onClientGUIMouseUp", root, function()
		moving = false
		for i = 1, table.maxn(Windows[id]["Resizer"]) do resizing[i] = false end
	end)

	Windows[id]["AddMoveEl"] = function(number)

		addEventHandler("onClientGUIMouseDown", root, function(_, CurX, CurY)
			if not source then return false end
			if source == Windows[id]["MoveElement"][number] then
				if Windows[id]["Movable"] then
					moving = true
					local x, y = getStaticWindowPosition(thisFrame, false)
					getPositions = {CurX-x, CurY-y, 0, 0, 0, 0, 0, 0}
				end
			end
		end)
	end

	addEventHandler("onClientGUIMouseDown", root, function(_, CurX, CurY)

		if not source then return false end
		moving = false
		for i = 1, table.maxn(Windows[id]["Resizer"]) do resizing[i] = false end

		for i in pairs(Windows[id]["MoveElement"]) do
			if not isElement(Windows[id]["MoveElement"]) then return false end
			if source == Windows[id]["MoveElement"] then
				if Windows[id]["Movable"] then
					moving = true
					local x, y = getStaticWindowPosition(thisFrame, false)
					getPositions = {CurX-x, CurY-y, 0, 0, 0, 0, 0, 0}
				end
			end
		end
		if source == Windows[id]["Title"] then
			if Windows[id]["Movable"] then
				moving = true
				local x, y = getStaticWindowPosition(thisFrame, false)
				getPositions = {CurX-x, CurY-y, 0, 0, 0, 0, 0, 0}
			end
		end
		for i in pairs(Windows[id]["Resizer"]) do
			if source == Windows[id]["Resizer"][i] then
				resizing[i] = true
				local x, y = getStaticWindowPosition(thisFrame, false)
				local w, h = getStaticWindowSize(thisFrame, false)
				getPositions = {CurX-x+22, CurY-y+22, CurX-w, CurY-h, x, y, w, h}
				--[[outputDebugString('CX = '..tostring(getPositions[1])..
					"; CY = "..tostring(getPositions[2])..
					"; CW = "..tostring(getPositions[3])..
					"; CH = "..tostring(getPositions[4])..
					"; X = "..tostring(getPositions[5])..
					"; Y = "..tostring(getPositions[6])..
					"; W = "..tostring(getPositions[7])..
					"; H = "..tostring(getPositions[8]))]]
			end
		end
	end)

	addEventHandler("onClientCursorMove", root, function(_, _, CurX, CurY)
		if moving then
			setStaticWindowPosition(thisFrame, CurX-getPositions[1], CurY-getPositions[2], false)
			--Move static window by getting 
		end

		if resizing[1] then
			if (getPositions[5]-(CurX-getPositions[1]+22))+getPositions[7] <= Windows[id]["MinSize"][1] then return false end 

			setStaticWindowPosition(thisFrame, CurX-getPositions[1]+22, getPositions[6])
			setStaticWindowSize(thisFrame, 
				(getPositions[5]-(CurX-getPositions[1]+22))+getPositions[7], --Gets when start position (X) - new position (Cur-CX+22) and + width (W)
				getPositions[8])
		end

		if resizing[2] then
			local px, py = (getPositions[5]-(CurX-getPositions[1]+22))+getPositions[7], CurY-getPositions[4] 
			if px <= Windows[id]["MinSize"][1] then px = Windows[id]["MinSize"][1] end 
			if py <= Windows[id]["MinSize"][2] then py = Windows[id]["MinSize"][2] end
			local pz = CurX-getPositions[1]+22
			if pz >= getPositions[5] then pz = getPositions[5] end

			setStaticWindowPosition(thisFrame, pz, getPositions[6])
			setStaticWindowSize(thisFrame, 
				(getPositions[5]-(CurX-getPositions[1]+22))+getPositions[7],
			 	CurY-getPositions[4])
		end

		if resizing[3] then
			setStaticWindowSize(thisFrame, getPositions[7], CurY-getPositions[4])
		end

		if resizing[4] then
			setStaticWindowSize(thisFrame, CurX-getPositions[3], CurY-getPositions[4])
		end

		if resizing[5] then
			setStaticWindowSize(thisFrame, CurX-getPositions[3], getPositions[8])
		end
	end)

	closeWindow(Windows[id]["Frame"], true, true)
	--openWindow( Windows[id]["Frame"], true)

	return Windows[id]["Frame"], Windows[id]["Title"], Windows[id]["Window"], Windows[id]["WinBack"]  --Return window frame, titlebar and window
end

function getStaticWindowID(win)
	--Function, what gets window ID by window variable
	--Example: getStaticWindowID(window); returns 1 if window = Windows[1]["Frame"] or nil if window ~= Windows[SomeNumbers]["Frame"]
	--It local bcs it uses by window functions

	local ID = nil --If WIN not static-window, we returns nil
	for i in pairs(Windows) do
		if Windows[i]["Frame"] == win then 
			ID = i
			break
		end
	end
	return ID
end


--Set functions:

function setStaticWindowMoveElement(win, el)
	local id = getStaticWindowID(win)
	if id == nil then return false end	
	if not isElement(el) then return false end
	local numb = #Windows[id]["MoveElement"]+1
	Windows[id]["MoveElement"][numb] = el

	Windows[id]["AddMoveEl"](numb)
end

function setStaticWindowBorderSize(win, fp)
	--Function, what sets static window border size
	--Example: setStaticWindowBorderSize(window, 2); returns false if window not static window
	local id = getStaticWindowID(win)
	if id == nil then return false end	
	Windows[id]["Border"] = tonumber(fp) or 1
	local w, h = getStaticWindowSize(win)
	Windows[id]["WinBack"]:setSize(w+(Windows[id]["Border"]*2), h+(Windows[id]["Border"]*2), false)
	Windows[id]["Window"]:setPosition(Windows[id]["Border"], Windows[id]["Border"], false)
	Windows[id]["CentralHorizont"]:setPosition(0, Windows[id]["Border"], false)
	Windows[id]["CentralVertical"]:setPosition(Windows[id]["Border"], 0, false)
	Windows[id]["CentralBack"]:setPosition(math.floor(Windows[id]["Border"]/2), math.floor(Windows[id]["Border"]/2), false)
	setStaticWindowSize(win, w, h, rel, donot)
end

function setStaticWindowPosition(win, x, y, rel)
	--Function, what sets static window position
	--Example: setStaticWindowPosition(window, 10, 10, false); returns setPosition if win is static window, or false

	local id = getStaticWindowID(win)
	if id ~= nil then 
		if y < -getStaticWindowBorderSize(win)*2 then y = -getStaticWindowBorderSize(win)*2 end
		triggerEvent("onClientStaticWindowMove", localPlayer, Windows[id]["Frame"], rel and x*Width or x, rel and y*Height or y)
		return Windows[id]["WinBack"]:setPosition(tonumber(x), tonumber(y), rel or false)
	else return false end
end

function setStaticWindowSize(win, w, h, rel, donot)
	--Function, what sets static window size
	--Example: setStaticWindowSize(window, 10, 10, false, false); returns setSize if win is static window, or false	

	local id = getStaticWindowID(win)
	if id == nil then return false end
	if rel == true then w = w*Width; h = h*Height end


	--If donot not stated
	if not donot then
		--Check sizes
		if w > Windows[id]["MaxSize"][1] then w = Windows[id]["MaxSize"][1] end
		if h > Windows[id]["MaxSize"][2] then h = Windows[id]["MaxSize"][2] end
		if w < Windows[id]["MinSize"][1] then w = Windows[id]["MinSize"][1] end
		if h < Windows[id]["MinSize"][2] then h = Windows[id]["MinSize"][2] end
	end

	local sizing = {}
	local sizes = true

	sizing[0] = Windows[id]["WinBack"]:setSize(w+(Windows[id]["Border"]*2), h+(Windows[id]["Border"]*2), false)
	Windows[id]["CentralHorizont"]:setSize(w+(Windows[id]["Border"]*2), h, false)
	Windows[id]["CentralVertical"]:setSize(w, h+(Windows[id]["Border"]*2), false)
	Windows[id]["CentralBack"]:setSize(w+Windows[id]["Border"], h+Windows[id]["Border"], false)
	sizing[1] = Windows[id]["Window"]:setSize(w, h, false) --Sets window size

	--Sets frame size
	local _, h1 = Windows[id]["BackTitle"]:getSize(false)
	sizing[2] = Windows[id]["Frame"]:setPosition(0, h1, false)
	sizing[3] = Windows[id]["Frame"]:setSize(w, h-h1 > 0 and h-h1 or 0, false)

	--Sets title size
	sizing[4] = Windows[id]["BackTitle"]:setSize(w, h1, false)
	if not isElement(Windows[id]["Title"]) then
		sizing[5] = true
	else
		sizing[5] = Windows[id]["Title"]:setSize(w, h1-2, false)
	end

	--Sets fullscreen and close buttons positions
	--sizing[4] = Windows[id]["FullscreenBack"]:setPosition(w-42, 0, false)
	--sizing[5] = Windows[id]["CloseBack"]:setPosition(w-21, 0, false)

	--Set resizers positions and sizes
	sizing[6] = Windows[id]["Resizer"][1]:setSize(3, h-h1-3, false)

	sizing[7] = Windows[id]["Resizer"][2]:setPosition(0, h-h1-3, false)

	sizing[8] = Windows[id]["Resizer"][3]:setPosition(3, h-h1-3, false)
	sizing[9] = Windows[id]["Resizer"][3]:setSize(w-6, 3, false)

	sizing[10] = Windows[id]["Resizer"][4]:setPosition(w-3, h-h1-3, false)

	sizing[11] = Windows[id]["Resizer"][5]:setPosition(w-3, 0, false)
	sizing[12] = Windows[id]["Resizer"][5]:setSize(3, h-h1-3, false)



	for i in pairs(sizing) do
		if (sizes and sizing[i]) ~= true then
			sizes = false
			break
		end	
	end

	triggerEvent("onClientStaticWindowResize", localPlayer, Windows[id]["Frame"], w, h)

	return sizes

end

function setStaticWindowMinSize(win, w, h, rel)
	--Function, what sets static window minimal size
	--Example: setStaticWindowMinSize(window, 10, 10, false); returns false if window is not static window

	local id = getStaticWindowID(win)
	if id == nil then return false end
	if rel == true then w = w*Width h = h*Height end
	Windows[id]["MinSize"] = {tonumber(w), tonumber(h)}
end

function setStaticWindowMaxSize(win, w, h, rel)
	--Function, what sets static window maximal size
	--Example: setStaticWindowMaxSize(window, 10, 10, false); returns false if window is not static window

	local id = getStaticWindowID(win)
	if id == nil then return false end
	if rel == true then w = w*Width h = h*Height end
	Windows[id]["MaxSize"] = {tonumber(w), tonumber(h)}
end

function setStaticWindowMovable(win, bool)	
	--Function, what sets static window movable
	--Example: setStaticWindowMovable(window, false); returns false if window is not static window

	local id = getStaticWindowID(win)
	if id == nil then return false end
	Windows[id]["Movable"] = bool
end

function setStaticWindowSizable(win, bool)	
	--Function, what sets static window sizable
	--Example: setStaticWindowSizable(window, false); returns false if window is not static window

	local id = getStaticWindowID(win)
	if id == nil then return false end
	Windows[id]["Resizable"] = bool
	Windows[id]["FullscreenBack"]:setVisible(bool)
	for i in pairs(Windows[id]["Resizer"]) do
		Windows[id]["Resizer"][i]:setVisible(bool)
	end
end

function setStaticWindowTitle(win, titletext)
	--Function, what sets static window title text
	--Example: setStaticWindowTitle(window, "Example"); returns false if window is not static window or setText

	local id = getStaticWindowID(win)
	if id == nil then return false end
	return Windows[id]["Title"]:setText(tostring(titletext))
end

function setStaticWindowColorScheme(win, topbar, wincol, textcl)
	--Function, what sets static window color sheme
	--Example: setStaticWindowColorScheme(window, "6600FF", "444444", "444444"); returns false if window is not static window or set static window color scheme

	local id = getStaticWindowID(win)
	if id == nil then return false end

	if topbar == "default" then  _, topbar = fromPropertyToHEX(Windows[id]["BackTitle"]) end
	if topbar == "invisible" then _,topbar = fromPropertyToHEX(Windows[id]["Frame"]) end
	if wincol == "default" then _,  wincol = fromPropertyToHEX(Windows[id]["Frame"]) end
	if textcl == "default" then _ , textcl = fromPropertyToHEX(Windows[id]["Close"]) end

	if topbar:len() ~= 6 and not tonumber(topbar, 16) then topbar = "FFFFFF" end
	if wincol:len() ~= 6 and not tonumber(wincol, 16) then wincol = "FFFFFF" end
	if textcl:len() ~= 6 and not tonumber(textcl, 16) then textcl = "FFFFFF" end

	local r, g, b = fromHEXToRGB(textcl)

	Windows[id]["BackTitle"]:setProperty("ImageColours", "tl:FF"..tostring(topbar).." tr:FF"..tostring(topbar).." bl:FF"..tostring(topbar).." br:FF"..tostring(topbar))
	
	if isElement(Windows[id]["Title"]) then
		Windows[id]["Title"]:setColor(r, g, b)
	
		Windows[id]["Close"]:setProperty("ImageColours", "tl:FF"..tostring(textcl).." tr:FF"..tostring(textcl).." bl:FF"..tostring(textcl).." br:FF"..tostring(textcl))
		Windows[id]["Fullscreen"]:setProperty("ImageColours", "tl:FF"..tostring(textcl).." tr:FF"..tostring(textcl).." bl:FF"..tostring(textcl).." br:FF"..tostring(textcl))
	end

	Windows[id]["Frame"]:setProperty("ImageColours", "tl:FF"..tostring(wincol).." tr:FF"..tostring(wincol).." bl:FF"..tostring(wincol).." br:FF"..tostring(wincol))
end


--Get functions:
function getStaticWindowPosition(win, rel)
	--Function, what gets static window position
	--Example: getStaticWindowPosition(window); returns false if window is not static window or positions {X, Y}

	local id = getStaticWindowID(win)
	if id == nil then return false end
	return Windows[id]["WinBack"]:getPosition(rel or false)
end

function getStaticWindowSize(win, rel)
	--Function, what gets static window position
	--Example: getStaticWindowPosition(window); returns false if window is not static window or positions {X, Y}

	local id = getStaticWindowID(win)
	if id == nil then return false end
	return Windows[id]["Window"]:getSize(rel or false)
end

function getStaticWindowSizable(win)
	--Function, what gets static window sizable
	--Example: getStaticWindowSizable(window); returns false if window is not static window or sizable of window
	local id = getStaticWindowID(win)
	if id == nil then return false end
	return Windows[id]["Resizable"]
end

function getStaticWindowMovable(win)
	--Function, what gets static window movable
	--Example: getStaticWindowMovable(window); returns false if window is not static window or movable of window
	local id = getStaticWindowID(win)
	if id == nil then return false end
	return Windows[id]["Movable"]
end

function getStaticWindowBorderSize(win)
	--Function, what gets static window border size
	--Example: getStaticWindowBorderSize(window); returns false if window not static window or bordersize
	local id = getStaticWindowID(win)
	if id == nil then return false end	
	return Windows[id]["Border"]
end



--Some other functions:

function setStaticWindowTitleBarHeight(win, height)
	--Function, what sets static window color sheme
	--Example: setStaticWindowTitleBarHeight(window, 30); returns false if window is not static window or set static window titlebar height

	local id = getStaticWindowID(win)
	if id == nil then return false end
	if height < 14 then height = 14 end
	local w = Windows[id]["BackTitle"]:getSize(false)
	Windows[id]["BackTitle"]:setSize(w, height, false)
	Windows[id]["Title"]:setSize(w, height-2, false)

	local w, h = getStaticWindowSize(Windows[id]["Frame"], false)
	setStaticWindowSize(Windows[id]["Frame"], w, h, false)

end

function getStaticWindowTitleBarHeight(win)
	local id = getStaticWindowID(win)
	if id == nil then return false end
	local _, h = Windows[id]["BackTitle"]:getSize(false)
	return h
end

function fromHEXToRGB(color)
	--this function replace color from HEX, and return R, G and B parameters (from 0 to 255)
	--Example: fromHEXToRGB("6600FF"); returns 102, 0, 255
    if tostring(color):len() == 8 then return tonumber(color:sub(3, 4), 16), tonumber(color:sub(5, 6), 16), tonumber(color:sub(7, 8), 16), tonumber(color:sub(1, 2), 16)
    elseif tostring(color):len() == 6 then return tonumber(color:sub(1, 2), 16), tonumber(color:sub(3, 4), 16), tonumber(color:sub(5, 6), 16)
    end
end

function fromPropertyToHEX(element)
    if getElementType(element) ~= "gui-staticimage" then return false end
    local str = guiGetProperty(element, "ImageColours"):sub(4, 11)
    local str2 = str:sub(3, 8)
    return str, str2
end

function openWindow(win, fast)
	--Function, what opens window
	--Example: openWindow(window); returns false if window is not static window 
	local id = getStaticWindowID(win)
	if id == nil then return false end
	
	if Windows[id]["DoAnimation"] then return false end

	if fast then Windows[id]["WinBack"]:setAlpha(1) end
	if Windows[id]["AnimateOpen"] then return false end
	Windows[id]["AnimateOpen"] = true
	Windows[id]["WinBack"]:bringToFront()
	if fast then triggerEvent("onClientStaticWindowFullOpened", localPlayer, Windows[id]["Frame"])
	else triggerEvent("onClientStaticWindowOpen", localPlayer, Windows[id]["Frame"]) end

end

function closeWindow(win, fast, rel)
	--Function, what close window
	--Example: closeWindow(window); returns false if window is not static window 
	local id = getStaticWindowID(win)
	if id == nil then return false end

	if Windows[id]["DoAnimation"] then return false end

	if fast then Windows[id]["WinBack"]:setAlpha(0) end
	if Windows[id]["AnimateClose"] then return false end
	Windows[id]["AnimateClose"] = true
	if not rel then
		if fast then triggerEvent("onClientStaticWindowFullClosed", localPlayer, Windows[id]["Frame"]) end
	end
	if not fast then triggerEvent("onClientStaticWindowClose", localPlayer, Windows[id]["Frame"]) end
end

function ocWindow(win, fast)
	--Function, what open or close window
	--Example: ocWindow(window); returns false if window is not static window 
	local id = getStaticWindowID(win)
	if id == nil then return false end
	if Windows[id]["Closed"] then openWindow(Windows[id]["Frame"], fast)
	else closeWindow(Windows[id]["Frame"], fast) end
end

addEvent("onClientStaticWindowClose", true)

function showError(text, parent)
	local win, _, _, errorwin = createStaticWindow(Width/2, Height/2, 240, 80, "Error", false, parent or nil)
	local info = GuiLabel.create(0, 0, 240, 25, tostring(text), false, win)
	setStaticWindowColorScheme(win, "FFFFFF", "FFFFFF", "6E6F73")
	setStaticWindowSizable(win, false)
	errorwin:bringToFront()
	errorwin:setProperty("AlwaysOnTop", "True")
	info:setHorizontalAlign("center")
	info:setFont(GuiFont.create(fonr.."OSR.ttf", 10))
	info:setColor(110, 111, 115)

	local OKBut = createCustomButton(90, 27, 60, 20, "OK", false, win)

	local id = getStaticWindowID(win)
	addEventHandler("onClientStaticWindowClose", root, function(window)
		if window ~= win then return false end
		Windows[id]["AnimateClose"] = false
		destroyElement(errorwin)
	end)

	addEventHandler("onClientGUIClick", root, function()
		if source == OKBut then
			closeWindow(win)
		end
	end)

	return win
end



--OOP for Window System
StaticWindow = {}
StaticWindow.__index = StaticWindow
function StaticWindow.create(...)
	local self = setmetatable({}, StaticWindow)
	self.Frame, self.Title, self.Window, self.Back = createStaticWindow(...)
	return self
end

function StaticWindow.setMoveElement(self, ...) setStaticWindowMoveElement(self.Frame, ...) end
function StaticWindow.setBorderSize(self, ...) setStaticWindowBorderSize(self.Frame, ...) end 
function StaticWindow.setPosition(self, ...) setStaticWindowPosition(self.Frame, ...) end 
function StaticWindow.setSize(self, ...) setStaticWindowSize(self.Frame, ...) end 
function StaticWindow.setMinSize(self, ...) setStaticWindowMinSize(self.Frame, ...) end 
function StaticWindow.setMaxSize(self, ...) setStaticWindowMaxSize(self.Frame, ...) end 
function StaticWindow.setMovable(self, ...) setStaticWindowMovable(self.Frame, ...) end 
function StaticWindow.setSizable(self, ...) setStaticWindowSizable(self.Frame, ...) end 
function StaticWindow.setTitle(self, ...) setStaticWindowTitle(self.Frame, ...) end 
function StaticWindow.setColorScheme(self, ...) setStaticWindowColorScheme(self.Frame, ...) end
function StaticWindow.setTitleHeight(self, ...) setStaticWindowTitleBarHeight(self.Frame, ...) end


function StaticWindow.getBorderSize(self) return setStaticWindowBorderSize(self.Frame) end 
function StaticWindow.getPosition(self, ...) return getStaticWindowPosition(self.Frame, ...) end 
function StaticWindow.getSize(self, ...) return getStaticWindowSize(self.Frame, ...) end 
function StaticWindow.getMovable(self) return getStaticWindowMovable(self.Frame) end 
function StaticWindow.getSizable(self) return getStaticWindowSizable(self.Frame) end 
function StaticWindow.getTitleHeight(self) return getStaticWindowTitleBarHeight(self.Frame) end

function StaticWindow.open(self, ...) return openWindow(self.Frame, ...) end
function StaticWindow.close(self, ...) return closeWindow(self.Frame, ...) end
function StaticWindow.oc(self, ...) return ocWindow(self.Frame, ...) end
function StaticWindow.error(...) return showError(...) end

--[[local Windowss = StaticWindow.create(800, 300, 200, 200, "Test", false, nil)
Windowss:setBorderSize(2)
Windowss:setPosition(0.6, 0.1, true)
Windowss:setSize(300, 300, false)
Windowss:setMaxSize(700, 700, false)
Windowss:setColorScheme("DE6262", "DEDEDE", "FFFFFF")
Windowss:setTitleHeight(90)
--indowss:setMovable(false)]]
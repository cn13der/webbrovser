local EditBox={}
local editboxes = 0

--Font
Font = {
	thin = "fonts/thin.ttf",

	OpenSansBold = "fonts/OSB.ttf",
	OpenSansExtraBold = "fonts/OSEB.ttf",
	OpenSansSemiBold = "fonts/OSSB.ttf",

	OpenSansItalic = "fonts/OSI.ttf",
	OpenSansBoldItalic = "fonts/OSBI.ttf",
	OpenSansExtraBoldItalic = "fonts/OSEBI.ttf",
	OpenSansSemiBoldItalic = "fonts/OSSBI.ttf",

	OpenSansLight = "fonts/OSL.ttf",
	OpenSansLightItalic = "fonts/OSLI.ttf",
	OpenSansRegular = "fonts/OSR.ttf",

	SegoeUILight = "fonts/OSLI.ttf",
	SegoeUIRegular = "fonts/OSR.ttf",
}


addEvent("onClientChangeStandartColor", true)
--[[function createCustomEdit(x, y, w, h, text, rel, par, bul, num, bols)
	editboxes = editboxes+1
	local id = editboxes
	EditBox[id] = {}

	EditBox[id]["Back"] = GuiStaticImage.create(x, y, w, h, "imgs/pane.png", rel, par)
	EditBox[id]["Back"]:setProperty("ImageColours", "tl:0 tr:0 bl:0 br:0") --FF3498DB

	EditBox[id]["Label"] = GuiLabel.create(0, 0, 1, 1, "  "..text, true, EditBox[id]["Back"])
	EditBox[id]["Label"]:setVerticalAlign("center")
	EditBox[id]["Label"]:setProperty("AlwaysOnTop", "True")

	EditBox[id]["Edit"] = GuiEdit.create(0, 0, 1, 1, text, true, EditBox[id]["Label"])
	EditBox[id]["Edit"]:setAlpha(0)

	EditBox[id]["Selector"] = GuiStaticImage.create(0, 0, 0, h, "imgs/pane.png", false, EditBox[id]["Back"])
	EditBox[id]["Selector"]:setAlpha(1)
	EditBox[id]["Selector"]:setProperty("ImageColours", "tl:FF3498DB tr:FF3498DB bl:FF3498DB br:FF3498DB") --FF3498DB
	if bul == true then
		EditBox[id]["Selector"]:setPosition(0, num or 2, false)
	end

	if bols == true then
		EditBox[id]["Selector"]:setAlpha(0.5)
	end

	EditBox[id]["Hided"] = false

	addEventHandler("onClientGUIChanged", root, function()
		if source == EditBox[id]["Edit"] then
			if not EditBox[id]["Hided"] then 
				EditBox[id]["Label"]:setText("  "..EditBox[id]["Edit"]:getText())
			else
				EditBox[id]["Label"]:setText("  "..string.rep("*", EditBox[id]["Edit"]:getText():len()))
			end
			if bul == true then EditBox[id]["Selector"]:setPosition(0, num or 2, false)
			else EditBox[id]["Selector"]:setPosition(0, 0, false) end
			EditBox[id]["Selector"]:setSize(0, 0, false)
		end
	end)
	addEventHandler("onClientChangeStandartColor", root, function(color)
		customEditSetSelectionColor(id, color)
	end)]]
	--[[addEventHandler("onClientMouseEnter", root, function()
		if source == EditBox[id]["Edit"] then		
			setCursorImage("images/cursor/text.png")
		end
	end)

	addEventHandler("onClientMouseLeave", root, function()
		if source == EditBox[id]["Edit"] then		
			setCursorImage("images/cursor/cursor.png")
		end
	end)]]

	--[[local setSelection = false
	local Position = 0
	addEventHandler("onClientGUIMouseUp", root, function()
		setSelection = false
	end)
	addEventHandler("onClientGUIClick", root, function()
		if source == EditBox[id]["Edit"] then

			if bul == true then EditBox[id]["Selector"]:setPosition(0, num or 2, false)
			else EditBox[id]["Selector"]:setPosition(0, 0, false) end
			EditBox[id]["Selector"]:setSize(0, 0, false)

		end
	end)

	addEventHandler("onClientGUIMouseDown", root, function(btn, CurX)
		if source == EditBox[id]["Edit"] then
			if btn == "left" then
				setSelection = true
				local x = getGUIOnScreenPosition(EditBox[id]["Label"])
				Position = CurX-x
				--outputDebugString(tostring(x).." "..tostring(Position))
			end
		end
	end)
	addEventHandler("onClientCursorMove", root, function(_, _, cursx)
		if setSelection == true then
			local _, h = EditBox[id]["Edit"]:getSize(false)
			local x = getGUIOnScreenPosition(EditBox[id]["Label"])
			local CursorS = cursx-x
			local PosX = Position
			local awid = math.abs(CursorS-PosX)
			if CursorS < PosX then PosX = CursorS end

			if bul == true then EditBox[id]["Selector"]:setPosition(PosX, num or 2, false)
			else EditBox[id]["Selector"]:setPosition(PosX, 0, false) end
			EditBox[id]["Selector"]:setSize(awid, h, false)

		end
	end)

	return EditBox[id]["Edit"], EditBox[id]["Label"], EditBox[id]["Back"]
end]]

--[[function customEditSetFont(id, font, size)
	if not tonumber(id) then id = getCustomEdit(id)
	else id = tonumber(id) end
	if not isElement(EditBox[id]["Label"]) then return false end

	EditBox[id]["Label"]:setFont(GuiFont.create(font, tonumber(size)))
	EditBox[id]["Edit"]:setFont(GuiFont.create(font, tonumber(size)))
end

function customEditSetMasked(id, bool)
	if not tonumber(id) then id = getCustomEdit(id)
	else id = tonumber(id) end
	if not isElement(EditBox[id]["Label"]) then return false end
	if bool ~= true and bool ~= false then bool = false end
	EditBox[id]["Edit"]:setMasked(bool)
	EditBox[id]["Hided"] = bool
	if bool == true then EditBox[id]["Label"]:setText("  "..string.rep("*", EditBox[id]["Edit"]:getText():len()))
	else EditBox[id]["Label"]:setText("  "..EditBox[id]["Edit"]:getText()) end
end

function customEditSetSelectionColor(id, color)
	if not tonumber(id) then id = getCustomEdit(id)
	else id = tonumber(id) end
	if not isElement(EditBox[id]["Label"]) then return false end
	if color:len() == 6 and tonumber(color, 16) then
		EditBox[id]["Selector"]:setProperty("ImageColours", "tl:FF"..color.." tr:FF"..color.." bl:FF"..color.." br:FF"..color) 
	end
end

function customEditGetSelectionColor(id)
	if not tonumber(id) then id = getCustomEdit(id)
	else id = tonumber(id) end
	if not isElement(EditBox[id]["Label"]) then return false end
	local _, res = fromPropertyToHEX(EditBox[id]["Selector"])
	return res
end

function getCustomEdit(element)
	local ID = nil
	for i in pairs(EditBox) do
		if ID == nil then
			if element == EditBox[i]["Edit"] or element == EditBox[i]["Label"] then
				ID = i
			end
		else break end
	end
	return ID
end]]

function getGUIOnScreenPosition(element)
	local x, y = guiGetPosition(element, false)
	local child = element
	for i = 0, 100 do
		if getElementParent(child).type ~= "guiroot" then
			local x1, y1 = guiGetPosition(getElementParent(child), false)
			--outputDebugString(tostring(x1).." "..tostring(x))
			x, y = x+x1, y+y1 
			child = getElementParent(child)
		else break end
	end
	return x, y
end

local ElementBoxes = {}
local elementnumbs = 0

function guiCreateQuadMemo(x, y, w1, h1, str, rel, par, bool, c1, c2, c3, c4, bools)

    if not c1 then c1 = "FFFFFF" end
    if not c2 then c2 = "FFFFFF" end
    if not c3 then c3 = "FFFFFF" end
    if not c4 then c4 = "FFFFFF" end
    if bool ~= false and bool ~= true then bool = true end

    local id = elementnumbs
    elementnumbs = elementnumbs+1
    ElementBoxes[id] = {}

    ElementBoxes[id]["Main"] = GuiMemo.create(x, y, w1, h1, str, rel, par)

    ElementBoxes[id]["R1"] = GuiStaticImage.create(0, 0, w1, 5, "imgs/pane.png", false, ElementBoxes[id]["Main"])
    ElementBoxes[id]["R2"] = GuiStaticImage.create(0, 0, 3, h1, "imgs/pane.png", false, ElementBoxes[id]["Main"])
    ElementBoxes[id]["R3"] = GuiStaticImage.create(w1-3, 0, 3, h1, "imgs/pane.png", false, ElementBoxes[id]["Main"])
    ElementBoxes[id]["R4"] = GuiStaticImage.create(0, h1-3, w1, 3, "imgs/pane.png", false, ElementBoxes[id]["Main"])

    ElementBoxes[id]["R1"]:setProperty("ImageColours", "tl:FF"..c1.." tr:FF"..c1.." bl:FF"..c1.." br:FF"..c1)
    ElementBoxes[id]["R2"]:setProperty("ImageColours", "tl:FF"..c2.." tr:FF"..c2.." bl:FF"..c2.." br:FF"..c2)
    ElementBoxes[id]["R3"]:setProperty("ImageColours", "tl:FF"..c3.." tr:FF"..c3.." bl:FF"..c3.." br:FF"..c3)
    ElementBoxes[id]["R4"]:setProperty("ImageColours", "tl:FF"..c4.." tr:FF"..c4.." bl:FF"..c4.." br:FF"..c4)

    ElementBoxes[id]["R5"] = GuiStaticImage.create(3, 4, w1-6, 1, "imgs/pane.png", false, ElementBoxes[id]["R1"])
    ElementBoxes[id]["R6"] = GuiStaticImage.create(2, 5, 1, h1-8, "imgs/pane.png", false, ElementBoxes[id]["R2"])
    ElementBoxes[id]["R7"] = GuiStaticImage.create(0, 5, 1, h1-8, "imgs/pane.png", false, ElementBoxes[id]["R3"])
    ElementBoxes[id]["R8"] = GuiStaticImage.create(3, 0, w1-6, 1, "imgs/pane.png", false, ElementBoxes[id]["R4"])

    if bools then
    	c1, c2, c3, c4 = "D5D5D5", "D5D5D5", "D5D5D5", "D5D5D5"
    end 

    ElementBoxes[id]["R5"]:setProperty("ImageColours", "tl:FF"..c1.." tr:FF"..c1.." bl:FF"..c1.." br:FF"..c1)
    ElementBoxes[id]["R6"]:setProperty("ImageColours", "tl:FF"..c2.." tr:FF"..c2.." bl:FF"..c2.." br:FF"..c2)
    ElementBoxes[id]["R7"]:setProperty("ImageColours", "tl:FF"..c3.." tr:FF"..c3.." bl:FF"..c3.." br:FF"..c3)
    ElementBoxes[id]["R8"]:setProperty("ImageColours", "tl:FF"..c4.." tr:FF"..c4.." bl:FF"..c4.." br:FF"..c4)


    local Visibility = ElementBoxes[id]["Main"]:getVisible()

   	return ElementBoxes[id]["Main"]
end

function guiCreateQuadEdit(x, y, w1, h1, str, rel, par, bool, c1, c2, c3, c4, bools)

    if not c1 then c1 = "FFFFFF" end --Top
    if not c2 then c2 = "FFFFFF" end --Left
    if not c3 then c3 = "FFFFFF" end --Right
    if not c4 then c4 = "FFFFFF" end --Bottom
    if bool ~= false and bool ~= true then bool = true end

    local id = elementnumbs
    elementnumbs = elementnumbs+1
    ElementBoxes[id] = {}

    ElementBoxes[id]["Main"] = GuiEdit.create(x, y, w1, h1, str, rel, par)

    ElementBoxes[id]["R1"] = GuiStaticImage.create(0, 0, w1, 5, "imgs/pane.png", false, ElementBoxes[id]["Main"])
    ElementBoxes[id]["R2"] = GuiStaticImage.create(0, 0, 3, h1, "imgs/pane.png", false, ElementBoxes[id]["Main"])
    ElementBoxes[id]["R3"] = GuiStaticImage.create(w1-3, 0, 3, h1, "imgs/pane.png", false, ElementBoxes[id]["Main"])
    ElementBoxes[id]["R4"] = GuiStaticImage.create(0, h1-3, w1, 3, "imgs/pane.png", false, ElementBoxes[id]["Main"])

    ElementBoxes[id]["R1"]:setProperty("ImageColours", "tl:FF"..c1.." tr:FF"..c1.." bl:FF"..c1.." br:FF"..c1)
    ElementBoxes[id]["R2"]:setProperty("ImageColours", "tl:FF"..c2.." tr:FF"..c2.." bl:FF"..c2.." br:FF"..c2)
    ElementBoxes[id]["R3"]:setProperty("ImageColours", "tl:FF"..c3.." tr:FF"..c3.." bl:FF"..c3.." br:FF"..c3)
    ElementBoxes[id]["R4"]:setProperty("ImageColours", "tl:FF"..c4.." tr:FF"..c4.." bl:FF"..c4.." br:FF"..c4)

    ElementBoxes[id]["R5"] = GuiStaticImage.create(3, 4, w1-6, 1, "imgs/pane.png", false, ElementBoxes[id]["R1"])
    ElementBoxes[id]["R6"] = GuiStaticImage.create(2, 5, 1, h1-8, "imgs/pane.png", false, ElementBoxes[id]["R2"])
    ElementBoxes[id]["R7"] = GuiStaticImage.create(0, 5, 1, h1-8, "imgs/pane.png", false, ElementBoxes[id]["R3"])
    ElementBoxes[id]["R8"] = GuiStaticImage.create(3, 0, w1-6, 1, "imgs/pane.png", false, ElementBoxes[id]["R4"])

    if bools then
    	c1, c2, c3, c4 = "D5D5D5", "D5D5D5", "D5D5D5", "D5D5D5"
    end 

    ElementBoxes[id]["R5"]:setProperty("ImageColours", "tl:FF"..c1.." tr:FF"..c1.." bl:FF"..c1.." br:FF"..c1)
    ElementBoxes[id]["R6"]:setProperty("ImageColours", "tl:FF"..c2.." tr:FF"..c2.." bl:FF"..c2.." br:FF"..c2)
    ElementBoxes[id]["R7"]:setProperty("ImageColours", "tl:FF"..c3.." tr:FF"..c3.." bl:FF"..c3.." br:FF"..c3)
    ElementBoxes[id]["R8"]:setProperty("ImageColours", "tl:FF"..c4.." tr:FF"..c4.." bl:FF"..c4.." br:FF"..c4)

    local Visibilityes = ElementBoxes[id]["Main"]:getVisible()

    return ElementBoxes[id]["Main"]
end

function guiQuadIDCheck(element)
	local ID = false
	for i = 0, elementnumbs do
		if isElement(ElementBoxes[i]["Main"]) and ElementBoxes[i]["Main"] == element then
			ID = i
			break
		end
	end
	return ID
end

function guiQuadElementSetSize(element, w, h, rel)
	local id = guiQuadIDCheck(element)
	if id == false then return false end

	ElementBoxes[id]["Main"]:setSize(w, h, rel or false)
	if rel == true then
		w, h = ElementBoxes[id]["Main"]:getSize(false)
	end

	ElementBoxes[id]["R1"]:setSize(w, 5, false)
	ElementBoxes[id]["R2"]:setSize(3, h, false)

	ElementBoxes[id]["R3"]:setPosition(w-3, 0, false)
	ElementBoxes[id]["R3"]:setSize(3, h, false)

	ElementBoxes[id]["R4"]:setPosition(0, h-3, false)
	ElementBoxes[id]["R4"]:setSize(w, 3, false)

	if isElement(ElementBoxes[id]["R5"]) then
		ElementBoxes[id]["R5"]:setSize(w-6, 1, false)
		ElementBoxes[id]["R6"]:setSize(1, h-8, false)
		ElementBoxes[id]["R7"]:setSize(1, h-8, false)
		ElementBoxes[id]["R8"]:setSize(w-6, 1, false)
	end
end


local ButtonBackColor = "DE6262"
local ButtonCentralCol1 = "F37373"
local ButtonCentralCol2 = "DE6363"

local ButtonBHoverColor1 = "F37372" --central
local ButtonBHoverColor2 = "CC4141"
local ButtonBHoverColor3 = "DE6261" --back
local ButtonBHoverColor4 = "CC4040"

local ButtonClickColor1 = "DC5f4E" --central
local ButtonClickColor2 = "C44E4D"
local ButtonClickColor3 = "DC5f4D" --back
local ButtonClickColor4 = "C44E4C"

local ScrollColor = "C24A4A"

local ButR, ButG, ButB = 255, 255, 255

local STD = "E26A6A"
function getStandartColor()
	return STD
end
function setStandartColor(color)
	if tostring(color):len() ~= 6 then color = color:sub(1, 6) end
	if (color == nil or color == "default") and not tonumber(color == nil and "G" or color, 16) then color = "E26A6A" end
	STD = color
	triggerEvent("onClientChangeStandartColor", localPlayer, STD)
end

--[[function applyButtonsThemeByDefaultColor(el)

	local num11, num12, num13
	if tostring(el):len() ~= 6 then el = STD:sub(1, 6) end
	if el ~= nil then num11 = tonumber(el:sub(1, 2), 16) num12 = tonumber(el:sub(3, 4), 16) num13 = tonumber(el:sub(5, 6), 16)
	else num11 = tonumber(STD:sub(1, 2), 16) num12 = tonumber(STD:sub(3, 4), 16) num13 = tonumber(STD:sub(5, 6), 16) end	

	--if num1 > 16777215 then num1 = 16777215 end
	local center1 = string.format("%.2x%.2x%.2x", num11, num12, num13)

	local num21, num22, num23 = (num11-24 < 0 and 0 or num11-24), (num12-24 < 0 and 0 or num12-24), (num13-24 < 0 and 0 or num13-24)
	local center2 = string.format("%.2x%.2x%.2x", num21, num22, num23)

	local num31, num32, num33 = (num11-24 < 0 and 0 or num11-24), (num12-24 < 0 and 0 or num12-24), (num13-24 < 0 and 0 or num13-24)
	local hover1 = string.format("%.2x%.2x%.2x", num31, num32, num33)

	local num41, num42, num43 = (num11-40 < 0 and 0 or num11-40), (num12-40 < 0 and 0 or num12-40), (num13-40 < 0 and 0 or num13-40)
	local hover2 = string.format("%.2x%.2x%.2x", num41, num42, num43)

	local num51, num52, num53 = (num11-50 < 0 and 0 or num11-50), (num12-50 < 0 and 0 or num12-50), (num13-50 < 0 and 0 or num13-50)
	local click1 = string.format("%.2x%.2x%.2x", num51, num52, num53)

	local num61, num62, num63 = (num11-65 < 0 and 0 or num11-65), (num12-65 < 0 and 0 or num12-65), (num13-30 < 0 and 0 or num13-65)
	local click2 = string.format("%.2x%.2x%.2x", num61, num62, num63)

	applyButtonsTheme(center1, center2, hover1, hover2, click1, click2, "FFFFFF")
end

function applyButtonsTheme(center1, center2, hover1, hover2, click1, click2, textcolor)

	if (center1 == nil or center1 == "default") and not tonumber(center1 == nil and "G" or center1, 16) then center1 = "F37373" end
	if (center2 == nil or center2 == "default") and not tonumber(center2 == nil and "G" or center2, 16) then center2 = "DE6363" end
	if (hover1 == nil or hover1 == "default") and not tonumber(hover1 == nil and "G" or hover1, 16) then hover1 = "F37372" end
	if (hover2 == nil or hover2 == "default") and not tonumber(hover2 == nil and "G" or hover2, 16) then hover2 = "CC4141" end
	if (click1 == nil or click1 == "default") and not tonumber(click1 == nil and "G" or click1, 16) then click1 = "DC5f4E" end
	if (click2 == nil or click2 == "default") and not tonumber(click2 == nil and "G" or click2, 16) then click2 = "C44E4D" end
	if (textcolor == nil or textcolor == "default") and not tonumber(textcolor == nil and "G" or textcolor, 16) then textcolor = "FFFFFF" end

	ButR, ButG, ButB = fromHEXToRGB(textcolor)

	ButtonCentralCol1 = center1
	ButtonCentralCol2 = center2
	local x1 = tonumber(center1:sub(1, 2), 16)-12
	local x2 = tonumber(center1:sub(3, 4), 16)-12
	local x3 = tonumber(center1:sub(5, 6), 16)-12
	if x1 < 0 then x1 = 0 end
	if x2 < 0 then x2 = 0 end
	if x3 < 0 then x3 = 0 end
	ButtonBackColor = string.format("%.2x%.2x%.2x", x1, x2, x3)

	ButtonBHoverColor1 = hover1
	ButtonBHoverColor2 = hover2
	local y1 = tonumber(center2:sub(1, 2), 16)-18
	local y2 = tonumber(center2:sub(3, 4), 16)-18
	local y3 = tonumber(center2:sub(5, 6), 16)-18
	if y1 < 0 then y1 = 0 end
	if y2 < 0 then y2 = 0 end
	if y3 < 0 then y3 = 0 end
	ButtonBHoverColor3 = string.format("%.2x%.2x%.2x", y1, y2, y3)
	local z1 = tonumber(hover2:sub(1, 2), 16)-3
	local z2 = tonumber(hover2:sub(3, 4), 16)-3
	local z3 = tonumber(hover2:sub(5, 6), 16)-2
	if z1 < 0 then z1 = 0 end
	if z2 < 0 then z2 = 0 end
	if z3 < 0 then z3 = 0 end
	ButtonBHoverColor4 = string.format("%.2x%.2x%.2x", z1, z2, z3)

	ButtonClickColor1 = click1
	ButtonClickColor2 = click2
	local t1 = tonumber(click1:sub(1, 2), 16)-2 
	local t2 = tonumber(click1:sub(3, 4), 16)-2
	local t3 = tonumber(click1:sub(5, 6), 16)-2
	if t1 < 0 then t1 = 0 end
	if t2 < 0 then t2 = 0 end
	if t3 < 0 then t3 = 0 end
	ButtonClickColor3 = string.format("%.2x%.2x%.2x", t1, t2, t3)
	local r1 = tonumber(click2:sub(1, 2), 16)-2 
	local r2 = tonumber(click2:sub(3, 4), 16)-2
	local r3 = tonumber(click2:sub(5, 6), 16)-2 
	if r1 < 0 then r1 = 0 end
	if r2 < 0 then r2 = 0 end
	if r3 < 0 then r3 = 0 end
	ButtonClickColor4 = string.format("%.2x%.2x%.2x", r1, r2, r3)

	local g1 = tonumber(click2:sub(1, 2), 16)-20
	local g2 = tonumber(click2:sub(3, 4), 16)-20 
	local g3 = tonumber(click2:sub(5, 6), 16)-20 
	if g1 < 0 then g1 = 0 end
	if g2 < 0 then g2 = 0 end
	if g3 < 0 then g3 = 0 end
	ScrollColor = string.format("%.2x%.2x%.2x", g1, g2, g3)

	triggerEvent("onClientChangeButtonTheme", localPlayer)
end


addEvent("onClientChangeButtonTheme", true)]]

local pane = "imgs/pane.png"
local Width, Height = guiGetScreenSize() 
--[[local enabled = {}
local created = 0
function createCustomButton(x, y, w, h, text, rel, parent, nonstyled)

	if rel == true then
		local Width, Height = parent:getSize(false) or guiGetScreenSize() 
		x = x*Width
		y = y*Height
		w = w*Width
		h = h*Height
	else rel = false end

	if nonstyled ~= true and nonstyled ~= false then nonstyled = false end

	created = created+1

	local backbutton = GuiStaticImage.create(x, y, w+2, h+2, pane, false, parent or nil)
	backbutton:setProperty("ImageColours", "tl:00000000 tr:00000000 bl:00000000 br:00000000")

	local horcent = GuiStaticImage.create(0, 1, w+2, h, pane, false, backbutton)
	local vercent = GuiStaticImage.create(1, 0, w, h+2, pane, false, backbutton)
	horcent:setProperty("ImageColours", "tl:FF"..ButtonBackColor.." tr:FF"..ButtonBackColor.." bl:FF"..ButtonBackColor.." br:FF"..ButtonBackColor.."")
	vercent:setProperty("ImageColours", "tl:FF"..ButtonBackColor.." tr:FF"..ButtonBackColor.." bl:FF"..ButtonBackColor.." br:FF"..ButtonBackColor.."")

	local centralButton = GuiStaticImage.create(1, 1, w, h, pane, false, backbutton)
	centralButton:setProperty("ImageColours", "tl:FF"..ButtonCentralCol1.." tr:FF"..ButtonCentralCol1.." bl:FF"..ButtonCentralCol2.." br:FF"..ButtonCentralCol2.."")
	centralButton:setProperty("AlwaysOnTop", "True")

	local centralText = GuiLabel.create(0, 0, w, h-2, tostring(text), false, centralButton)
	centralText:setVerticalAlign("center")
	centralText:setHorizontalAlign("center")
	centralText:setFont(GuiFont.create("System/fonts/OSR.ttf", 10))
	centralText:setColor(ButR, ButG, ButB)



	if nonstyled then 
		horcent:setProperty("ImageColours", "tl:FFF2F2F2 tr:FFF2F2F2 bl:FFF2F2F2 br:FFF2F2F2")
		vercent:setProperty("ImageColours", "tl:FFF2F2F2 tr:FFF2F2F2 bl:FFF2F2F2 br:FFF2F2F2")
		centralButton:setProperty("ImageColours", "tl:FFF4F4F4 tr:FFF4F4F4 bl:FFEFEFEF br:FFEFEFEF")
		centralText:setColor(102, 102, 102)
	end

	addEventHandler("onClientChangeButtonTheme", root, function()
		if nonstyled then return false end
		if not isElement(centralButton) then return false end
		centralButton:setProperty("ImageColours", "tl:FF"..ButtonCentralCol1.." tr:FF"..ButtonCentralCol1.." bl:FF"..ButtonCentralCol2.." br:FF"..ButtonCentralCol2.."")
		horcent:setProperty("ImageColours", "tl:FF"..ButtonBackColor.." tr:FF"..ButtonBackColor.." bl:FF"..ButtonBackColor.." br:FF"..ButtonBackColor.."")
		vercent:setProperty("ImageColours", "tl:FF"..ButtonBackColor.." tr:FF"..ButtonBackColor.." bl:FF"..ButtonBackColor.." br:FF"..ButtonBackColor.."")
		centralText:setColor(ButR, ButG, ButB)
	end)

	addEventHandler("onClientMouseEnter", root, function()
		if source == centralText or source == centralButton then
			if not backbutton:getEnabled() then return false end
			if not isElement(centralButton) then return false end
			centralButton:setProperty("ImageColours", "tl:FF"..ButtonBHoverColor1.." tr:FF"..ButtonBHoverColor1.." bl:FF"..ButtonBHoverColor2.." br:FF"..ButtonBHoverColor2.."")
			horcent:setProperty("ImageColours", "tl:FF"..ButtonBHoverColor3.." tr:FF"..ButtonBHoverColor3.." bl:FF"..ButtonBHoverColor4.." br:FF"..ButtonBHoverColor4.."")
			vercent:setProperty("ImageColours", "tl:FF"..ButtonBHoverColor3.." tr:FF"..ButtonBHoverColor3.." bl:FF"..ButtonBHoverColor4.." br:FF"..ButtonBHoverColor4.."")

			if nonstyled then
				horcent:setProperty("ImageColours", "tl:FFD9D9D9 tr:FFD9D9D9 bl:FFD9D9D9 br:FFD9D9D9")
				vercent:setProperty("ImageColours", "tl:FFD9D9D9 tr:FFD9D9D9 bl:FFD9D9D9 br:FFD9D9D9")
				centralButton:setProperty("ImageColours", "tl:FFF1F1F1 tr:FFF1F1F1 bl:FFDADADA br:FFDADADA")
			end
		end
	end)

	addEventHandler("onClientMouseLeave", root, function()
		if source == centralText or source == centralButton then
			if not backbutton:getEnabled() then return false end
			if not isElement(centralButton) then return false end
			centralButton:setProperty("ImageColours", "tl:FF"..ButtonCentralCol1.." tr:FF"..ButtonCentralCol1.." bl:FF"..ButtonCentralCol2.." br:FF"..ButtonCentralCol2.."")
			horcent:setProperty("ImageColours", "tl:FF"..ButtonBackColor.." tr:FF"..ButtonBackColor.." bl:FF"..ButtonBackColor.." br:FF"..ButtonBackColor.."")
			vercent:setProperty("ImageColours", "tl:FF"..ButtonBackColor.." tr:FF"..ButtonBackColor.." bl:FF"..ButtonBackColor.." br:FF"..ButtonBackColor.."")

			if nonstyled then
				horcent:setProperty("ImageColours", "tl:FFF2F2F2 tr:FFF2F2F2 bl:FFF2F2F2 br:FFF2F2F2")
				vercent:setProperty("ImageColours", "tl:FFF2F2F2 tr:FFF2F2F2 bl:FFF2F2F2 br:FFF2F2F2")
				centralButton:setProperty("ImageColours", "tl:FFF4F4F4 tr:FFF4F4F4 bl:FFEFEFEF br:FFEFEFEF")
			end
		end
	end)

	addEventHandler("onClientGUIMouseDown", root, function()
		if source == centralText or source == centralButton then
			if not backbutton:getEnabled() then return false end
			centralButton:setProperty("ImageColours", "tl:FF"..ButtonClickColor1.." tr:FF"..ButtonClickColor1.." bl:FF"..ButtonClickColor2.." br:FF"..ButtonClickColor2.."")
			horcent:setProperty("ImageColours", "tl:FF"..ButtonClickColor3.." tr:FF"..ButtonClickColor3.." bl:FF"..ButtonClickColor4.." br:FF"..ButtonClickColor4.."")
			vercent:setProperty("ImageColours", "tl:FF"..ButtonClickColor3.." tr:FF"..ButtonClickColor3.." bl:FF"..ButtonClickColor4.." br:FF"..ButtonClickColor4.."")

			if nonstyled then
				horcent:setProperty("ImageColours", "tl:FFDEDEDE tr:FFDEDEDE bl:FFDCDCDC br:FFDCDCDC")
				vercent:setProperty("ImageColours", "tl:FFDEDEDE tr:FFDEDEDE bl:FFDCDCDC br:FFDCDCDC")
				centralButton:setProperty("ImageColours", "tl:FFE5E5E5 tr:FFE5E5E5 bl:FFD8D8D8 br:FFD8D8D8")
			end
		end
	end)

	addEventHandler("onClientGUIMouseUp", root, function()
		if source == centralText or source == centralButton then
			if not backbutton:getEnabled() then return false end
			centralButton:setProperty("ImageColours", "tl:FF"..ButtonBHoverColor1.." tr:FF"..ButtonBHoverColor1.." bl:FF"..ButtonBHoverColor2.." br:FF"..ButtonBHoverColor2.."")
			horcent:setProperty("ImageColours", "tl:FF"..ButtonBHoverColor3.." tr:FF"..ButtonBHoverColor3.." bl:FF"..ButtonBHoverColor4.." br:FF"..ButtonBHoverColor4.."")
			vercent:setProperty("ImageColours", "tl:FF"..ButtonBHoverColor3.." tr:FF"..ButtonBHoverColor3.." bl:FF"..ButtonBHoverColor4.." br:FF"..ButtonBHoverColor4.."")

			if nonstyled then
				horcent:setProperty("ImageColours", "tl:FFD9D9D9 tr:FFD9D9D9 bl:FFD9D9D9 br:FFD9D9D9")
				vercent:setProperty("ImageColours", "tl:FFD9D9D9 tr:FFD9D9D9 bl:FFD9D9D9 br:FFD9D9D9")
				centralButton:setProperty("ImageColours", "tl:FFF1F1F1 tr:FFF1F1F1 bl:FFDADADA br:FFDADADA")
			end
		end
	end)

	enabled[created] = {["Text"] = centralText, ["Back"] = backbutton, ["Hor"] = horcent, ["Ver"] = vercent, ["Cent"] = centralButton, ["Styled"] = nonstyled}
	return centralText, backbutton

end

function setButtonEnabled(but, bool)
	if bool ~= true and bool ~= false then bool = true end
	
	for i in pairs(enabled) do
		if but == enabled[i]["Text"] or but == enabled[i]["Back"] then
			enabled[i]["Back"]:setEnabled(bool)
			if bool == false then
				enabled[i]["Hor"]:setProperty("ImageColours", "tl:FFD0D0D0 tr:FFD0D0D0 bl:FFD0D0D0 br:FFD0D0D0")
				enabled[i]["Ver"]:setProperty("ImageColours", "tl:FFD0D0D0 tr:FFD0D0D0 bl:FFD0D0D0 br:FFD0D0D0")
				enabled[i]["Cent"]:setProperty("ImageColours", "tl:FFD1D1D1 tr:FFD1D1D1 bl:FFD1D1D1 br:FFD1D1D1")
			else
				enabled[i]["Hor"]:setProperty("ImageColours", "tl:FF"..ButtonBackColor.." tr:FF"..ButtonBackColor.." bl:FF"..ButtonBackColor.." br:FF"..ButtonBackColor.."")
				enabled[i]["Ver"]:setProperty("ImageColours", "tl:FF"..ButtonBackColor.." tr:FF"..ButtonBackColor.." bl:FF"..ButtonBackColor.." br:FF"..ButtonBackColor.."")
				enabled[i]["Cent"]:setProperty("ImageColours", "tl:FF"..ButtonCentralCol1.." tr:FF"..ButtonCentralCol1.." bl:FF"..ButtonCentralCol2.." br:FF"..ButtonCentralCol2.."")

				if enabled[i]["Styled"] then
					horcent:setProperty("ImageColours", "tl:FFF2F2F2 tr:FFF2F2F2 bl:FFF2F2F2 br:FFF2F2F2")
					vercent:setProperty("ImageColours", "tl:FFF2F2F2 tr:FFF2F2F2 bl:FFF2F2F2 br:FFF2F2F2")
					centralButton:setProperty("ImageColours", "tl:FFF4F4F4 tr:FFF4F4F4 bl:FFEFEFEF br:FFEFEFEF")
				end

			end
		end
	end
end

--applyButtonsTheme("3C8EDC", "4183D7", "2F93D6", "397ACE", "318ECC", "3C78C3")
setStandartColor("3C8EDC")
applyButtonsThemeByDefaultColor("3C8EDC")]]



--[[local CheckButton = "imgs/check/check.png"
local CheckButtonNon = "imgs/check/nonch.png"
local CheckButtonR = "imgs/check/trues.png"

local checkButtons = {}

local checkboxes = 0
function createCheckButton(x, y, width, height, text, parent)

	if not parent then parent = nil end

	if height <= 22 then height = 22 end
	if width <= 22 then width = 22 end

	checkboxes = checkboxes+1
	local id = checkboxes

	checkButtons[id]={} 
	checkButtons[id]["Back"] = GuiStaticImage.create(x, y, width, height, pane, false, parent) --Backgroud
	checkButtons[id]["Back"]:setProperty("ImageColours", "tl:0 tr:0 bl:0 br:0")

	--Check icon
	checkButtons[id]["Check"] = GuiStaticImage.create(0, (height/2)-11, 22, 22, CheckButtonNon, false, checkButtons[id]["Back"])
	checkButtons[id]["Check"]:setProperty("ImageColours", "tl:FFDDDDDD tr:FFDDDDDD bl:FFDDDDDD br:FFDDDDDD")
	checkButtons[id]["Check"]:setEnabled(false)

	--Checked argument
	checkButtons[id]["Checked"] = false

	if text ~= nil then --If not text then do not create text
		-- else creating that text:
		checkButtons[id]["Text"] = GuiLabel.create(30, 0, width-30 or 0, height-2, tostring(text), false, checkButtons[id]["Back"])
		checkButtons[id]["Text"]:setColor(10, 10, 10)
		checkButtons[id]["Text"]:setEnabled(false)
		checkButtons[id]["Text"]:setVerticalAlign("center")
		checkButtons[id]["Text"]:setFont(GuiFont.create("System/fonts/OSR.ttf", 10.2))
	else
		checkButtons[id]["Text"] = nil
	end

	--Галочка на выбранном чекбоксе
	checkButtons[id]["Rights"] = GuiStaticImage.create(5, ((height/2)-11)+6, 12, 10, CheckButtonR, false, checkButtons[id]["Back"])
	checkButtons[id]["Rights"]:setEnabled(false)
	checkButtons[id]["Rights"]:setVisible(false)

	addEventHandler("onClientMouseEnter", root, function()
		if source == checkButtons[id]["Back"] then 
			if checkButtons[id]["Checked"] then return false end -- If button checked, return false, bcs we not need to use it
			local color = getStandartColor()
			checkButtons[id]["Check"]:setProperty("ImageColours", "tl:FF"..color.." tr:FF"..color.." bl:FF"..color.." br:FF"..color.."")
		end
	end)
	addEventHandler("onClientMouseLeave", root, function()
		if source == checkButtons[id]["Back"] then 
			if checkButtons[id]["Checked"] then return false end -- If button checked, return false, bcs we not need to use it
			checkButtons[id]["Check"]:setProperty("ImageColours", "tl:FFDDDDDD tr:FFDDDDDD bl:FFDDDDDD br:FFDDDDDD")
		end
	end)
	addEventHandler("onClientGUIClick", root, function()
		if source == checkButtons[id]["Back"] then
			checkButtons[id]["Checked"] = not checkButtons[id]["Checked"]
			if not isElement(checkButtons[id]["Check"]) then return false end
			local color = getStandartColor()
			if checkButtons[id]["Checked"] then 
				checkButtons[id]["Check"]:loadImage(CheckButton)
				checkButtons[id]["Check"]:setProperty("ImageColours", "tl:FF"..color.." tr:FF"..color.." bl:FF"..color.." br:FF"..color.."")
				checkButtons[id]["Rights"]:setVisible(true)
			else
				checkButtons[id]["Check"]:loadImage(CheckButtonNon)
				checkButtons[id]["Rights"]:setVisible(false)
			end
		end
	end)
	addEventHandler("onClientChangeStandartColor", root, function(color)
		if checkButtons[id]["Checked"] then 
			checkButtons[id]["Check"]:setProperty("ImageColours", "tl:FF"..color.." tr:FF"..color.." bl:FF"..color.." br:FF"..color.."")			
		end
	end)

	return checkButtons[id]["Back"], checkButtons[id]["Text"]
end

function getCheckButtonID(element)
	local ID = tonumber(element) or nil
	for i in pairs(checkButtons) do
		if element == checkButtons[i]["Back"] or element == checkButtons[i]["Text"] then
			ID = i
			break
		end
	end
	return ID
end

function isCheckButtonChecked(eles)
	local id = getCheckButtonID(eles)
	if id == nil then return nil end
	if not isElement(checkButtons[id]["Back"]) then return nil end
	return checkButtons[id]["Checked"]
end
function setCheckButtonChecked(eles, bool)
	local id = getCheckButtonID(eles)
	if id == nil then return false end
	if not isElement(checkButtons[id]["Back"]) then return false end
	if bool ~= true and bool ~= false then return false end
	checkButtons[id]["Checked"] = not bool
	return triggerEvent("onClientGUIClick", checkButtons[id]["Back"])
end]]


--[[createCheckButton(300, 370, 100, 30, "Test 1", nil)
local i2 = createCheckButton(300, 400, 100, 30, "Test 2", nil)
local i1 = createCheckButton(300, 430, 100, 30, "Test 3", nil)
setCheckButtonChecked(i1, true)]]




--[[local RadioButton = "imgs/radio/check.png"
local RadioButtonNon = "imgs/radio/nonch.png"
local groups = 0
local RadioGroupZ = {}


function createRadioGroup() --RadioGroup
	groups = groups+1
	RadioGroupZ[groups]={}
	RadioGroupZ[groups]["Count"] = 0
	return groups
end

function addRadioButton(group, x, y, width, height, text, parent) --Add radio button in radioGroup

	if not parent then parent = nil end
	if not group or group > groups then group = groups end --If group not exists, then set it to last group 

	if height <= 22 then height = 22 end
	if width <= 22 then width = 22 end

	RadioGroupZ[group]["Count"] = RadioGroupZ[group]["Count"]+1 --Count of elements in radio group
	local id = RadioGroupZ[group]["Count"]

	--RadioGroupZ [GROUP - group of element] [ID - Element] [TEXT - Part of element]
	RadioGroupZ[group][id] = {}

	RadioGroupZ[group][id]["Back"] = GuiStaticImage.create(x, y, width, height, pane, false, parent)
	RadioGroupZ[group][id]["Back"]:setProperty("ImageColours", "tl:0 tr:0 bl:0 br:0")

	RadioGroupZ[group][id]["Check"] = GuiStaticImage.create(0, (height/2)-11, 22, 22, RadioButtonNon, false, RadioGroupZ[group][id]["Back"])
	RadioGroupZ[group][id]["Check"]:setProperty("ImageColours", "tl:FFDDDDDD tr:FFDDDDDD bl:FFDDDDDD br:FFDDDDDD")
	RadioGroupZ[group][id]["Check"]:setEnabled(false)

	RadioGroupZ[group][id]["Checked"] = false

	if text ~= nil then --If not text then do not create text
		-- else creating that text:
		RadioGroupZ[group][id]["Text"] = GuiLabel.create(30, 0, width-30 or 0, height-2, tostring(text), false, RadioGroupZ[group][id]["Back"])
		RadioGroupZ[group][id]["Text"]:setColor(10, 10, 10)
		RadioGroupZ[group][id]["Text"]:setEnabled(false)
		RadioGroupZ[group][id]["Text"]:setVerticalAlign("center")
		RadioGroupZ[group][id]["Text"]:setFont(GuiFont.create("System/fonts/OSR.ttf", 10.2))
	else
		RadioGroupZ[group][id]["Text"] = nil
	end

	addEventHandler("onClientMouseEnter", root, function()
		if source == RadioGroupZ[group][id]["Back"] then 
			if RadioGroupZ[group][id]["Checked"] then return false end -- If button checked, return false, bcs we not need to use it
			local color = getStandartColor()
			RadioGroupZ[group][id]["Check"]:setProperty("ImageColours", "tl:FF"..color.." tr:FF"..color.." bl:FF"..color.." br:FF"..color.."")
		end
	end)
	addEventHandler("onClientMouseLeave", root, function()
		if source == RadioGroupZ[group][id]["Back"] then 
			if RadioGroupZ[group][id]["Checked"] then return false end -- If button checked, return false, bcs we not need to use it
			RadioGroupZ[group][id]["Check"]:setProperty("ImageColours", "tl:FFDDDDDD tr:FFDDDDDD bl:FFDDDDDD br:FFDDDDDD")
		end
	end)
	addEventHandler("onClientGUIClick", root, function(el)
		if source == RadioGroupZ[group][id]["Back"] then

			for i, v in ipairs(RadioGroupZ[group]) do
				RadioGroupZ[group][i]["Checked"] = false	 --Clear all, bcs this is radio button :D			
			end

			-- -1 is to unselect all
			if tostring(el) ~= "-1" then RadioGroupZ[group][id]["Checked"] = true end --set only one checked

			local color = getStandartColor()
			for i, v in ipairs(RadioGroupZ[group]) do
				if not isElement(RadioGroupZ[group][i]["Check"]) then return false end
				if RadioGroupZ[group][i]["Checked"] then 
					RadioGroupZ[group][i]["Check"]:loadImage(RadioButton)
					RadioGroupZ[group][i]["Check"]:setProperty("ImageColours", "tl:FF"..color.." tr:FF"..color.." bl:FF"..color.." br:FF"..color.."")
				else
					RadioGroupZ[group][i]["Check"]:loadImage(RadioButtonNon)
					RadioGroupZ[group][i]["Check"]:setProperty("ImageColours", "tl:FFDDDDDD tr:FFDDDDDD bl:FFDDDDDD br:FFDDDDDD")
				end
			end
		end
	end)
	addEventHandler("onClientChangeStandartColor", root, function(color)
		if RadioGroupZ[group][id]["Checked"] then 
			RadioGroupZ[group][id]["Check"]:setProperty("ImageColours", "tl:FF"..color.." tr:FF"..color.." bl:FF"..color.." br:FF"..color.."")			
		end
	end)

	return RadioGroupZ[group][id]["Back"], RadioGroupZ[group][id]["Text"]
end

function getRadioGroupSelectedButton(group)
	if group > groups then group = groups end
	
	local id = -1
	for i, v in ipairs(RadioGroupZ[group]) do
		if not isElement(RadioGroupZ[group][i]["Check"]) then return false end
		if RadioGroupZ[group][i]["Checked"] then
			id = i
			break
		end
	end
	return id
end
function setRadioGroupSelectedButton(group, el)
	if group > groups then group = groups end
	local om = el
	if om > table.maxn(RadioGroupZ[group]) then om = table.maxn(RadioGroupZ[group]) end
	if el < 1 then el = 1 om = -1 end
	if not isElement(RadioGroupZ[group][el]["Back"]) then  end
	triggerEvent("onClientGUIClick", RadioGroupZ[group][el]["Back"], om)
end

CheckElement = {}
CheckElement.__index = CheckElement

function CheckElement.create(...)
	local self = setmetatable({}, CheckElement)
	self.Back, self.Text = createCheckButton(...)
	return self
end
function CheckElement.setChecked(self, bool) return setCheckButtonChecked(self.Back, bool) end
function CheckElement.isChecked(self) return isCheckButtonChecked(self.Back) end]]

--[[local Eles = CheckElement.create(100, 100, 200, 30, "Test")
local Eles2 = CheckElement.create(100, 130, 200, 30, "Test")
Eles:setChecked(true)
Eles2:setChecked(true)
Eles2.Text:setColor(255, 0, 0)
outputDebugString(tostring(Eles2:isChecked()))]]

--[[RadioGroup={}
RadioGroup.__index = RadioGroup

function RadioGroup.create()
	local self = setmetatable({}, RadioGroup)
	self.ID = createRadioGroup()
	return self
end
function RadioGroup.addButton(self, ...) self.Back, self.Text = addRadioButton(self.ID, ...) return self.Back, self.Text end
function RadioGroup.getSelectedButton(self) return getRadioGroupSelectedButton(self.ID) end
function RadioGroup.setSelectedButton(self, but) return setRadioGroupSelectedButton(self.ID, but) end ]]

--[[local gros = RadioGroup.create()
gros:addButton(200, 200, 100, 30, "Test")
gros:addButton(200, 230, 100, 30, "Test")
gros:addButton(200, 260, 100, 30, "Test")
gros:setSelectedButton(2)
outputDebugString(tostring(gros:getSelectedButton()))]]

local ScrollPaneSettings = {}
local ScrollPaneNumber = 0

--Element for onClientGUIMouseUp
local BackForMouse = GuiStaticImage.create(0, 0, 1, 1, pane, true)
BackForMouse:setProperty("ImageColours", "tl:0 tr:0 bl:0 br:0")
BackForMouse:setVisible(false)

function createCustomScrollPane(xz, yz, wz, hz, rel, par)

	ScrollPaneNumber = ScrollPaneNumber+1 --Count of scroll panes
	local id = ScrollPaneNumber

	ScrollPaneSettings[id] = {} --Make a table of elements and parameters

	ScrollPaneSettings[id]["Back"] = GuiStaticImage.create( --Back of scroll pane, this item not changing :D
		xz, yz, wz, hz, pane, rel, par
	)
	ScrollPaneSettings[id]["Back"]:setProperty("ImageColours", "tl:0 tr:0 bl:0 br:0") 

	ScrollPaneSettings[id]["Scroll"] = GuiStaticImage.create( --Its scroll pane - here put elements, 
		0, 0, wz, hz, pane, rel, 
		ScrollPaneSettings[id]["Back"]
	)

	ScrollPaneSettings[id]["Scroll"]:setProperty("ImageColours", "tl:0 tr:0 bl:0 br:0")
	ScrollPaneSettings[id]["Scroll"]:setProperty("AbsoluteMaxSize", "w:10000000 h:10000000")

	--Parameters - speed of scrolling, enabling cursor scrolling and positions for cursor scrolling
	ScrollPaneSettings[id].Speed = 12
	ScrollPaneSettings[id].SetScrollEnabled = false
	ScrollPaneSettings[id].ScrollPositions = {x=0, y=0}

	--Wheel scrolling
	addEventHandler("onClientMouseWheel", root, function(up)
		if source == ScrollPaneSettings[id]["Scroll"] then

			local _, h1 = ScrollPaneSettings[id]["Back"]:getSize(false)
			local _, h2 = ScrollPaneSettings[id]["Scroll"]:getSize(false)

			if h1 >= h2 then return false end --If back size more than scroll size, stop scrolling

			local minpos = h1 - h2 --If previous condition not true, size of scroll more than back, and minpos is negative 
			--get position
			local x, y = ScrollPaneSettings[id]["Scroll"]:getPosition(false)

			if up == -1 then

				--Scrolling
				y = y - ScrollPaneSettings[id].Speed
				--If minpos more than y, y now is minpos (frames of scrolling)
				if y <= minpos then y = minpos end

				--Set positions
				ScrollPaneSettings[id]["Scroll"]:setPosition(x, y, false)

			else
				--Same
				y = y + ScrollPaneSettings[id].Speed
				if y >= 0 then y = 0 end

				ScrollPaneSettings[id]["Scroll"]:setPosition(x, y, false)

			end
		end
	end)

	--Cursor scrolling
	addEventHandler("onClientGUIMouseDown", root, function(_, CurX, CurY)
		if source ~= ScrollPaneSettings[id]["Scroll"] then return false end
		--Enabling scrolling and show back for stop mouse
		ScrollPaneSettings[id].SetScrollEnabled = true
		BackForMouse:setVisible(true)

		--Get positions of scroll
		local x, y = ScrollPaneSettings[id]["Scroll"]:getPosition(false)
		--and enter it in scroll positions (like CurAxis here minus CurAxis in moving)
		ScrollPaneSettings[id].ScrollPositions = {x=CurX-x, y=CurY-y}
	end)
	addEventHandler("onClientGUIMouseUp", root, function()
		--Stop scrolling
		ScrollPaneSettings[id].SetScrollEnabled = false
		BackForMouse:setVisible(false)
	end)

	addEventHandler("onClientCursorMove", root, function(_, _, CurX, CurY)
		if not ScrollPaneSettings[id].SetScrollEnabled then return false end

		--Update position to like a CurAxis-CurAxis
		local x, y = CurX-ScrollPaneSettings[id].ScrollPositions.x, CurY-ScrollPaneSettings[id].ScrollPositions.y

		
		local w1, h1 = ScrollPaneSettings[id]["Back"]:getSize(false)
		local w2, h2 = ScrollPaneSettings[id]["Scroll"]:getSize(false)

		--Check sizes
		if w1>=w2 then x = 0 end
		if h1>=h2 then y = 0 end

		--Check axis
		if x <= w1-w2 then x = w1-w2 end
		if x >= 0 then x = 0 end
		if y <= h1-h2 then y = h1-h2 end
		if y >= 0 then y = 0 end

		ScrollPaneSettings[id]["Scroll"]:setPosition(x, y, false)
	end)

	addEventHandler("onClientRender", root, function()
		if not isElement(ScrollPaneSettings[id]["Scroll"]) then 
			cancelEvent() 
			return false 
		end
		if not ScrollPaneSettings[id]["Scroll"]:getVisible() then return false end
		if ScrollPaneSettings[id]["Scroll"]:getVisible() then

			--If scroll out of back, to check this, we load coordinates
			local w1, h1 = ScrollPaneSettings[id]["Back"]:getSize(false)
			local w2, h2 = ScrollPaneSettings[id]["Scroll"]:getSize(false)
			local x, y = ScrollPaneSettings[id]["Scroll"]:getPosition(false)

			--Check axis
			if x < w1-w2 then 

				x = w1-w2 
				if x > 0 then x = 0 end

				ScrollPaneSettings[id]["Scroll"]:setPosition(x, y, false)
			end
			if y < h1-h2 then 

				y = h1-h2
				if y > 0 then y = 0 end

				ScrollPaneSettings[id]["Scroll"]:setPosition(x, y, false)
			end
		end
	end)

	return ScrollPaneSettings[id]["Scroll"], ScrollPaneSettings[id]["Back"] 
end

function getScrollPaneID(element)
	local id = false
	for i in pairs(ScrollPaneSettings) do
		if element == ScrollPaneSettings[i]["Scroll"] then id = i end
	end
	return id
end

function addElementToScrollPane(panez, element)
	local panes = getScrollPaneID(panez)
	if panes == false then return false end

	local wd, hd = panez:getSize(false)
	local x, y = element:getPosition(false)
	local wn, hn = element:getSize(false)

	if x+wn > wd then wd = x+wn end
	if y+hn > hd then hd = y+hn end

	panez:setSize(wd, hd, false)
end

function scrollPaneSetScrollSpeed(panez, speed)
	local panes = getScrollPaneID(panez)
	if panes == false then return false end

	ScrollPaneSettings[panes].Speed = tonumber(speed) or 12
end

function addScrollElement(panez, element, axises)
	local panes = getScrollPaneID(panez)
	if panes == false then return false end

	--check last argument
	if axises == "x" or axises == 1 then axises = 1
	elseif axises == "y" or axises == 2 then axises = 2
	else axises = 3 end

	--Wheel scrolling
	if axises == 2 or axises == 3 then
		addEventHandler("onClientMouseWheel", root, function(up)
			if source == element then
	
				local _, h1 = ScrollPaneSettings[panes]["Back"]:getSize(false)
				local _, h2 = ScrollPaneSettings[panes]["Scroll"]:getSize(false)
	
				if h1 >= h2 then return false end --If back size more than scroll size, stop scrolling
	
				local minpos = h1 - h2 --If previous condition not true, size of scroll more than back, and minpos is negative 
				--get position
				local x, y = ScrollPaneSettings[panes]["Scroll"]:getPosition(false)
	
				if up == -1 then
	
					--Scrolling
					y = y - ScrollPaneSettings[panes].Speed
					--If minpos more than y, y now is minpos (frames of scrolling)
					if y <= minpos then y = minpos end
	
					--Set positions
					ScrollPaneSettings[panes]["Scroll"]:setPosition(x, y, false)
	
				else
					--Same
					y = y + ScrollPaneSettings[panes].Speed
					if y >= 0 then y = 0 end
	
					ScrollPaneSettings[panes]["Scroll"]:setPosition(x, y, false)
	
				end
			end
		end)
	end


	--Cursor scrolling
	addEventHandler("onClientGUIMouseDown", root, function(_, CurX, CurY)
		if source ~= element then return false end
		--Enabling scrolling and show back for stop mouse
		ScrollPaneSettings[panes].SetScrollEnabled = true
		BackForMouse:setVisible(true)

		--Get positions of scroll
		local x, y = ScrollPaneSettings[panes]["Scroll"]:getPosition(false)

		--Check for axises
		local x1, y1 = CurX-x, CurY-y
		if axises == 1 then y1 = y 
		elseif axises == 2 then x1 = x end

		--and enter it in scroll positions (like CurAxis here minus CurAxis in moving)
		ScrollPaneSettings[panes].ScrollPositions = {x=x1, y=y1}
	end)

end
--[[
local scrol = createCustomScrollPane(0, 0, 100, 100, false)
local img = GuiStaticImage.create(50, 50, 90, 90, pane, false, scrol)
addElementToScrollPane(scrol, img)
local ig = GuiStaticImage.create(0, 0, 1, 1, pane, false, scrol)
addElementToScrollPane(scrol, ig)]]


ScrollMenu = {}
ScrollMenu.__index = ScrollMenu

function ScrollMenu.create(...)
	local self = setmetatable({}, ScrollMenu)
	self.Menu, self.Back = createCustomScrollPane(...)
	return self
end
function ScrollMenu.addElement(self, element) addElementToScrollPane(self.Menu, element) end

function ScrollMenu.setSize(self, w, h, rel) return self.Back:setSize(w, h, rel), self.Menu:setSize(w, h, rel) end
function ScrollMenu.getSize(self, rel) return self.Back:getSize(rel) end

function ScrollMenu.setPosition(self, x, y, rel) return self.Back:setPosition(x, y, rel) end
function ScrollMenu.getPosition(self, rel) return self.Back:getPosition(rel) end

function ScrollMenu.setSpeed(self, speed) return scrollPaneSetScrollSpeed(self.Menu, speed) end
function ScrollMenu.addScrollElement(self, element, axis) return addScrollElement(self.Menu, element, axis) end


--[[local menu = ScrollMenu.create(0, 0, 100, 100, false)
local img = GuiStaticImage.create(50, 50, 90, 90, pane, false, menu.Menu)
menu:addElement(img)]]

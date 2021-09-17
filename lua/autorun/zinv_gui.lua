-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end


-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end


-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end


-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end


-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end


-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end


-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end


-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end


-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end


-- "lua\\autorun\\zinv_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")

if SERVER then return end

SpawnMenu = {}

SpawnMenu.models = {
	"None"
}
SpawnMenu.weapons = { 
	"None", "weapon_357", "weapon_alyxgun", "weapon_annabelle", "weapon_ar2",
	"weapon_crossbow", "weapon_crowbar", "weapon_frag", "weapon_pistol", "weapon_rpg",
	"weapon_shotgun", "weapon_smg1", "weapon_stunstick"
}
SpawnMenu.npcs = {
	"None"
}
local n = 2
for k, v in pairs(list.Get("NPC")) do
	SpawnMenu.npcs[n] = k
	n = n + 1
end
SpawnMenu.weaponProficiencies = {
	"Poor", "Average", "Good", "Very Good", "Perfect"
}

function SpawnMenu:new()
	self.frame = vgui.Create("DFrame")
	self.profileList = vgui.Create("DListView", self.frame)
	self.addProfileField = vgui.Create("DTextEntry", self.frame)
	self.addProfileButton = vgui.Create("DButton", self.frame)
	self.removeProfileButton = vgui.Create("DButton", self.frame)
	self.tabSheet = vgui.Create("DPropertySheet", self.frame)

	self.editingNPC = nil
	self.editingHero = nil

	-- NPC tab
	self.npcTab = vgui.Create("DPanel")
	self.npcSheet = vgui.Create("DPropertySheet", self.npcTab)
	self.addNPCTab = vgui.Create("DScrollPanel")
	self.editNPCTab = vgui.Create("DScrollPanel")

	-- Hero tab
	self.heroTab = vgui.Create("DPanel")
	self.heroSheet = vgui.Create("DPropertySheet", self.heroTab)
	self.addHeroTab = vgui.Create("DScrollPanel")
	self.editHeroTab = vgui.Create("DScrollPanel")

	self:setupGUI()

	return self
end

function SpawnMenu:setupGUI()
	-- Measurement consts
	margin = 10
	frameW = 700
	frameH = 500
	titleBarH = 35

	buttonsH = 20

	addButtonW = 30

	profileListW = 150
	profileListH = frameH - titleBarH - (buttonsH * 2) - (margin * 3)

	tabSheetH = frameH - titleBarH - margin
	tabSheetW = frameW - profileListW - (margin * 3)

	addProfileFieldW = profileListW - addButtonW - margin

	-- Frame
	self.frame:SetPos(50,50)
	self.frame:SetSize(frameW, frameH)
	self.frame:SetTitle("Spawn Editor") 
	self.frame:SetDraggable(true)
	self.frame:ShowCloseButton(true)
	self.frame:SetDeleteOnClose(false)
	self.frame:SetVisible(false)

	-- Profiles
	self.profileList:AddColumn("Profiles")
	self.profileList:SetPos(margin, titleBarH)
	self.profileList:SetSize(profileListW, profileListH)

	self.profileList.OnClickLine = function(parent, line, isSelected)
		net.Start("change_zinv_profile")
		net.WriteString(line:GetValue(1))
		net.SendToServer()
	end

	-- Add profile field
	self.addProfileField:SetSize(addProfileFieldW, buttonsH)
	self.addProfileField:SetPos(margin, titleBarH + profileListH + margin)
	self.addProfileField:SetWide(addProfileFieldW)
	self.addProfileField:SetUpdateOnType(true)

	-- Add profile button
	self.addProfileButton:SetText("Add")
	self.addProfileButton:SetSize(addButtonW, buttonsH)
	self.addProfileButton:SetPos(addProfileFieldW + (margin * 2), titleBarH + profileListH + margin)
	self.addProfileButton:SetEnabled(false)

	self.addProfileButton.DoClick = function()
		net.Start("create_zinv_profile")
		net.WriteString(self.addProfileField:GetValue())
		net.SendToServer()
		self.addProfileField:SetText("")
	end

	self.addProfileField.OnEnter = function(_)
		if not self.addProfileButton:GetDisabled() then
			self.addProfileButton:DoClick()
		end
	end

	self.addProfileField.OnValueChange = function(_, strValue)
		self.addProfileButton:SetEnabled(string.match(strValue, "%w+") ~= nil)
	end

	-- Remove profile button
	self.removeProfileButton:SetText("Remove")
	self.removeProfileButton:SetSize(profileListW, buttonsH)
	self.removeProfileButton:SetPos(margin, titleBarH + profileListH + buttonsH + (margin * 2))

	self.removeProfileButton.DoClick = function()
		self:disableNPCEdit(true)
		self:disableHeroEdit(true)
		net.Start("remove_zinv_profile")
		net.WriteString(profileName)
		net.SendToServer()
	end

	-- Tabs
	self.tabSheet:SetPos(profileListW + (margin * 2), titleBarH)
	self.tabSheet:SetSize(tabSheetW, tabSheetH)

	-- NPC tab
	self.npcTab:SetPos(0, 0)
	self.npcTab:SetSize(tabSheetW, tabSheetH)
	self.npcTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- NPC sheet
	self.npcSheet:SetPos(0, 0)
	self.npcSheet:SetSize(504, 250)
	
	-- Add NPC tab
	self.addNPCTab:SetPos(0, 0)
	self.addNPCTab:SetVerticalScrollbarEnabled(true)

	-- Edit NPC tab
	self.editNPCTab:SetPos(0, 0)
	self.editNPCTab:SetVerticalScrollbarEnabled(true)

	-- NPC spawn list
	self.npcSpawnList = vgui.Create("DListView", self.npcTab)
	self.npcSpawnList:SetPos(0, 250)
	self.npcSpawnList:SetSize(504, 169)
	self.npcSpawnList:SetMultiSelect(false)
	self.npcSpawnList:AddColumn("ID")
	self.npcSpawnList:AddColumn("Health")
	self.npcSpawnList:AddColumn("Chance")
	self.npcSpawnList:AddColumn("Model")
	self.npcSpawnList:AddColumn("Scale")
	self.npcSpawnList:AddColumn("NPC")
	self.npcSpawnList:AddColumn("Weapon")
	self.npcSpawnList:AddColumn("Flags")
	self.npcSpawnList:AddColumn("Squad")
	self.npcSpawnList:AddColumn("Proficiency")
	self.npcSpawnList:AddColumn("Damage")

	self.npcSpawnList.OnRowRightClick = function(_, num)
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.npcSpawnList:RemoveLine(num) 
	    	table.remove(npcList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editNPCListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	-- Hero tab
	self.heroTab:SetPos(0, 0)
	self.heroTab:SetSize(tabSheetW, tabSheetH)
	self.heroTab:SetBackgroundColor(Color(0, 0, 0, 0))

	-- Hero sheet
	self.heroSheet:SetPos(0, 0)
	self.heroSheet:SetSize(504, 250)

	-- Add hero tab
	self.addHeroTab:SetPos(0, 0)
	self.addHeroTab:SetVerticalScrollbarEnabled(true)

	-- Edit hero tab
	self.editHeroTab:SetPos(0, 0)
	self.editHeroTab:SetVerticalScrollbarEnabled(true)

	-- Hero spawn list
	self.heroSpawnList = vgui.Create("DListView", self.heroTab)
	self.heroSpawnList:SetPos(0, 250)
	self.heroSpawnList:SetSize(504, 169)
	self.heroSpawnList:SetMultiSelect(false)
	self.heroSpawnList:AddColumn("ID")
	self.heroSpawnList:AddColumn("Health")
	self.heroSpawnList:AddColumn("Model")
	self.heroSpawnList:AddColumn("NPC")
	self.heroSpawnList:AddColumn("Weapon")
	self.heroSpawnList:AddColumn("Flags")
	self.heroSpawnList:AddColumn("Squad")

	self.heroSpawnList.OnRowRightClick = function(_, num)
		chat.AddText("Right clicked "..num)
		print("heroList[num]")
		PrintTable(heroList[num])
	    local MenuButtonOptions = DermaMenu()
	    MenuButtonOptions:AddOption("Delete Row", function() 
	    	self.heroSpawnList:RemoveLine(num) 
	    	table.remove(heroList, num) 
	    	self:updateServer()
	    end)
	    MenuButtonOptions:AddOption("Edit...", function()
	    	self:editHeroListRow(num)
	    end)
	    MenuButtonOptions:Open()
	end

	self.tabSheet:AddSheet("NPCs", self.npcTab, nil, false, false, nil)
	self.tabSheet:AddSheet("Heroes", self.heroTab, nil, false, false, nil)

	self.addNPCTab._tab = self.npcSheet:AddSheet("Add", self.addNPCTab, nil, false, false, nil)
	self.editNPCTab._tab = self.npcSheet:AddSheet("Edit", self.editNPCTab, nil, false, false, nil)
	self.addHeroTab._tab = self.heroSheet:AddSheet("Add", self.addHeroTab, nil, false, false, nil)
	self.editHeroTab._tab = self.heroSheet:AddSheet("Edit", self.editHeroTab, nil, false, false, nil)

	self:drawNPCOptions(self.addNPCTab)
	self:drawNPCOptions(self.editNPCTab)
	self:drawHeroOptions(self.addHeroTab)
	self:drawHeroOptions(self.editHeroTab)
	self:disableNPCEdit(true)
	self:disableHeroEdit(true)
end

function SpawnMenu:drawNPCOptions(tab)
	if tab == self.addNPCTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddNPC()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditNPC()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Chance
	itemRow = 1
	tab.chanceLabel = vgui.Create("DLabel", tab)
	tab.chanceLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.chanceLabel:SetText("Chance:")
	tab.chanceLabel:SetDark(true)
	tab.chanceLabel:SizeToContents()
	tab.chanceLabel:SetHeight(itemH)
	tab.chanceField = vgui.Create("DNumberWang", tab)
	tab.chanceField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.chanceField:SetSize(firstColumnInputW, itemH)
	tab.chanceField:SetValue(100)
	tab.chanceField:SetMin(1)

	--Scale
	itemRow = 2
	tab.scaleLabel = vgui.Create("DLabel", tab)
	tab.scaleLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.scaleLabel:SetText("Scale:")
	tab.scaleLabel:SetDark(true)
	tab.scaleLabel:SizeToContents()
	tab.scaleLabel:SetHeight(itemH)
	tab.scaleField = vgui.Create("DNumberWang", tab)
	tab.scaleField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.scaleField:SetSize(firstColumnInputW, itemH)
	tab.scaleField:SetValue(1)
	tab.scaleField:SetMin(1)

	--Spawn flags
	itemRow = 3
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 4
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 5
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Proficiency
	itemRow = 6
	tab.proficiencyLabel = vgui.Create("DLabel", tab)
	tab.proficiencyLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.proficiencyLabel:SetText("Proficiency:")
	tab.proficiencyLabel:SetDark(true)
	tab.proficiencyLabel:SizeToContents()
	tab.proficiencyLabel:SetHeight(itemH)
	tab.proficiencyCombo = vgui.Create("DComboBox", tab)
	tab.proficiencyCombo:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.proficiencyCombo:SetSize(firstColumnInputW, itemH)
	tab.proficiencyCombo:AddChoice("Average")
	tab.proficiencyCombo:AddChoice("Good")
	tab.proficiencyCombo:AddChoice("Perfect")
	tab.proficiencyCombo:AddChoice("Poor")
	tab.proficiencyCombo:AddChoice("Very good")
	tab.proficiencyCombo:ChooseOptionID(1)

	--Damage
	itemRow = 7
	tab.damageLabel = vgui.Create("DLabel", tab)
	tab.damageLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.damageLabel:SetText("Damage multiplier:")
	tab.damageLabel:SetDark(true)
	tab.damageLabel:SizeToContents()
	tab.damageLabel:SetHeight(itemH)
	tab.damageField = vgui.Create("DNumberWang", tab)
	tab.damageField:SetMinMax(0, 5)
	tab.damageField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.damageField:SetSize(firstColumnInputW, itemH)
	tab.damageField:SetValue(1)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:drawHeroOptions(tab)
	if tab == self.addHeroTab then
		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Add")
		tab.confirmButton.DoClick = function(button)
			self:applyAddHero()
		end
	else 
		tab.editlabel = vgui.Create("DLabel", tab)
		tab.editlabel:SetPos(240, 180)
		tab.editlabel:SetText("Editing: "..tostring(self.editingHero))
		tab.editlabel:SetDark(true)
		tab.editlabel:SizeToContents()

		tab.confirmButton = vgui.Create("DButton", tab)
		tab.confirmButton:SetText("Update")
		tab.confirmButton.DoClick = function(button)
			self:applyEditHero()
		end
	end
	tab.confirmButton:SetPos(385, 160)
	tab.confirmButton:SetSize(100, 50)

	itemStartY = 10
	itemH = 20

	firstColumnItemMarginY = 4

	firstColumnLabelX = 10
	firstColumnLabelW = 100

	firstColumnInputX = firstColumnLabelX + firstColumnLabelW + 5
	firstColumnInputW = 100

	secondColumnGroupMarginY = 8
	secondColumnItemMarginY = 4

	secondColumnLabelX = firstColumnInputX + firstColumnInputW + 20
	secondColumnLabelW = 50

	secondColumnInputX = secondColumnLabelX + secondColumnLabelW + 5

	local function getYByRow(itemRow)
		return itemStartY + ((firstColumnItemMarginY + itemH) * itemRow)
	end

	local function getYByRowInGroup(groupRow, placeInGroup)
		return itemStartY + (((itemH * 2) + secondColumnGroupMarginY) * groupRow) + ((secondColumnItemMarginY + itemH) * placeInGroup)
	end

	--Health
	local itemRow = 0
	tab.healthLabel = vgui.Create("DLabel", tab)
	tab.healthLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.healthLabel:SetText("Health:")
	tab.healthLabel:SetDark(true)
	tab.healthLabel:SizeToContents()
	tab.healthLabel:SetHeight(itemH)
	tab.healthField = vgui.Create("DNumberWang", tab)
	tab.healthField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.healthField:SetSize(firstColumnInputW, itemH)

	--Spawn flags
	itemRow = 1
	tab.spawnFlagsOverrideCheckbox = vgui.Create("DCheckBoxLabel", tab)
	tab.spawnFlagsOverrideCheckbox:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsOverrideCheckbox:SetText("Override spawn flags")
	tab.spawnFlagsOverrideCheckbox:SetDark(true)
	tab.spawnFlagsOverrideCheckbox:SizeToContents()
	tab.spawnFlagsOverrideCheckbox:SetHeight(itemH)
	tab.spawnFlagsOverrideCheckbox:SetChecked(false)

	itemRow = 2
	tab.spawnFlagsLabel = vgui.Create("DLabel", tab)
	tab.spawnFlagsLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.spawnFlagsLabel:SetText("Spawn flags:")
	tab.spawnFlagsLabel:SetDark(true)
	tab.spawnFlagsLabel:SizeToContents()
	tab.spawnFlagsLabel:SetHeight(itemH)
	tab.spawnFlagsField = vgui.Create("DNumberWang", tab)
	tab.spawnFlagsField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.spawnFlagsField:SetSize(firstColumnInputW, itemH)
	tab.spawnFlagsField:SetValue(0)
	tab.spawnFlagsField:SetDisabled(true)
	tab.spawnFlagsField:SetEditable(false)

	tab.spawnFlagsOverrideCheckbox.OnChange = function(bVal)
		tab.spawnFlagsField:SetDisabled(!tab.spawnFlagsOverrideCheckbox:GetChecked())
		tab.spawnFlagsField:SetEditable(tab.spawnFlagsOverrideCheckbox:GetChecked())
	end

	--Squad
	itemRow = 3
	tab.squadLabel = vgui.Create("DLabel", tab)
	tab.squadLabel:SetPos(firstColumnLabelX, getYByRow(itemRow))
	tab.squadLabel:SetText("Squad:")
	tab.squadLabel:SetDark(true)
	tab.squadLabel:SizeToContents()
	tab.squadLabel:SetHeight(itemH)
	tab.squadField = vgui.Create("DTextEntry", tab)
	tab.squadField:SetPos(firstColumnInputX, getYByRow(itemRow))
	tab.squadField:SetSize(firstColumnInputW, itemH)

	--Model
	local groupRow = 0
	tab.modelLabel = vgui.Create("DLabel", tab)
	tab.modelLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.modelLabel:SetText("Model:")
	tab.modelLabel:SetDark(true)
	tab.modelLabel:SizeToContents()
	tab.modelCombo = vgui.Create("DComboBox", tab)
	tab.modelCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.modelCombo:SetWide(195)
	tab.modelCombo:SetValue(SpawnMenu.models[1])
	for k, v in pairs(SpawnMenu.models) do
		tab.modelCombo:AddChoice(v)
	end
	tab.modelCombo.OnSelect = function(index,value,data)
		tab.modelField:SetValue(SpawnMenu.models[value])
	end
	tab.modelField = vgui.Create("DTextEntry", tab)
	tab.modelField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.modelField:SetWide(195)

	--NPC
	groupRow = 1
	tab.npcLabel = vgui.Create("DLabel", tab)
	tab.npcLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.npcLabel:SetText("NPC:")
	tab.npcLabel:SetDark(true)
	tab.npcLabel:SizeToContents()
	tab.npcCombo = vgui.Create("DComboBox", tab)
	tab.npcCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.npcCombo:SetWide(195)
	tab.npcCombo:SetValue(SpawnMenu.npcs[1])
	for k, v in pairs(SpawnMenu.npcs) do
		tab.npcCombo:AddChoice(v)
	end
	tab.npcCombo.OnSelect = function(index,value,data)
		tab.npcField:SetValue(SpawnMenu.npcs[value])
	end
	tab.npcField = vgui.Create("DTextEntry", tab)
	tab.npcField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.npcField:SetWide(195)

	--Weapon
	groupRow = 2
	tab.weaponLabel = vgui.Create("DLabel", tab)
	tab.weaponLabel:SetPos(secondColumnLabelX, getYByRowInGroup(groupRow, 0))
	tab.weaponLabel:SetText("Weapon:")
	tab.weaponLabel:SetDark(true)
	tab.weaponLabel:SizeToContents()
	tab.weaponCombo = vgui.Create("DComboBox", tab)
	tab.weaponCombo:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 0))
	tab.weaponCombo:SetWide(195)
	tab.weaponCombo:SetValue(SpawnMenu.weapons[1])
	for k, v in pairs(SpawnMenu.weapons) do
		tab.weaponCombo:AddChoice(v)
	end
	tab.weaponCombo.OnSelect = function(index, value, data)
		tab.weaponField:SetValue(SpawnMenu.weapons[value])
	end
	tab.weaponField = vgui.Create("DTextEntry", tab)
	tab.weaponField:SetPos(secondColumnInputX, getYByRowInGroup(groupRow, 1))
	tab.weaponField:SetWide(195)
end

function SpawnMenu:show()
	self.frame:SetVisible(true)
	self.frame:MakePopup()
end

function SpawnMenu:refresh()
	if self.npcSpawnList and self.heroSpawnList and self.profileList then
		self.npcSpawnList:Clear()
		self.heroSpawnList:Clear()
		local i = 1
		for _, v in pairs(npcList) do
			self:addNPCEntry(table.Copy(v), i)
			i = i + 1
		end
		local i = 1
		for _, v in pairs(heroList) do
			self:addHeroEntry(table.Copy(v), i)
			i = i + 1
		end

		self.profileList:Clear()
		selectedLine = nil
		for _, v in pairs(profileList) do
			addedLine = self.profileList:AddLine(v)
			if v == profileName then
				selectedLine = addedLine
			end
		end
		if selectedLine then
			self.profileList:SelectItem(selectedLine)
		end
	end
end

function SpawnMenu:updateServer()
	net.Start("send_ztable_sr")
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.SendToServer()
	self:refresh()
end

function SpawnMenu:addNPCEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end
	if data["weapon_proficiency"] == "" or data["weapon_proficiency"] == nil then
		data["weapon_proficiency"] = "Average"
	end
	if tonumber(data["damage_multiplier"]) <= 0 then
		data["damage_multiplier"] = 1
	end

	self.npcSpawnList:AddLine(id, data["health"], data["chance"], data["model"], data["scale"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"], data["weapon_proficiency"], data["damage_multiplier"])
end

function SpawnMenu:addHeroEntry(data, id)
	if tonumber(data["health"]) <= 0 then
		data["health"] = "Default"
	end
	if data["model"] == "" then
		data["model"] = "None"
	end
	if data["weapon"] == "" then
		data["weapon"] = "None"
	end
	if data["overriding_spawn_flags"] == nil  or !tonumber(data["spawn_flags"]) then
		data["overriding_spawn_flags"] = false
		data["spawn_flags"] = nil
	end
	if !data["overriding_spawn_flags"] then
		data["spawn_flags"] = "Default"
	end
	if data["squad_name"] == "" or data["squad_name"] == nil then
		data["squad_name"] = "None"
	end

	self.heroSpawnList:AddLine(id, data["health"], data["model"], data["class_name"], data["weapon"], data["spawn_flags"], data["squad_name"])
end

function SpawnMenu:disableNPCEdit(disable)
	self.editNPCTab.healthField:SetDisabled(disable)
	self.editNPCTab.chanceField:SetDisabled(disable)
	self.editNPCTab.modelField:SetDisabled(disable)
	self.editNPCTab.scaleField:SetDisabled(disable)
	self.editNPCTab.npcField:SetDisabled(disable)
	self.editNPCTab.weaponField:SetDisabled(disable)
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editNPCTab.spawnFlagsField:SetDisabled(disable)
	self.editNPCTab.confirmButton:SetDisabled(disable)
	self.editNPCTab.modelCombo:SetDisabled(disable)
	self.editNPCTab.npcCombo:SetDisabled(disable)
	self.editNPCTab.weaponCombo:SetDisabled(disable)
	self.editNPCTab.squadField:SetDisabled(disable)
	self.editNPCTab.proficiencyCombo:SetDisabled(disable)
	self.editNPCTab.damageField:SetDisabled(disable)

	self.editNPCTab.healthField:SetEditable(!disable)
	self.editNPCTab.chanceField:SetEditable(!disable)
	self.editNPCTab.modelField:SetEditable(!disable)
	self.editNPCTab.scaleField:SetEditable(!disable)
	self.editNPCTab.npcField:SetEditable(!disable)
	self.editNPCTab.weaponField:SetEditable(!disable)
	self.editNPCTab.spawnFlagsField:SetEditable(!disable)
	self.editNPCTab.damageField:SetEditable(!disable)
end

function SpawnMenu:disableHeroEdit(disable)
	self.editHeroTab.healthField:SetDisabled(disable)
	self.editHeroTab.modelField:SetDisabled(disable)
	self.editHeroTab.npcField:SetDisabled(disable)
	self.editHeroTab.weaponField:SetDisabled(disable)
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetDisabled(disable)
	self.editHeroTab.spawnFlagsField:SetDisabled(disable)
	self.editHeroTab.confirmButton:SetDisabled(disable)
	self.editHeroTab.modelCombo:SetDisabled(disable)
	self.editHeroTab.npcCombo:SetDisabled(disable)
	self.editHeroTab.weaponCombo:SetDisabled(disable)
	self.editHeroTab.squadField:SetDisabled(disable)

	self.editHeroTab.healthField:SetEditable(!disable)
	self.editHeroTab.modelField:SetEditable(!disable)
	self.editHeroTab.npcField:SetEditable(!disable)
	self.editHeroTab.weaponField:SetEditable(!disable)
	self.editHeroTab.spawnFlagsField:SetEditable(!disable)
end

function SpawnMenu:applyEditNPC()
	npcList[self.editingNPC]["health"] = self.editNPCTab.healthField:GetValue()
	npcList[self.editingNPC]["chance"] = self.editNPCTab.chanceField:GetValue()
	npcList[self.editingNPC]["model"] = self.editNPCTab.modelField:GetValue()
	npcList[self.editingNPC]["scale"] = self.editNPCTab.scaleField:GetValue()
	npcList[self.editingNPC]["class_name"] = self.editNPCTab.npcField:GetValue()
	npcList[self.editingNPC]["weapon"] = self.editNPCTab.weaponField:GetValue()
	npcList[self.editingNPC]["overriding_spawn_flags"] = self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		npcList[self.editingNPC]["spawn_flags"] = self.editNPCTab.spawnFlagsField:GetValue()
	else
		npcList[self.editingNPC]["spawn_flags"] = nil
	end
	npcList[self.editingNPC]["squad_name"] = self.editNPCTab.squadField:GetValue()
	if !self.editNPCTab.proficiencyCombo:GetSelected() then
		npcList[self.editingNPC]["weapon_proficiency"] = "Average"
	else
		npcList[self.editingNPC]["weapon_proficiency"] = self.editNPCTab.proficiencyCombo:GetSelected()
	end
	npcList[self.editingNPC]["damage_multiplier"] = self.editNPCTab.damageField:GetValue()
	self.npcSpawnList:RemoveLine(self.editingNPC)
	self:addNPCEntry(table.Copy(npcList[self.editingNPC]), self.editingNPC)
	self.editingNPC = nil
	self.editNPCTab.editlabel:SetText("Editing: nil")
	self:disableNPCEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddNPC()
	local new = {}
	new["health"] = self.addNPCTab.healthField:GetValue()
	new["chance"] = self.addNPCTab.chanceField:GetValue()
	new["model"] = self.addNPCTab.modelField:GetValue()
	new["scale"] = self.addNPCTab.scaleField:GetValue()
	new["class_name"] = self.addNPCTab.npcField:GetValue()
	new["weapon"] = self.addNPCTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addNPCTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addNPCTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addNPCTab.squadField:GetValue()
	if !self.addNPCTab.proficiencyCombo:GetSelected() then
		new["weapon_proficiency"] = "Average"
	else
		new["weapon_proficiency"] = self.addNPCTab.proficiencyCombo:GetSelected()
	end
	new["damage_multiplier"] = self.addNPCTab.damageField:GetValue()
	table.insert(npcList, new)
	self:addNPCEntry(table.Copy(new), table.Count(npcList))
	self:updateServer()
end

function SpawnMenu:applyEditHero()
	heroList[self.editingHero]["health"] = self.editHeroTab.healthField:GetValue()
	heroList[self.editingHero]["model"] = self.editHeroTab.modelField:GetValue()
	heroList[self.editingHero]["class_name"] = self.editHeroTab.npcField:GetValue()
	heroList[self.editingHero]["weapon"] = self.editHeroTab.weaponField:GetValue()
	heroList[self.editingHero]["overriding_spawn_flags"] = self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		heroList[self.editingHero]["spawn_flags"] = self.editHeroTab.spawnFlagsField:GetValue()
	else
		heroList[self.editingHero]["spawn_flags"] = nil
	end
	heroList[self.editingHero]["squad_name"] = self.editHeroTab.squadField:GetValue()
	self.heroSpawnList:RemoveLine(self.editingHero)
	self:addHeroEntry(table.Copy(heroList[self.editingHero]), self.editingHero)
	self.editingHero = nil
	self.editHeroTab.editlabel:SetText("Editing: nil")
	self:disableHeroEdit(true)
	self:updateServer()
end

function SpawnMenu:applyAddHero()
	local new = {}
	new["health"] = self.addHeroTab.healthField:GetValue()
	new["model"] = self.addHeroTab.modelField:GetValue()
	new["class_name"] = self.addHeroTab.npcField:GetValue()
	new["weapon"] = self.addHeroTab.weaponField:GetValue()
	new["overriding_spawn_flags"] = self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked()
	if self.addHeroTab.spawnFlagsOverrideCheckbox:GetChecked() then
		new["spawn_flags"] = self.addHeroTab.spawnFlagsField:GetValue()
	else
		new["spawn_flags"] = nil
	end
	new["squad_name"] = self.addHeroTab.squadField:GetValue()
	table.insert(heroList, new)
	self:addHeroEntry(table.Copy(new), table.Count(heroList))
	self:updateServer()
end

function SpawnMenu:editNPCListRow(num)
	self.editingNPC = num
	self:disableNPCEdit(false)
	self.editNPCTab.editlabel:SetText("Editing: "..tostring(self.editingNPC))
	self.npcSheet:SetActiveTab(self.editNPCTab._tab.Tab)

	self.editNPCTab.healthField:SetText(npcList[num]["health"])
	self.editNPCTab.chanceField:SetText(npcList[num]["chance"])
	self.editNPCTab.modelField:SetText(npcList[num]["model"])
	self.editNPCTab.scaleField:SetText(npcList[num]["scale"])
	self.editNPCTab.npcField:SetText(npcList[num]["class_name"])
	self.editNPCTab.weaponField:SetText(npcList[num]["weapon"])
	self.editNPCTab.spawnFlagsOverrideCheckbox:SetChecked(npcList[num]["overriding_spawn_flags"])
	if not npcList[num]["spawn_flags"] or !tonumber(npcList[num]["spawn_flags"]) then
		self.editNPCTab.spawnFlagsField:SetText("")
	else
		self.editNPCTab.spawnFlagsField:SetText(npcList[num]["spawn_flags"])
	end
	self.editNPCTab.spawnFlagsField:SetDisabled(!self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.spawnFlagsField:SetEditable(self.editNPCTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editNPCTab.squadField:SetText(npcList[num]["squad_name"])

	local proficiency = npcList[num]["weapon_proficiency"]
	if proficiency == "Average" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(1)
	elseif proficiency == "Good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(2)
	elseif proficiency == "Perfect" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(3)
	elseif proficiency == "Poor" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(4)
	elseif proficiency == "Very good" then
		self.editNPCTab.proficiencyCombo:ChooseOptionID(5)
	end

	self.editNPCTab.damageField:SetText(npcList[num]["damage_multiplier"])
end

function SpawnMenu:editHeroListRow(num)
	self.editingHero = num
	self:disableHeroEdit(false)
	self.editHeroTab.editlabel:SetText("Editing: "..tostring(self.editingHero))
	self.heroSheet:SetActiveTab(self.editHeroTab._tab.Tab)

	self.editHeroTab.healthField:SetText(heroList[num]["health"])
	self.editHeroTab.modelField:SetText(heroList[num]["model"])
	self.editHeroTab.npcField:SetText(heroList[num]["class_name"])
	self.editHeroTab.weaponField:SetText(heroList[num]["weapon"])
	self.editHeroTab.spawnFlagsOverrideCheckbox:SetChecked(heroList[num]["overriding_spawn_flags"])
	if not heroList[num]["spawn_flags"] or !tonumber(heroList[num]["spawn_flags"]) then
		self.editHeroTab.spawnFlagsField:SetText("")
	else
		self.editHeroTab.spawnFlagsField:SetText(heroList[num]["spawn_flags"])
	end
	self.editHeroTab.spawnFlagsField:SetDisabled(!self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.spawnFlagsField:SetEditable(self.editHeroTab.spawnFlagsOverrideCheckbox:GetChecked())
	self.editHeroTab.squadField:SetText(heroList[num]["squad_name"])
end



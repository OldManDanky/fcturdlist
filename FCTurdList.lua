-- Define the turds variable as a mapping list
local turds = {
    ["Arcadia"] = "Pure PoS",
    ["Epoxy"] = "Doesn't know how to sunder.",
    ["Lulmode"] = "Trying to scam gold with Gift Cards",
    ["Hustlerrs"] = "100% Dumbass",
    ["Wejamin"] = "Left because SR didn't drop",
    ["Ishootthangs"] = "Idiot",
    ["Neythris"] = "Left after wipe",
    ["Ebayadin"] = "Refused to heal",
    ["Bcre"] = "Situationally Unaware",
    ["Msskippa"] = "MOFO",
    ["Adreliana"] = "Trash Bear Tank",
    ["Unrestrain"] = "Pagle Turd",
    ["Excesos"] = "Total Turd",
    ["Amburhurd"] = "Pagle Turd",
    ["Lilbonk"] = "Turd",
    ["Gojøsatoru"] = "Tank Turd",
    ["Tankenchh"] = "Tank Turd",
    ["Agreei"] = "Refused to join Discord for Raid",
    ["Dustdry"] = "Ninja",
    ["Playedonce"] = "Troll Tank",
    ["Gazoo"] = "Wiped Immortal Run Troll",
    ["Oldmanshooty"] = "testing",
    ["Alethius"] = "testing"
}

-- Function to show a popup notification
local function ShowPopupNotification(message)
    StaticPopupDialogs["TURD_NOTIFICATION"] = {
        text = message,
        button1 = "Close",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }
    StaticPopup_Show("TURD_NOTIFICATION")
end

-- Function to show a popup window with turds list
local function ShowTurdsPopup()
    local turdsList = "Turds List:\n"
    for playerName, turdReason in pairs(turds) do
        turdsList = turdsList .. playerName .. " - " .. turdReason .. "\n"
    end

    local frame = CreateFrame("Frame", "TurdsPopupFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(300, 200)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    frame.Title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.Title:SetPoint("TOP", frame, "TOP", 0, -5)
    frame.Title:SetText("Turds List")

    frame.ScrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    frame.ScrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -30)
    frame.ScrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 10)

    frame.Content = CreateFrame("Frame", nil, frame.ScrollFrame)
    frame.Content:SetSize(260, 200)
    frame.ScrollFrame:SetScrollChild(frame.Content)

    local yOffset = -5
    for playerName, turdReason in pairs(turds) do
        local turdText = frame.Content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        turdText:SetPoint("TOPLEFT", frame.Content, "TOPLEFT", 5, yOffset)
        turdText:SetText(playerName .. " - " .. turdReason)
        yOffset = yOffset - 15
    end

    frame:Show()
end

-- Function to check for turds in the current party and display notification or message
local function CheckPartyTurds()
    local turdsFound = false
    local numGroupMembers = GetNumGroupMembers()
    for i = 1, numGroupMembers do
        local playerName = GetUnitName("party" .. i, true)
        local turdReason = turds[playerName]
        if playerName and turdReason then
            ShowPopupNotification("FC Turd found: " .. playerName .. " - " .. turdReason)
            turdsFound = true
        end
    end
    if not turdsFound then
        ShowPopupNotification("No turds found in your current party.")
    end
end

-- Function to check for turds in the current raid or party and display notification or message
local function CheckGroupTurds()
    local turdsFound = false
    if IsInGroup() then
        local numGroupMembers = GetNumGroupMembers()
        for i = 1, numGroupMembers do
            local playerName = GetUnitName("party" .. i, true)
            local turdReason = turds[playerName]
            if playerName and turdReason then
                ShowPopupNotification("FC Turd found: " .. playerName .. " - " .. turdReason)
                turdsFound = true
            end
        end
    end
    if not turdsFound then
        ShowPopupNotification("No turds found in your current party.")
    end
end

-- Slash command to show the turds popup
SLASH_TURDS1 = "/turds"
SlashCmdList["TURDS"] = function()
    ShowTurdsPopup()
end

-- Slash command to check for turds in the current party
SLASH_CHECKPARTY1 = "/checkparty"
SlashCmdList["CHECKPARTY"] = function()
    CheckPartyTurds()
end

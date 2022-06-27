ColorOptions = {
    colorButtons = {},

    loadButton = nil,
    saveButton = nil,
    importThemeStringButton = nil,
    exportThemeStringButton = nil,
    presetButton = nil,
    restoreDefaults = nil,
    closeButton = nil,
    toggleMoveColorButton = nil,
    
    mainButtons = nil,

    constants = {
        X_OFFSET = 150,
        COLOR_OPTION_BOX_X = GraphicConstants.SCREEN_WIDTH+GraphicConstants.BORDER_MARGIN + 150,
        COLOR_OPTION_BOX_Y = GraphicConstants.BORDER_MARGIN,
        COLOR_OPTION_HEIGHT = GraphicConstants.SCREEN_HEIGHT - (2 * GraphicConstants.BORDER_MARGIN) + 112,
        COLOR_OPTION_WIDTH = GraphicConstants.RIGHT_GAP - (2 * GraphicConstants.BORDER_MARGIN),
        BUTTON_MARGIN = 8,
        BUTTON_HEIGHT = 12,
        COLOR_BUTTON_HEIGHT_WIDTH = 9,
        COLOR_BUTTON_Y_START = 40,
    }
}

function ColorOptions.initializeButtons()
   ColorOptions.initializeMainButtons()
   ColorOptions.initializeColorButtons()
end

function ColorOptions.initializeMainButtons()
    ColorOptions.loadButton = {
        text = "Load theme",
        box = {
            ColorOptions.constants.COLOR_OPTION_BOX_X + ColorOptions.constants.BUTTON_MARGIN + 67,
            ColorOptions.constants.COLOR_OPTION_BOX_Y + ColorOptions.constants.BUTTON_MARGIN,
            54,
            ColorOptions.constants.BUTTON_HEIGHT
        },
        backgroundColor = { "Bottom box border color", "Bottom box background color" },
        onclick = ColorOptions.onLoadClick
    }
    ColorOptions.saveButton = {
        text = "Save theme",
        box = {
            ColorOptions.constants.COLOR_OPTION_BOX_X + ColorOptions.constants.BUTTON_MARGIN+3,
            ColorOptions.constants.COLOR_OPTION_BOX_Y + ColorOptions.constants.BUTTON_MARGIN,
            54,
            ColorOptions.constants.BUTTON_HEIGHT
        },
        backgroundColor = { "Bottom box border color", "Bottom box background color" },
        onclick = ColorOptions.onSaveClick
    }
    ColorOptions.restoreDefaults = {
        text = "Restore Defaults",
        box = {
            ColorOptions.constants.COLOR_OPTION_BOX_X + ColorOptions.constants.BUTTON_MARGIN,
            ColorOptions.constants.COLOR_OPTION_BOX_Y + ColorOptions.constants.COLOR_OPTION_HEIGHT - 6,
            73,
            ColorOptions.constants.BUTTON_HEIGHT
        },
        backgroundColor = { "Bottom box border color", "Bottom box background color" },
        onclick = ColorOptions.onRestoreDefaultsClick
    }
    ColorOptions.loadThemeStringButton = {
        text = "Import theme string",
        box = {
            ColorOptions.constants.COLOR_OPTION_BOX_X + ColorOptions.constants.BUTTON_MARGIN,
            ColorOptions.constants.COLOR_OPTION_BOX_Y + ColorOptions.constants.COLOR_OPTION_HEIGHT - 34,
            86,
            ColorOptions.constants.BUTTON_HEIGHT
        },
        backgroundColor = { "Bottom box border color", "Bottom box background color" },
        onclick = ColorOptions.onImportThemeClick
    }
    ColorOptions.exportThemeStringButton = {
        text = "Export theme string",
        box = {
            ColorOptions.constants.COLOR_OPTION_BOX_X + ColorOptions.constants.BUTTON_MARGIN,
            ColorOptions.constants.COLOR_OPTION_BOX_Y + ColorOptions.constants.COLOR_OPTION_HEIGHT - 50,
            86,
            ColorOptions.constants.BUTTON_HEIGHT
        },
        backgroundColor = { "Bottom box border color", "Bottom box background color" },
        onclick = ColorOptions.onExportThemeClick
    }
    ColorOptions.closeButton = {
        text = "Close",
        box = {
            ColorOptions.constants.COLOR_OPTION_BOX_X + ColorOptions.constants.BUTTON_MARGIN + 91,
            ColorOptions.constants.COLOR_OPTION_BOX_Y + ColorOptions.constants.COLOR_OPTION_HEIGHT - 6,
            29,
            ColorOptions.constants.BUTTON_HEIGHT
        },
        backgroundColor = { "Bottom box border color", "Bottom box background color" },
        onclick = ColorOptions.onCloseClick
    }
    ColorOptions.toggleMoveColorButton = {
            text = "Color move names by type",
            box = {
                ColorOptions.constants.COLOR_OPTION_BOX_X + ColorOptions.constants.BUTTON_MARGIN+1,
                ColorOptions.constants.COLOR_OPTION_BOX_Y + 178,
                8,
                8
            },
            backgroundColor = {0xFF000000, "Bottom box background color" },
            textColor = "Default text color",
            optionColor = "Positive text color",
            optionState = Settings.ColorSettings.Colored_move_names,
            onclick = function(self) 
                ColorOptions.redraw = true
                Settings.ColorSettings.Colored_move_names = not(Settings.ColorSettings.Colored_move_names)
                self.optionState = not (self.optionState)
                INI.save("Settings.ini", Settings)
            end
    }
    ColorOptions.toggleShadowsButton = {
        text = "Draw shadows",
        box = {
            ColorOptions.constants.COLOR_OPTION_BOX_X + ColorOptions.constants.BUTTON_MARGIN+1,
            ColorOptions.constants.COLOR_OPTION_BOX_Y + 188,
            8,
            8
        },
        backgroundColor = {0xFF000000, "Bottom box background color" },
        textColor = "Default text color",
        optionColor = "Positive text color",
        optionState = Settings.ColorSettings.Draw_shadows,
        onclick = function(self) 
            Settings.ColorSettings.Draw_shadows = not(Settings.ColorSettings.Draw_shadows)
            self.optionState = not (self.optionState)
            ColorOptions.redraw = true
            INI.save("Settings.ini", Settings)
        end
}
    ColorOptions.mainButtons = {ColorOptions.loadButton,ColorOptions.saveButton,ColorOptions.presetButton,
                                ColorOptions.restoreDefaults,ColorOptions.closeButton, ColorOptions.loadThemeStringButton,
                                ColorOptions.exportThemeStringButton}
end

function ColorOptions.onImportThemeClick()
    ThemeForms.createImportThemeForm()
end

function ColorOptions.onExportThemeClick()
    ThemeForms.createExportThemeForm()
end

function ColorOptions.initializeColorButtons()
    local colors = GraphicConstants.layoutColors
    local orderedKeys = GraphicConstants.layoutColorKeysOrdered
    local i = 0
    for _,colorName in ipairs(orderedKeys) do
        local colorValue = colors[colorName]
        local colorButton = ColorOptions.createColorButton(i,colorName,colorValue)
        table.insert(ColorOptions.colorButtons,colorButton)
        i = i + 1
    end
end

function ColorOptions.createColorButton(index,colorName,colorValue)
    --Color button consists of the button and the text.
    local colorButton = {
        text = colorName,
        colorName = colorName,
        color = colorValue,
        box = {
            ColorOptions.constants.COLOR_OPTION_BOX_X + ColorOptions.constants.BUTTON_MARGIN,
            ColorOptions.constants.COLOR_BUTTON_Y_START + index * (ColorOptions.constants.COLOR_BUTTON_HEIGHT_WIDTH+2),
            ColorOptions.constants.COLOR_BUTTON_HEIGHT_WIDTH,
            ColorOptions.constants.COLOR_BUTTON_HEIGHT_WIDTH
        },
        backgroundColor = {"Bottom box border color",colorName}
    }
    return colorButton
end

function ColorOptions.onLoadClick()
    ThemeForms.createLoadThemeForm()
end

function ColorOptions.onSaveClick()
    ThemeForms.createSaveThemeForm()
end

function ColorOptions.onRestoreDefaultsClick()
    GraphicConstants.restoreDefaults()
    ColorOptions.redraw = true
    GraphicConstants.saveSettings()
end

function ColorOptions.onCloseClick()
    client.SetGameExtraPadding(0, GraphicConstants.UP_GAP, GraphicConstants.RIGHT_GAP, GraphicConstants.DOWN_GAP)
    Program.state = State.SETTINGS
    Options.redraw = true
end

ColorOptions.redraw = true









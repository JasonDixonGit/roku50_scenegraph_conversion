Function Init()
'    ? "Init - [MenuScreen]"
    m.top.observeField("visible", "onVisibleChange")
    m.buttons = m.top.findNode("MenuButtons")
    setButtonListProperties(m)
End Function

Function setButtonListProperties(m)
    m.buttons.font = "font:LargeSystemFont"
    m.buttons.font.size = m.buttons.font.size+24
    m.buttons.focusedFont = "font:LargeBoldSystemFont"
    m.buttons.focusedFont.size = m.buttons.focusedFont.size+32
End Function

' set proper focus to buttons if opening or returning to this screen
Sub onVisibleChange()
    'change font to appFont'
    m.buttons.font.uri = m.top.font
    m.buttons.focusedFont.uri = m.top.font
    if m.top.visible = true then
        'setButtonListProperties(m)
        m.buttons.setFocus(true)
    end if
End Sub

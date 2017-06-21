Function Init()
''    ? "Init - [ExitScreen]"
    m.top.observeField("visible", "onVisibleChange")
    m.exitbuttons = m.top.findNode("ExitButtons")
    setButtonListProperties(m)
    m.top.exitFlag = false
    m.top.cancelFlag = false
End Function

Function setButtonListProperties(m)
    m.exitbuttons.font = "font:LargeSystemFont"
    m.exitbuttons.font.size = m.exitbuttons.font.size+28
    m.exitbuttons.focusedFont = "font:LargeSystemFont"
    m.exitbuttons.focusedFont.size = m.exitbuttons.focusedFont.size+28
End Function

' set proper focus to buttons if opening or returning to this screen
Sub onVisibleChange()
    m.exitbuttons.font.uri = m.top.font
    m.exitbuttons.focusedFont.uri = m.top.font
    if m.top.visible = true then
        m.exitbuttons.setFocus(true)
    end if
End Sub

Sub OnExitItemSelected()
    m.itemSelected = m.top.exitItemSelected
    if(m.itemSelected = 0)
        ?"exit"
        m.top.exitFlag = true
    else if(m.itemSelected = 1)
        ?"cancel"
        m.top.cancelFlag = true
    end if
End Sub
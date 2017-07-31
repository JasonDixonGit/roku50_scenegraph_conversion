Function Init()
''    ? "Init - [DetailsScreen]"

    m.top.observeField("visible", "onVisibleChange")
    m.top.observeField("focusedChild", "OnFocusedChildChange")

    m.poster            =   m.top.findNode("Poster")
    m.description       =   m.top.findNode("Description")
    m.background        =   m.top.findNode("Background")

End Function

Function OnReady()
    if(m.top.ready = true) then

    end if
end function


' set proper focus to buttons if Details opened and stops Video if Details closed
Sub onVisibleChange()

    if m.top.visible = true then
        ?"VISIBLE"

        for each title in m.top.content.actors
            Print title
        next
    end if
End Sub

' on Button press handler -- ready must = true for action
Sub onItemSelected()
    
End Sub

' Content change handler
Sub OnContentChange()

End Sub
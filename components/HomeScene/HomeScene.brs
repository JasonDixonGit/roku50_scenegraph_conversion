Function Init()

    ' GridScreen node with RowList
    m.gridScreen               = m.top.findNode("GridScreen")

    ' DetailsScreen Node with description, Video Player
    m.detailsScreen            = m.top.findNode("DetailsScreen")

End Function

' if content set, focus on GridScreen
Function OnChangeContent()
    m.gridScreen.setFocus(true)
    m.gridscreen.isLoaded = true
End Function

' Row item selected handler
Function OnRowItemSelected()
    'm.gridScreen.visible = false
    m.detailsScreen.content = m.gridScreen.focusedContent
    m.detailsScreen.itemID  = m.gridscreen.focusedContent.id
    m.detailsScreen.origin  = "gridscreen"
    m.detailsScreen.ready = false
    m.gridScreen.visible = false
    m.detailsScreen.visible = true
    m.detailsScreen.setFocus(true)
End Function

' Main Remote keypress event loop
Function OnKeyEvent(key, press) as Boolean
    result = false
    if press then
        'print(key)

        if key = "back"
            
            'catch back press while loading main gridscreen'
            if(m.gridscreen.visible = true and m.gridscreen.isLoaded = false) then
                ?"1 - caught"
                result = true

            else if(m.detailsScreen.visible = true)

                m.detailsScreen.visible = false
                m.gridscreen.setFocus(true)
                m.gridScreen.visible = true
                result = true                    

            else
                ?"ERROR -- CATCH BACK-BUTTON CASE HIT"
                result = false
            end if
        end if
    end if
    return result
End Function

'function SetAppColors()

'end function

'function SetAppFont()

'end Function

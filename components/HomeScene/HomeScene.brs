Function Init()
    ' loading indicator starts at initialization of channel
    m.loadingIndicator         = m.top.findNode("loadingIndicator")
    m.loadingIndicator.control = "stop"
    m.loadingIndicator.visible = false

    ' GridScreen node with RowList
    m.gridScreen               = m.top.findNode("GridScreen")

    'MenuScreen'
    m.menuScreen               = m.top.findNode("MenuScreen")

    ' DetailsScreen Node with description, Video Player
    m.detailsScreen            = m.top.findNode("DetailsScreen")

    'Exit Screen'
    m.exitScreen               = m.top.findNode("ExitScreen")

End Function

' if content set, focus on GridScreen
Function OnChangeContent()
    SetAppColors()
    SetAppFont()
    m.loadingIndicator.control = "stop"
    m.gridScreen.setFocus(true)
    m.gridscreen.isLoaded = true
    m.loadingIndicator.visible = true
    ?"*** OnChangeContent Complete ***"
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

Function OnCancelFlagChange()
    if(m.exitScreen.cancelFlag = true) then
        m.exitScreen.visible = false
        m.gridscreen.setFocus(true)
        m.gridscreen.visible = true
        m.exitScreen.cancelFlag = false
    end if
end function

Function OnMenuSelected()
    m.gridScreen.visible = false
    m.menuScreen.setFocus(true)
    m.menuScreen.visible = true
end function

Function onMenuItemSelected()
    'first button is myLists
    if m.top.menuItemSelected = 0
        m.menuScreen.visible = false
        m.myListsScreen.visible = true
        m.myListsScreen.setFocus(true)

    'second button is search
    else if m.top.menuItemSelected = 1
        m.menuScreen.visible = false
        m.searchScreen.visible = true
        m.searchScreen.setFocus(true)

    'third button is Browse
    else if m.top.menuItemSelected = 2
        m.browseScreen.visible = true
        m.browseScreen.setFocus(true)
        m.menuScreen.visible = false

    'fourth button is Performers
    else if m.top.menuItemSelected = 3
       m.BrowsePerformersScreen.visible = true
       m.BrowsePerformersScreen.setFocus(true)
       m.menuScreen.visible = false

    'fifth button is Settings
    else if m.top.menuItemSelected = 4
        m.menuScreen.visible = false
        m.settingsScreen.visible = true
        m.settingsScreen.setFocus(true)

    end if
End Function

' Main Remote keypress event loop
Function OnKeyEvent(key, press) as Boolean
    result = false
    if press then
        'print(key)

        if key = "back"

            if(m.loadingIndicator.control = "start") then
                ?"caught - li running"
                result = true
            
            'catch back press while loading main gridscreen'
            else if(m.gridscreen.visible = true and m.gridscreen.isLoaded = false) then
                ?"1 - caught"
                result = true

            'restrict user from using back button to exit on exit screen - force button use'
            else if(m.exitScreen.visible = true) then
                'do nothing
                result = true

            ' if movie video player is open
            else if m.detailsScreen.videoPlayerVisible = true
                m.detailsScreen.videoPlayerVisible = false
                m.detailsScreen.videoPlayerState = "finished"
                m.detailsScreen.setFocus(true)
                result = true
 
            'if gridscreen is open, show exitScreen'
            else if(m.gridscreen.visible = true) then
                m.gridScreen.visible = false
                m.exitScreen.setFocus(true)
                m.exitScreen.visible = true
                result = true

            'if menuScreen is opened'
            else if(m.menuScreen.visible = true) then
                m.gridscreen.visible = true
                m.menuScreen.visible = false
                m.gridScreen.setFocus(true)
                result = true

            'if Details opened -- return to originating screen via m.detailsScreen.origin value
            else if(m.detailsScreen.visible = true and m.detailsScreen.videoPlayerVisible = false and m.detailsScreen.ready = true) then
                m.detailsScreen.WatchLaterFlagAction = ""

                'reset isPreview flag'
                if(m.detailsScreen.preview = true) then
                    m.detailsScreen.preview = false
                end if

                'return to gridscreen'
                'if(m.detailsScreen.origin = "gridscreen") then
                        '?"exiting"
                        m.detailsScreen.visible = false
                        m.gridscreen.setFocus(true)
                        m.gridScreen.visible = true
                        result = true                    
                'end if

            else
                ?"ERROR -- CATCH BACK-BUTTON CASE HIT"
                result = false
            end if
        end if
    end if
    return result
End Function

function SetAppColors()
    m.menuScreen.buttonsFocusedColor            = m.top.globalFocusedColor
    m.gridscreen.rowLabelColor                  = m.top.globalSecondaryColor
    m.detailsScreen.buttonsFocusedColor         = m.top.globalFocusedColor
    m.detailsScreen.VideoPlayerColor            = m.top.globalVideoPlayerBarColor
    m.exitScreen.buttonsFocusedColor            = m.top.globalFocusedColor
end function

function SetAppFont()
    m.menuScreen.font                           = m.top.globalFontPath
    m.gridScreen.font                           = m.top.globalFontPath
    m.detailsScreen.font                        = m.top.globalFontPath
    m.exitScreen.font                           = m.top.globalFontPath
end Function

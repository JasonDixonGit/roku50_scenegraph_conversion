 ' inits grid screen
 ' creates all children
 ' sets all observers
Function Init()
    ''? "Init - [HomeScene]"
    ' loading indicator starts at initialization of channel
    m.loadingIndicator         = m.top.findNode("loadingIndicator")
    m.loadingIndicator.control = "stop"
    m.loadingIndicator.visible = false

    ' GridScreen node with RowList
    m.gridScreen               = m.top.findNode("GridScreen")

    'MenuScreen'
    m.menuScreen               = m.top.findNode("MenuScreen")

    'Menu Sub-Screens'
    m.myListsScreen            = m.top.findNode("MyListsScreen")
    m.searchScreen             = m.top.findNode("SearchScreen")
    m.browseScreen             = m.top.findNode("BrowseScreen")
    m.BrowsePerformersScreen    = m.top.findNode("BrowsePerformersScreen")
    m.settingsScreen           = m.top.findNode("SettingsScreen")

    'Settings Sub-Screens'
    m.feedbackandsupportscreen = m.top.findNode("feedbackandsupportscreen")
    m.legalnoticesscreen       = m.top.findNode("legalnoticesscreen")
    m.parentalcontrolscreen    = m.top.findNode("parentalcontrolscreen")

    ' DetailsScreen Node with description, Video Player
    m.detailsScreen            = m.top.findNode("DetailsScreen")

    'DetailsScreen Sub-Screen -- SceneList GridScreen'
    m.scenesGridScreen         = m.top.findNode("ScenesGridScreen")

    'Scene Detail Screen'
    m.sceneDetailsScreen       = m.top.findNode("SceneDetailsScreen")

    'Performer GridScreen'
    m.performerGridScreen      = m.top.findNode("PerformerGridScreen")

    'literal search results screen'
    m.literalSearchScreen     = m.top.findNode("LiteralSearchScreen")

    'parental Control Pin screen'
    m.parentalPin              = m.top.findNode("ParentalPin")

    'Exit Screen'
    m.exitScreen               = m.top.findNode("ExitScreen")

    'movie categories gridscreen'
    m.movieCategoriesScreen    = m.top.findNode("MovieCategoriesScreen")

    m.sceneTagsScreen          = m.top.findNode("SceneTagsScreen")

    m.video = m.top.findNode("VideoPlayer")

    m.video.observeField("state", "OnLoadingVideoComplete")

    'show user logged in'
    m.settingsScreen.logout = false

    'default setting'
    m.top.newParentalPinSet = false

    m.emptyContent = getEmptyContentObject()
End Function

Function OnLoadingVideoComplete()
    if m.video.state="finished" then
        m.video.visible = false
        m.video.control="stop"
        SetAppColors()
        SetAppFont()
    end if
end function
' if content set, focus on GridScreen
Function OnChangeContent()
    m.top.logoVisiblity = "true"   '<--- note that these were moved from the block above'
    m.gridScreen.MenuLabelVisibility = "true"    '<--- note that these were moved from the block above'
    m.loadingIndicator.control = "stop"
    m.gridScreen.setFocus(true)
    m.gridscreen.isLoaded = true
    m.loadingIndicator.visible = true '********************************************'
End Function

' if content set, focus on GridScreen
Function OnBrowseChangeContent()
    m.browseScreen.setFocus(true)
    m.browseScreen.isLoaded = true
    'm.loadingIndicator.control = "stop"
End Function

' if content set, focus on GridScreen
Function OnBrowsePerformersScreenChangeContent()
    m.BrowsePerformersScreen.setFocus(true)
    m.BrowsePerformersScreen.isLoaded = true
    'm.loadingIndicator.control = "stop"
End Function

' if content set, focus on GridScreen
Function OnPerformerChangeContent()
    m.browseScreen.setFocus(true)
    m.browseScreen.isLoaded = true
    'm.loadingIndicator.control = "stop"
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

' Row item selected handler
Function OnSceneClipItemSelected()
    'm.scenesGridScreen.visible = false
    '?"errorStart"
    m.sceneDetailsScreen.content = m.GridScreen.focusedContent
    '?"errorEnd"
    m.sceneDetailsScreen.sceneID  = m.GridScreen.focusedContent.EpisodeNumber
    m.sceneDetailsScreen.itemID = m.GridScreen.focusedContent.id
    m.sceneDetailsScreen.origin = "gridscreen"
    m.gridScreen.visible = false
    m.sceneDetailsScreen.visible = true
    m.sceneDetailsScreen.setFocus(true)
End Function

function OnGridscreenPerformerRowItemSelected()
    m.performerGridScreen.origin = "gridscreen"
    m.performerGridScreen.isLoaded = false
    m.gridScreen.visible = false
    m.performerGridScreen.visible = true
    m.performerGridScreen.setFocus(true)
end function

'Browse Row item selected handler
Function OnBrowseRowItemSelected()
    'm.browseScreen.visible  = false
    m.detailsScreen.content = m.browseScreen.focusedContent
    m.detailsScreen.itemID  = m.browseScreen.focusedContent.id
    m.detailsScreen.origin  = "browseScreen"
    m.detailsScreen.ready = false
    m.detailsScreen.setFocus(true)
    m.detailsScreen.visible = true
    m.browseScreen.visible  = false
End Function

function OnBrowseSceneRowItemSelected()
    m.sceneDetailsScreen.content = m.browseScreen.focusedContent
    m.sceneDetailsScreen.sceneID = m.browseScreen.focusedContent.id'm.browseScreen.focusedContent.EpisodeNumber
    m.sceneDetailsScreen.itemID  = m.browseScreen.focusedContent.id
    m.sceneDetailsScreen.origin  = "browseScreen"
    m.sceneDetailsScreen.ready = false
    m.browseScreen.visible = false
    m.sceneDetailsScreen.visible = true
    m.sceneDetailsScreen.setFocus(true)  
end function

function OnBrowsePerformerItemSelected()
    m.performerGridScreen.origin = "browsePerformersScreen"
    m.performerGridScreen.isLoaded = false
    m.BrowsePerformersScreen.visible = false
    m.performerGridScreen.visible = true
    m.performerGridScreen.setFocus(true)
end function

' Row item selected handler
Function OnPerformerSceneItemSelected()
    '?"OnPerformerSceneItemSelected called"
    m.performerGridScreen.visible = false
    m.sceneDetailsScreen.content = m.performerGridScreen.focusedContent
    m.sceneDetailsScreen.sceneID  = m.performerGridScreen.focusedContent.EpisodeNumber
    m.sceneDetailsScreen.itemID = m.performerGridScreen.focusedContent.id
    m.sceneDetailsScreen.origin = "performerGridScreen"
    m.sceneDetailsScreen.ready = false
    m.sceneDetailsScreen.visible = true
    m.sceneDetailsScreen.setFocus(true)
End Function

' Row item selected handler
Function OnSceneItemSelected()
    m.scenesGridScreen.visible = false
    m.sceneDetailsScreen.content = m.scenesGridScreen.focusedContent
    m.sceneDetailsScreen.sceneID  = m.scenesGridScreen.sceneID
    m.sceneDetailsScreen.itemID = m.scenesGridScreen.itemID
    m.sceneDetailsScreen.origin = "detailsScreen"
    m.sceneDetailsScreen.visible = true
    m.sceneDetailsScreen.setFocus(true)
End Function

' Row item selected handler
Function OnWatchLaterRowItemSelected()
    'm.gridScreen.visible = false
    m.detailsScreen.content = m.myListsScreen.focusedContent
    m.detailsScreen.itemID  = m.myListsScreen.focusedContent.id
    m.detailsScreen.origin  = "myListsScreen"
    m.detailsScreen.ready = false
    m.detailsScreen.setFocus(true)
    m.detailsScreen.visible = true
    m.myListsScreen.visible = false
End Function

Function OnWatchLaterSceneSelected()
    m.sceneDetailsScreen.content = m.myListsScreen.focusedContent
    m.sceneDetailsScreen.sceneID = m.myListsScreen.focusedContent.EpisodeNumber
    m.sceneDetailsScreen.itemID = m.myListsScreen.focusedContent.id
    m.sceneDetailsScreen.origin = "myListsScreen"
    m.myListsScreen.visible = false
    m.sceneDetailsScreen.visible = true
    m.sceneDetailsScreen.setFocus(true) 
End Function

Function OnPerformerRowItemSelected()
    m.performerGridScreen.visible = false
    m.detailsScreen.content = m.performerGridScreen.focusedContent
    m.detailsScreen.itemID  = m.performerGridScreen.focusedContent.id
    m.detailsScreen.origin  = "performerGridScreen"
    m.detailsScreen.ready = false
    m.detailsScreen.setFocus(true)
    m.detailsScreen.visible = true
end function

Function OnLiteralSearchItemSelected()
    if(m.LiteralSearchScreen.showNoResultsScreen = false) then
        m.literalSearchScreen.visible = false
        m.detailsScreen.content = m.literalSearchScreen.focusedContent
        m.detailsScreen.itemID  = m.literalSearchScreen.focusedContent.id
        m.detailsScreen.origin  = "literalSearchScreen"
        m.detailsScreen.ready = false
        m.detailsScreen.setFocus(true)
        m.detailsScreen.visible = true
    end if
end Function

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

Function onSearchResultSelected()
    itemIndex = m.top.searchItemIndexSelected
    'Print(itemIndex)
    m.top.fullItem = m.searchScreen.fullItems.GetEntry(itemIndex)
    fullItem = m.top.fullItem
    'Print(m.top.fullItem)

    regex         = CreateObject("roRegex", "::", "")
    textArray     = regex.split(fullItem)
    tagAndText    = textArray.GetEntry(0)

    searchItemID  = textArray.GetEntry(1)

    tagRegex      = CreateObject("roRegex", ":", "")
    tagArray      = tagRegex.split(tagAndText)
    tag           = tagArray.GetEntry(0)
    text          = tagArray.GetEntry(1)

    m.searchScreen.itemIDSelected = searchItemID
    
    'Print(searchItemID)
    if(tag = "Performer") then
        'Print(searchItemID)
        m.searchScreen.name = text
        m.searchScreen.visible = false
        m.performerGridScreen.origin = "searchScreen"
        m.performerGridScreen.visible = true
        m.performerGridScreen.setFocus(true)

    else if(tag = "Movie") then
        'Print(searchItemID)
        m.searchScreen.name = text
        m.detailsScreen.origin = "SearchScreen" '<---- DON"T FUCKING CHANGE THIS'
        m.searchScreen.visible = "false"
        m.detailsScreen.itemID  = m.gridscreen.focusedContent.id
        'm.testVar = GetProduct(m.gridscreen.focusedContent.id, m.top.userID, m.top.customerID)
        m.detailsScreen.setFocus(true)
        m.detailsScreen.visible = "true"

        else if(tag = "Category") then
        m.movieCategoriesScreen.categoryID = searchItemID
        m.movieCategoriesScreen.categoryTitle = text + " - " + tag 'reversed here'    
        m.movieCategoriesScreen.isLoaded = false
        m.movieCategoriesScreen.origin = "SearchScreen"
        m.searchScreen.visible = false
        m.movieCategoriesScreen.setFocus(true)
        m.movieCategoriesScreen.visible = true
    end if
End Function

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

Function OnBrowseListItemFocused()
    if(m.top.browseScreenConfigSetting = 3)
        'this is only case where scenetags button is moved up to position 0'
        m.browseScreen.showScenetags = true
        m.browseScreen.showMovieCategories = false
        m.browseScreen.showDivider = true
    else
        if m.top.browseListItemFocused = 0
            m.browseScreen.showMovieCategories = true
            m.browseScreen.showScenetags = false
            m.browseScreen.showDivider = true
        else if m.top.browseListItemFocused = 1
            m.browseScreen.showMovieCategories = false
            m.browseScreen.showScenetags = true
            m.browseScreen.showDivider = true
        end if
    end if
end Function

Function OnSettingsItemSelected()
    'first button is Parental Controls
    if m.top.settingsItemSelected = 0
        m.settingsScreen.visible = false
        m.parentalcontrolscreen.setFocus(true)
        m.parentalcontrolscreen.visible = true

        ' second button is Feedback And Support
    else if m.top.settingsItemSelected = 1
        m.settingsScreen.visible = false
        m.feedbackandsupportscreen.setFocus(true)
        m.feedbackandsupportscreen.visible = true

    'third button is Legal Notices
    else if m.top.settingsItemSelected = 2
        m.settingsScreen.visible = false
        m.legalnoticesscreen.setFocus(true)
        m.legalnoticesscreen.visible = true

    'logout user'
    else if m.top.settingsItemSelected = 3
        m.settingsScreen.logout = true
        'LogUserOut()
    end if
End Function

Function OnParentalControlButtonSelected()
    if m.top.parentalControlButtonSelected = 0
        m.parentalcontrolscreen.visible = false
        m.parentalPin.setFocus(true)
        m.parentalPin.visible = true

    else if m.top.parentalControlButtonSelected = 1
        m.parentalPin.pinString = ""
        m.top.newParentalPinSet = true

        dialog = createObject("RoSGNode","Dialog")
        'dialog.backgroundUri = "pkg:/images/sgetdialogbg.9.png"
        dialog.title = "ALL PARENTAL CONTROLS REMOVED"
        dialog.optionsDialog = true
        dialog.message = "Press * To Dismiss"
        m.top.dialog = dialog

        m.parentalcontrolscreen.visible = false
        m.settingsScreen.setFocus(true)
        m.settingsScreen.visible = true
    end if
End Function

Function OnParentalPinPadButtonSelected()
    if m.top.parentalPinButtonSelected = 0
        'Print(m.parentalPin.pinString)
        dialog = createObject("RoSGNode","Dialog")
        'dialog.backgroundUri = "pkg:/images/sgetdialogbg.9.png"
        dialog.title = "PIN UPDATED"
        dialog.optionsDialog = true
        dialog.message = "Press * To Dismiss"
        m.top.dialog = dialog

        m.top.newParentalPinSet = true
        m.parentalPin.visible = false
        m.parentalcontrolscreen.setFocus(true)
        m.parentalcontrolscreen.visible = true

    else if m.top.parentalPinButtonSelected = 1
        m.top.newParentalPinSet = false
        m.parentalPin.visible = false
        m.parentalcontrolscreen.setFocus(true)
        m.parentalcontrolscreen.visible = true
    end if
End Function

Function OnViewSceneListChange()
    'pass data to scenesGridScreen'
    m.scenesGridScreen.itemID = m.detailsScreen.itemID
    m.detailsScreen.visible = false
    m.scenesGridScreen.setFocus(true)
    m.scenesGridScreen.visible = true
    m.detailsScreen.viewScenes = false
End Function

Function OnViewLiteralSearchResults()
    m.searchScreen.visible = false
    m.literalSearchScreen.visible = true
    m.literalSearchScreen.setFocus(true)
end function

Function OnMovieCategorySelected()
    m.movieCategoriesScreen.categoryID = m.browseScreen.focusedContent.id
    m.movieCategoriesScreen.categoryTitle = m.browseScreen.focusedContent.title
    m.movieCategoriesScreen.origin = "browseScreen"
    m.movieCategoriesScreen.MovieLastItemFocus = [0,0]'see movieCategoriesScreen -- this needs cleaned up'
    m.movieCategoriesScreen.isLoaded = false
    m.browseScreen.visible = false
    m.movieCategoriesScreen.visible = true
    m.movieCategoriesScreen.setFocus(true)
end function

Function OnMovieCategoryItemSelected()
    m.detailsScreen.content = m.movieCategoriesScreen.focusedContent
    m.detailsScreen.itemID  = m.movieCategoriesScreen.focusedContent.id
    m.detailsScreen.origin  = "movieCategoriesScreen"
    m.detailsScreen.ready = false
    m.detailsScreen.setFocus(true)
    m.detailsScreen.visible = true
    m.movieCategoriesScreen.visible  = false
end Function

Function OnSceneTagSelected()
    '?"OnSceneTagSelected"
    m.sceneTagsScreen.sceneTagTitle = m.browseScreen.focusedContent.title
    m.sceneTagsScreen.SceneLastItemFocus = [0,0]
    m.sceneTagsScreen.isLoaded = false
    m.browseScreen.visible = false
    m.sceneTagsScreen.visible = true
    m.sceneTagsScreen.setFocus(true)
end function

Function OnSceneTagItemSelected()
    m.sceneTagsScreen.visible = false
    m.sceneDetailsScreen.ready = false
    m.sceneDetailsScreen.content = m.sceneTagsScreen.focusedContent
    m.sceneDetailsScreen.sceneID = m.sceneTagsScreen.focusedContent.EpisodeNumber
    m.sceneDetailsScreen.itemID = m.sceneTagsScreen.focusedContent.id
    m.sceneDetailsScreen.origin = "sceneTagsScreen"
    m.sceneDetailsScreen.visible = true
    m.sceneDetailsScreen.setFocus(true)
end function

' Main Remote keypress event loop
Function OnKeyEvent(key, press) as Boolean
    result = false
    if press then
        'print(key)
        if key = "options"

'            'only launch from gridscreen
'            if(m.gridscreen.visible = true) then
'                '?"goto menuScreen"
'                m.gridScreen.visible = false
'                m.menuScreen.setFocus(true)
'                m.menuScreen.visible = true
'                result = true
'            end if

        else if key = "back"

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

            ' if scene video player opened
            else if m.sceneDetailsScreen.videoPlayerVisible = true then
                '?"sceneVideoPlayer closing"
                m.sceneDetailsScreen.videoPlayerVisible = false
                m.sceneDetailsScreen.videoPlayerState = "finished"
                'm.sceneDetailsScreen.visible = true
                m.sceneDetailsScreen.setFocus(true) 'keep this setFocus for now'
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
            
            'if searchScreen is open'
            else if(m.searchScreen.visible = true) then
                m.gridscreen.visible = false
                m.searchScreen.visible = false
                m.searchScreen.text = ""
                m.searchScreen.results = []
                m.menuScreen.visible = true
                m.menuScreen.setFocus(true)
                result = true

            'restrict backing out while myListsScreen is loading'
            else if(m.myListsScreen.visible = true and m.myListsScreen.isLoaded = false) then
                ?"2 - caught"
                result = true

            'if myListsScreen is open'
            else if(m.myListsScreen.visible = true and m.myListsScreen.isLoaded = true) then
                m.myListsScreen.isLoaded = false
                m.myListsScreen.setToFirstRow = true
                m.gridscreen.visible = false
                m.myListsScreen.visible = false
                m.menuScreen.visible = true
                m.menuScreen.setFocus(true)
                result = true


            'if performerGridScreen is open'
            else if(m.performerGridScreen.visible = true) then
            '?"m.performerGridScreen.visible = true"
                'Print(m.performerGridScreen.origin)
                if(m.performerGridScreen.origin = "browseScreen") then
                    m.performerGridScreen.visible = false
                    m.browseScreen.setFocus(true)
                    m.browseScreen.visible = true
                    result = true
                 else if(m.performerGridScreen.origin = "gridscreen") then
                    m.performerGridScreen.visible = false
                    m.gridscreen.visible = true
                    m.gridscreen.setFocus(true)
                    result = true
                else if(m.performerGridScreen.origin = "searchScreen") then
                    m.performerGridScreen.visible = false
                    m.searchScreen.setFocus(true)
                    m.searchScreen.visible = true
                    result = true
                else if(m.performerGridScreen.origin = "browsePerformersScreen") then
                    m.performerGridScreen.visible = false
                    m.browsePerformersScreen.setFocus(true)
                    m.browsePerformersScreen.visible = true
                    result = true
                else
                    result = true
                end if

            'if browsePerformersScreen is open'
            else if(m.browsePerformersScreen.visible = true and m.browsePerformersScreen.isLoaded = true) then
                '?"exiting browsePerformersScreen"
                m.gridscreen.visible = false
                m.browsePerformersScreen.visible = false
                m.menuScreen.visible = true
                m.menuScreen.setFocus(true)
                result = true

            'if scenegridscreen is open'
            else if(m.scenesGridScreen.visible = true) then
                m.detailsScreen.ready = false
                m.detailsScreen.visible = true
                m.scenesGridScreen.visible = false
                m.detailsScreen.setFocus(true) 
                result = true

            'if literalSearchScreen is open'
            else if(m.literalSearchScreen.visible = true) then
                'reset listener flags'
                m.literalSearchScreen.isLoaded = false
                m.searchScreen.viewLiteralSearchResults = false
                m.literalSearchScreen.visible = false
                m.searchScreen.visible = true
                m.searchScreen.setFocus(true)
                result = true

            'if settingsScreen is open'
            else if(m.settingsScreen.visible = true) then
                m.gridscreen.visible = false
                m.settingsScreen.visible = false
                m.menuScreen.visible = true
                m.menuScreen.setFocus(true)
                result = true

            'if parentalcontrolscreen is open
            else if(m.parentalcontrolscreen.visible = true) then
                m.parentalcontrolscreen.visible = false
                m.settingsScreen.setFocus(true)
                m.settingsScreen.visible = true
                result = true

            'if legalnoticescreen is open
            else if(m.legalnoticesscreen.visible = true) then
                m.legalnoticesscreen.visible = false
                m.settingsScreen.setFocus(true)
                m.settingsScreen.visible = true
                result = true

            'if feedbackandsupportscreen is open
            else if(m.feedbackandsupportscreen.visible = true) then
                m.feedbackandsupportscreen.visible = false
                m.settingsScreen.setFocus(true)
                m.settingsScreen.visible = true
                result = true

            'if menuScreen is opened'
            else if(m.menuScreen.visible = true) then
                m.gridscreen.visible = true
                m.menuScreen.visible = false
                m.gridScreen.setFocus(true)
                result = true

            'if sceneDetail is open but not ready
            else if(m.sceneDetailsScreen.visible = true and m.detailsScreen.videoPlayerVisible = false and m.sceneDetailsScreen.ready = false) then
                ?"caught"

            'if sceneDetail is open and ready
            else if(m.sceneDetailsScreen.visible = true and m.sceneDetailsScreen.videoPlayerVisible = false and m.sceneDetailsScreen.ready = true) then
                'reset flags'
                m.sceneDetailsScreen.ready = false
                if(m.sceneDetailsScreen.origin = "detailsScreen") then
                    m.scenesGridScreen.visible = true
                    m.sceneDetailsScreen.visible = false
                    'm.loadingIndicator.control = "start"
                    result = true
                else if(m.sceneDetailsScreen.origin = "gridscreen") then
                    m.sceneDetailsScreen.visible = false
                    m.gridscreen.visible = true
                    result = true
                else if(m.sceneDetailsScreen.origin = "browseScreen") then
                    m.browseScreen.visible = true                   
                    m.browseScreen.setFocus(true)
                    m.sceneDetailsScreen.visible = false
                    m.loadingIndicator.control = "stop"
                    result = true
                else if(m.sceneDetailsScreen.origin = "myListsScreen") then
                    m.sceneDetailsScreen.visible = false
                    m.myListsScreen.visible = true
                    m.myListsScreen.setFocus(true)
                    
                    'm.loadingIndicator.control = "stop" 'might be unnecessary'
                    result = true
                else if(m.sceneDetailsScreen.origin = "performerGridScreen") then
                    m.sceneDetailsScreen.visible = false
                    m.performerGridScreen.visible = true
                    m.performerGridScreen.setFocus(true)
                    result = true
                else if(m.sceneDetailsScreen.origin = "sceneTagsScreen") then
                    m.sceneDetailsScreen.visible = false
                    m.sceneTagsScreen.visible = true
                    m.sceneTagsScreen.setFocus(true)
                    result = true
                end if

            'if Details opened -- return to originating screen via m.detailsScreen.origin value
            else if(m.detailsScreen.visible = true and m.detailsScreen.videoPlayerVisible = false and m.detailsScreen.ready = true) then
                '?"*** exiting detailsScreen"
                'Print(m.detailsScreen.origin)
                'reset flags'
                'm.detailsScreen.ready = false
                m.detailsScreen.WatchLaterFlagAction = ""

                'reset isPreview flag'
                if(m.detailsScreen.preview = true) then
                    m.detailsScreen.preview = false
                end if

                'return to gridscreen'
                if(m.detailsScreen.origin = "gridscreen") then
                        '?"exiting"
                        m.detailsScreen.visible = false
                        m.gridscreen.setFocus(true)
                        m.gridScreen.visible = true
                        result = true                    

                'return to browseScreen
                else if(m.detailsScreen.origin = "browseScreen") then
                        '?"exiting to browseScreen"
                        m.detailsScreen.visible = false
                        m.browseScreen.visible = true
                        m.browseScreen.setFocus(true)
                        m.loadingIndicator.control = "stop"
                        result = true

                'return to SearchScreen
                else if(m.detailsScreen.origin = "SearchScreen") then
                        '?"exiting searchScreen"
                        m.detailsScreen.visible = false
                        m.searchScreen.setFocus(true)
                        m.searchScreen.visible = true
                        result = true

                'return to PerformerGridScreen
                else if(m.detailsScreen.origin = "performerGridScreen") then
                        '?"exiting back to performerGridScreen"
                        m.detailsScreen.visible = false
                        m.performerGridScreen.visible = true
                        m.performerGridScreen.setFocus(true)                       
                        result = true

                else if(m.detailsScreen.origin = "literalSearchScreen") then
                        '?"exiting"
                        m.detailsScreen.visible = false
                        m.literalSearchScreen.visible = true
                        m.literalSearchScreen.setFocus(true)
                        result = true

                else if(m.detailsScreen.origin = "myListsScreen") then
                        '?"exiting"
                        m.detailsScreen.visible = false
                        m.myListsScreen.visible = true
                        m.myListsScreen.setFocus(true)
                        
                        result = true

                else if(m.detailsScreen.origin = "movieCategoriesScreen") then
                    '?exiting'
                    m.movieCategoriesScreen.visible = true
                    m.movieCategoriesScreen.setFocus(true)
                    m.detailsScreen.visible = false
                    result = true
                    
                end if

            else if(m.movieCategoriesScreen.visible = true) then
                if(m.movieCategoriesScreen.origin = "browseScreen") then
                    m.movieCategoriesScreen.visible = false
                    m.browseScreen.visible = true
                    m.browseScreen.setFocus(true)
                    result = true
                else if(m.movieCategoriesScreen.origin = "SearchScreen") then
                    m.movieCategoriesScreen.visible = false
                    m.searchScreen.visible = true
                    m.searchScreen.setFocus(true)
                    result = true
                end if

            else if(m.sceneTagsScreen.visible = true) then 
                m.sceneTagsScreen.visible = false
                m.browseScreen.visible = true
                m.browseScreen.setFocus(true)
                result = true

            'else if m.detailsScreen.ready = false or m.loadingIndicator.control = "start" then
            ''    ?"4 - caught"
            ''    result = true

                        'if browseScreen is open'
            else if(m.browseScreen.visible = true and m.browseScreen.isLoaded = true) then
                '?"exiting browseScreen"
                m.gridscreen.visible = false
                m.browseScreen.visible = false
                m.menuScreen.visible = true
                m.menuScreen.setFocus(true)
                result = true

            'restrict backing out while browseScreen is loading'
            else if(m.browseScreen.visible = true and m.browseScreen.isLoaded = false) then
                ?"3 - caught"
                result = true

            else
                ?"FINAL EXIT CASE HIT -- YOU PROB MISSED SETTING RESULT = TRUE IN THE LAST CONDITIONAL YOU JUST WROTE"
                result = false
            end if
        end if
    end if
    return result
End Function

function getEmptyContentObject()
    emptyContent      = createObject("RoSGNode","ContentNode")
    emptyContentList  = emptyContent.createChild("ContentNode")
    emptyString       = ""
    emptyContentList["id"]                      = emptyString
    emptyContentList["Title"]                   = emptyString
    emptyContentList["LENGTH"]                  = emptyString
    emptyContentList["HDPosterUrl"]             = emptyString
    emptyContentList["DESCRIPTION"]             = emptyString
    emptyContentList["ReleaseDate"]             = emptyString
    emptyContentList["url"]                     = emptyString
    emptyContentList["HDBackgroundImageUrl"]    = emptyString
    emptyContentList["SDBackgroundImageUrl"]    = emptyString
    emptyContentList["shortdescriptionline2"]   = emptyString
    emptyContentList["STREAMFORMAT"]            = emptyString

    return emptyContent
end function

function SetAppColors()
    m.menuScreen.buttonsFocusedColor                   = m.top.globalFocusedColor
    m.gridscreen.row0LabelColor                        = m.top.globalSecondaryColor
    m.gridScreen.row1LabelColor                        = m.top.globalSecondaryColor
    m.gridScreen.row2LabelColor                        = m.top.globalSecondaryColor
    m.gridScreen.row3LabelColor                        = m.top.globalSecondaryColor
    m.gridScreen.row4LabelColor                        = m.top.globalSecondaryColor
    m.gridScreen.labelColor                            = m.top.globalSecondaryColor
    m.browsePerformersScreen.performerRowLabelColor    = m.top.globalSecondaryColor
    m.browseScreen.BrowseListRowListFocusedColor       = m.top.globalSecondaryColor
    m.browseScreen.MovieCategoryLabelListFocusedColor  = m.top.globalSecondaryColor
    m.browseScreen.SceneTagLabelListFocusedColor       = m.top.globalSecondaryColor
    m.detailsScreen.buttons1FocusedColor               = m.top.globalFocusedColor
    m.detailsScreen.buttons2FocusedColor               = m.top.globalFocusedColor
    m.detailsScreen.VideoPlayerColor                   = m.top.globalVideoPlayerBarColor
    m.exitScreen.buttonsFocusedColor                   = m.top.globalFocusedColor
    m.feedbackandsupportscreen.labelColor              = m.top.globalSecondaryColor
    m.parentalcontrolscreen.buttonsFocusedColor        = m.top.globalFocusedColor
    m.literalSearchScreen.rowLabelColor                = m.top.globalSecondaryColor
    m.literalSearchScreen.noResultsLabelColor          = m.top.globalSecondaryColor    
    m.movieCategoriesScreen.rowLabelColor              = m.top.globalSecondaryColor
    m.myListsScreen.rowLabelColor                      = m.top.globalSecondaryColor
    m.myListsScreen.sceneRowLabelColor                 = m.top.globalSecondaryColor
    m.performerGridScreen.rowLabelColor                = m.top.globalSecondaryColor
    m.performerGridScreen.sceneRowLabelColor           = m.top.globalSecondaryColor
    m.parentalPin.pinpadColor                          = m.top.globalFocusedColor
    m.parentalPin.pinDisplayTextColor                  = m.top.globalSecondaryColor
    m.parentalPin.PCPinButtonsFocusedColor             = m.top.globalFocusedColor
    m.SceneDetailsScreen.buttons1FocusedColor          = m.top.globalFocusedColor
    m.SceneDetailsScreen.buttons2FocusedColor          = m.top.globalFocusedColor
    m.SceneDetailsScreen.VideoPlayerColor              = m.top.globalVideoPlayerBarColor
    m.scenesGridScreen.rowLabelColor                   = m.top.globalSecondaryColor
    m.sceneTagsScreen.rowLabelColor                    = m.top.globalSecondaryColor
    m.searchScreen.keyboardColor                       = m.top.globalSecondaryColor
    m.searchScreen.searchButtonFocusedColor            = m.top.globalFocusedColor
    m.searchScreen.resultsFocusedColor                 = m.top.globalFocusedColor
    m.searchScreen.searchTextColor                     = m.top.globalSecondaryColor
    m.settingsScreen.buttonsFocusedColor               = m.top.globalFocusedColor
end function

function SetAppFont()
    m.menuScreen.font                           = m.top.globalFontPath
    m.gridScreen.font                           = m.top.globalFontPath
    m.detailsScreen.font                        = m.top.globalFontPath
    m.browseScreen.font                         = m.top.globalFontPath
    m.exitScreen.font                           = m.top.globalFontPath
    m.LiteralSearchScreen.font                  = m.top.globalFontPath
    m.movieCategoriesScreen.font                = m.top.globalFontPath
    m.myListsScreen.font                        = m.top.globalFontPath
    m.settingsScreen.font                       = m.top.globalFontPath
    m.parentalcontrolscreen.font                = m.top.globalFontPath
    m.parentalPin.font                          = m.top.globalFontPath
    m.performerGridScreen.font                  = m.top.globalFontPath
    m.searchScreen.font                         = m.top.globalFontPath
    m.scenesGridScreen.font                     = m.top.globalFontPath
    m.sceneDetailsScreen.font                   = m.top.globalFontPath
    m.sceneTagsScreen.font                      = m.top.globalFontPath
end Function

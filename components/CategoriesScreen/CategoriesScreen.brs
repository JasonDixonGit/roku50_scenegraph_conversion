Function Init()
   
    m.videoPlayer        =   m.top.findNode("VideoPlayer")
    m.CategoryList       =   m.top.findNode("CategoryList")
    m.SubCategoryLabelList = m.top.findNode("SubCategoryLabelList")
    m.posterGrid           = m.top.findNode("PosterGridScreen")
    
    'set screen focus onto first list'
    m.currentRowList =   m.CategoryList

    m.description    =   m.top.findNode("Description")
    m.background     =   m.top.findNode("Background")


    m.top.observeField("visible", "onVisibleChange")
    m.top.observeField("focusedChild", "OnFocusedChildChange")

    m.top.observeField("itemFocused", "OnItemFocused")
    m.top.observeField("labelFocused", "OnLabelFocused")
    m.top.observeField("videoFocused","OnVideoFocused")
    m.top.observeField("CategoryListItemSelected", "OnCategoryListItemSelected")
    m.top.observeField("videoSelected", "OnVideoSelected")
    'm.top.observeField("needsRefreshed", "runTask")
    'm.rowList0.setFocus(true) 'set focus to first row on load after clearing out button background'
    m.CategoryList.rowLabelFont.size = m.CategoryList.rowLabelFont.size + 8
    m.description.title.font.size = m.description.title.font.size + 30
    m.top.isLoaded = false


    'default setup'
    m.CategoryList.visible = true
    
    setButtonListProperties(m)
    
    runTask()

End Function

'retrieve data from API with async task node
sub runTask()
  ?'"runTask() called"
  'if(m.top.needsRefreshed = true)  then
    'call api for data
    ?"Running https TASK"
    m.readGridTask = createObject("roSGNode","fetchDataFromAPI")
    m.readGridTask.postergriduri = "http://cs50.tv/?output=roku"
    m.readGridTask.observeField("gridscreencontent","showGridScreen")
    m.readGridTask.control = "RUN"
  'end if
end sub

'assign retrieved data to postergrid
sub showGridScreen()
  m.top.content = m.readGridTask.gridscreencontent
  m.top.contentSet = true
end sub

'handler of focused item in RowList
Sub OnItemFocused()

    m.CategoryList.rowLabelFont.uri = m.top.font

    m.itemFocused   = m.top.itemFocused
    focusedContent  = m.top.content.getChild(m.itemFocused[0]).getChild(m.itemFocused[1])
    m.top.lastItemFocus = [1, m.itemFocused[1]]


    'm.itemFocused = m.top.itemFocused


    'When an item gains the key focus, set to a 2-element array,
    'where element 0 contains the index of the focused row,
    'and element 1 contains the index of the focused item in that row.
    If m.itemFocused.Count() = 2 then
        'focusedContent       = m.top.content.getChild(m.itemFocused[0]).getChild(m.itemFocused[1])
        if focusedContent <> invalid then
            m.top.focusedContent    = focusedContent
            m.description.content   = focusedContent
            m.background.uri        = focusedContent.hdBackgroundImageUrl
            m.itemID                = focusedContent.itemID
        end if
    end if
End Sub

Sub OnLabelFocused()
    '*********** CHECK IF LIST IS LOADED **************
    if(m.top.labelFocused >= 0) then
        ?"Running posterGrid TASK"
        'm.subCategoryItemFocused = m.top.labelFocused
        'Print m.top.subCategoryLinkArray[m.top.labelFocused]
        'm.SubCategoryLabelList()
        m.posterGridTask = createObject("roSGNode","FetchSubCategory")
        m.posterGridTask.subCategoryUri = m.top.subCategoryLinkArray[m.top.labelFocused]
        m.posterGridTask.observeField("subCategoryContent","updatePosterGrid")
        m.posterGridTask.control = "RUN"
    end if
end Sub

'assign retrieved data to postergrid
sub updatePosterGrid()
  m.top.posterContent = m.posterGridTask.subCategoryContent
  'm.top.contentSet = true
end sub

' set proper focus to RowList in case if return from Details Screen
Sub onVisibleChange()
    ?"onVisibleChange"
    'm.MenuButton.font.uri = m.top.font
    'm.rowLabelFont = m.top.font
    
    if m.top.visible = true then
        runTask()
        if(m.top.lastItemFocus[0] = 0 AND m.top.lastItemFocus[1] = 0) then
            ?"setting to item 0"
            'm.currentRowList.setFocus(true)
            m.CategoryList.setFocus(true)
            m.CategoryList.jumpToRowItem = [0, 0]
        else
            
            if(m.CategoryList.hasFocus()) then
               m.lastElement = m.top.lastItemFocus[1]
               m.CategoryList.setFocus(true)
               m.CategoryList.jumpToRowItem = [0, m.lastElement]
            end if
       end if
    end if
End Sub

' set proper focus to RowList in case if return from Details Screen
Sub OnFocusedChildChange()
    if(m.top.visible = false and not m.currentRowList.hasFocus()) then
        m.currentRowList.setFocus(true)
    end if
End Sub

' Row item selected handler
Function OnCategoryListItemSelected()
    populateSubCategoryLabelList()
    AnimateToSubCategories = m.top.FindNode("AnimateToSubCategories")
    AnimateToSubCategories.control = "start"
    m.SubCategoryLabelList.setFocus(true)
End Function

Function populateSubCategoryLabelList()
    ?"Running labellist TASK"
    m.labellistTask = createObject("roSGNode","BuildSubcategoryLabelList")
    m.labellistTask.subCategoryContent = m.top.focusedContent
    m.labellistTask.observeField("buttonListAA","AssignLabelListData")
    m.labellisttask.observeField("linkArray", "AssignLinkArray")
    m.labellistTask.control = "RUN"
End Function

sub AssignLabelListData()
  m.top.buttonsContent = m.labellistTask.buttonListAA
  'm.top.contentSet = true
end sub

sub AssignLinkArray()
    m.top.subCategoryLinkArray = m.labellistTask.linkArray
end sub

Function OnVideoFocused()
    m.focusedVideo  = m.top.posterContent.getChild(m.top.videoFocused)
End Function

Function OnVideoSelected()
  ?"on video selected"
  Print m.top.videoSelected
  Print m.focusedVideo.url
  
  videoContent = createObject("RoSGNode", "ContentNode")
  videoContent.url = m.focusedVideo.url
  videoContent.streamformat = "mp4"
 
  m.VideoPlayer.content = videoContent
  m.VideoPlayer.visible = true
  m.VideoPlayer.control = "play"
  m.VideoPlayer.setFocus(true)
end Function

' event handler of Video player msg
Sub OnVideoPlayerStateChange()
    if m.videoPlayer.state  = "error"
        ' error handling
        ?"ERROR"
        m.videoPlayer.visible = false
    else if m.videoPlayer.state = "playing"
        ' playback handling
        '?"playing"
    else if m.videoPlayer.state = "finished"
        '?"finished"
        m.videoPlayer.visible = false
        'm.videoPlayer.control = "stop"
    end if
End Sub

Function OnKeyEvent(key, press) as Boolean
    result = false
    if press then
        'print(key)

        if key = "back"
            
            'catch back press while loading main CategoriesScreen'
            if(m.VideoPlayer.visible = true) then
                m.VideoPlayer.visible = false
                m.VideoPlayer.control = "stop"
                m.posterGrid.setFocus(true)
                
                result = true
            else
                AnimateBackToCategories = m.top.FindNode("AnimateBackToCategories")
                AnimateBackToCategories.control = "start"
                m.CategoryList.setFocus(true)
                result = true                   
            end if
            
        else if key = "right"
            if(m.SubCategoryLabelList.hasFocus()) then
                m.posterGrid.setFocus(true)
                result = true
            end if
            
        else if key = "left"
            if(m.posterGrid.hasFocus() = true) then
                m.SubCategoryLabelList.setFocus(true)
                result = true
            end if  
        end if
    end if
    return result
End Function

'set button size, and onfocus size for enlarging-focus effect
Function setButtonListProperties(m)
  m.SubCategoryLabelList.font = "font:MediumSystemFont"
  m.SubCategoryLabelList.font.size = m.SubCategoryLabelList.font.size
  m.SubCategoryLabelList.focusedFont = "font:MediumBoldSystemFont"
  m.SubCategoryLabelList.focusedFont.size = m.SubCategoryLabelList.focusedFont.size+10
end Function

Function setVideoPlayerColors()
    'm.videoPlayerColor = m.top.VideoPlayerColor

    'rtBar = m.videoPlayer.retrievingBar
    'rtBar.filledBarBlendColor = m.videoPlayerColor

    'bfBar = m.videoPlayer.bufferingBar
    'bfBar.filledBarBlendColor = m.videoPlayerColor
end Function
Function Init()
   
    m.CategoryList       =   m.top.findNode("CategoryList")

    'set screen focus onto first list'
    m.currentRowList =   m.CategoryList

    m.description    =   m.top.findNode("Description")
    m.background     =   m.top.findNode("Background")


    m.top.observeField("visible", "onVisibleChange")
    m.top.observeField("focusedChild", "OnFocusedChildChange")

    m.top.observeField("itemFocused", "OnItemFocused")
    'm.top.observeField("needsRefreshed", "runTask")
    'm.rowList0.setFocus(true) 'set focus to first row on load after clearing out button background'
    m.CategoryList.rowLabelFont.size = m.CategoryList.rowLabelFont.size + 8

    m.top.isLoaded = false

    'default setup'
    m.CategoryList.visible = true

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
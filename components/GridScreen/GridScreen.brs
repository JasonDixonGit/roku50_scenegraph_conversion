Function Init()
''    ? "Init - [GridScreen]"
    
    m.rowList0       =   m.top.findNode("RowList0")
    m.rowList1       =   m.top.findNode("RowList1")
    m.rowList2       =   m.top.findNode("RowList2")
    m.rowList3       =   m.top.findNode("RowList3")

    m.sceneContent   =   m.top.findNode("sceneContent")
    'set screen focus onto first list'
    m.currentRowList =   m.rowList0

    m.description    =   m.top.findNode("Description")
    m.background     =   m.top.findNode("Background")
    m.MenuButton      =   m.top.findNode("MenuButton")

    m.position = [] ' can be removed?'

    m.top.observeField("visible", "onVisibleChange")
    m.top.observeField("focusedChild", "OnFocusedChildChange")

    m.top.observeField("itemFocused0", "OnItemFocused")
    m.top.observeField("itemFocused1", "OnItemFocused")
    m.top.observeField("itemFocused2", "OnItemFocused")
    m.top.observeField("itemFocused3", "OnItemFocused")


    m.MenuButton.font.uri         = "pkg:/fonts/Helvetica.ttf"
    m.MenuButton.font.size        = m.MenuButton.font.size + 20
    m.MenuButton.focusedFont.uri  = "pkg:/fonts/Helvetica.ttf"
    m.MenuButton.focusedFont.size = m.MenuButton.focusedFont.size + 20
    'm.MenuButton.setFocus(true) 'to clear out default background'
    m.MenuButton.visible = false
    
    'm.rowList0.setFocus(true) 'set focus to first row on load after clearing out button background'
    m.rowList0.rowLabelFont.size = m.rowList0.rowLabelFont.size + 8
    m.rowList1.rowLabelFont.size = m.rowList1.rowLabelFont.size + 8
    m.rowList2.rowLabelFont.size = m.rowList2.rowLabelFont.size + 8
    m.rowList3.rowLabelFont.size = m.rowList3.rowLabelFont.size + 8

    m.top.isLoaded = false

    'default setup'
    m.rowList0.visible = true
    m.rowList1.visible = false
    m.rowList2.visible = false
    m.rowList3.visible = false

End Function

' handler of focused item in RowList
Sub OnItemFocused()
    m.MenuButton.font.uri = m.top.font
    m.MenuButton.focusedFont.uri = m.top.font
    m.rowList0.rowLabelFont.uri = m.top.font
    m.rowList1.rowLabelFont.uri = m.top.font
    m.rowList2.rowLabelFont.uri = m.top.font
    m.rowList3.rowLabelFont.uri = m.top.font

    if(m.rowList0.hasFocus()) then
        m.itemFocused   = m.top.itemFocused0
        focusedContent  = m.top.content0.getChild(m.itemFocused[0]).getChild(m.itemFocused[1])
        m.top.lastItemFocus = [1, m.itemFocused[1]]
    
    else if(m.rowList1.hasFocus()) then
        m.itemFocused   = m.top.itemFocused1
        focusedContent  = m.top.content1.getChild(m.itemFocused[0]).getChild(m.itemFocused[1])
        m.top.lastItemFocus = [1, m.itemFocused[1]]
        'Print(m.top.lastItemFocus)

    else if(m.rowList2.hasFocus()) then
        m.itemFocused = m.top.itemFocused2
        focusedContent  = m.top.content2.getChild(m.itemFocused[0]).getChild(m.itemFocused[1])
        m.top.lastItemFocus = [2, m.itemFocused[1]]
        'Print(m.top.lastItemFocus)

    else if(m.rowList3.hasFocus()) then
        m.itemFocused = m.top.itemFocused3
        focusedContent  = m.top.content3.getChild(m.itemFocused[0]).getChild(m.itemFocused[1])
        m.top.lastItemFocus = [3, m.itemFocused[1]]
        'Print(m.top.lastItemFocus)

    else
        m.itemFocused = m.top.itemFocused4
        focusedContent  = m.top.content4.getChild(m.itemFocused[0]).getChild(m.itemFocused[1])
        m.top.lastItemFocus = [4, m.itemFocused[1]]
        'Print(m.top.lastItemFocus)
    end if

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
    '?"onVisibleChange"
    'm.MenuButton.font.uri = m.top.font
    'm.rowLabelFont = m.top.font
    
    if m.top.visible = true then
        if(m.top.lastItemFocus[0] = 0 AND m.top.lastItemFocus[1] = 0) then
            ?"setting to item 0"
            'm.currentRowList.setFocus(true)
            m.rowList0.setFocus(true)
            m.rowList0.jumpToRowItem = [0, 0]
        else
            '?"setting to last item"
            'm.top.itemFocused = m.top.lastItemFocus
            'm.currentRowList.setFocus(true)
            'm.currentRowList.jumpToRowItem = [m.top.lastItemFocus[0], m.top.lastItemFocus[1]]
            
            if(m.rowList0.hasFocus()) then
               m.lastElement = m.top.lastItemFocus[1]
               m.rowList0.setFocus(true)
               m.rowList0.jumpToRowItem = [0, m.lastElement]

            else if(m.rowList1.hasFocus()) then
               m.lastElement = m.top.lastItemFocus[1]
               m.rowList1.setFocus(true)
               m.rowList1.jumpToRowItem = [0, m.lastElement]

            else if(m.rowList2.hasFocus()) then
               m.lastElement = m.top.lastItemFocus[1]
               m.rowList2.setFocus(true)
               m.rowList2.jumpToRowItem = [0, m.lastElement]

            else if(m.rowList3.hasFocus()) then
               m.lastElement = m.top.lastItemFocus[1]
               m.rowList3.setFocus(true)
               m.rowList3.jumpToRowItem = [0, m.lastElement]

            else
               lastElement = 0
               m.rowList0.setFocus(true)
               m.rowList0.jumpToRowItem = [0, lastElement]
               '?"set to origin"
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

Function OnKeyEvent(key, press) as Boolean
    result = false
    if press then
        if(key = "down") then
            if(m.menuButton.hasFocus()) then
                m.rowList0.setFocus(true)
                m.currentRowList = m.rowList0
                result = true
            else if(m.rowList0.hasFocus()) then
                m.rowList1.visible = true
                m.rowList1.setFocus(true) 
                m.rowList0.visible = false
                m.currentRowList = m.rowList1
                result = true
            else if(m.rowList1.hasFocus()) then
                m.rowList2.visible = true
                m.rowList2.setFocus(true) 
                m.rowList1.visible = false
                m.currentRowList = m.rowList2
                result = true
            else if(m.rowList2.hasFocus()) then
                m.rowList3.visible = true
                m.rowList3.setFocus(true)
                m.rowList2.visible = false
                m.currentRowList = m.rowList3
                result = true
            else 'if(m.rowList4.hasFocus()) then
                result = true
            end if
        end if
        if(key = "up") then
            if(m.rowList3.hasFocus()) then
                m.rowList2.visible = true
                m.rowList2.setFocus(true)
                m.rowList3.visible = false
                m.currentRowList = m.rowList2
                result = true
            else if(m.rowList2.hasFocus()) then
                m.rowList1.visible = true
                m.rowList1.setFocus(true)
                m.rowList2.visible = false
                m.currentRowList = m.rowList1
                result = true
            else if(m.rowList1.hasFocus()) then
                m.rowList0.visible = true
                m.rowList0.setFocus(true)
                m.rowList1.visible = false
                m.currentRowList = m.rowList0
                result = true
            else if(m.rowList0.hasFocus()) then
                m.menuButton.setFocus(true)
                result = true
            else 'if(m.rowList0.hasFocus()) then
                result = true   
            end if
        end if
    'Print(m.currentRowList.id)
    end if
    
End Function
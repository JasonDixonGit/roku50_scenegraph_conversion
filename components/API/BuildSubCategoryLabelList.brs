'******************************************************************
' Author: Jason Dixon
' Description:
'******************************************************************

sub init()
    m.top.contentSet = false
    m.top.functionName = "buildSubcategoryButtonList"
end sub

sub buildSubcategoryButtonList()
    buttonList = []
    ButtonListMetaData = CreateObject("roAssociativeArray")
    index = 0
    for each item in m.top.subCategoryContent.Actors
        'buttonString = item
        buttonList.push(item)
        'buttonListItem = {"Title":item.toStr()}
        'ButtonListMetaData.AddReplace(index.tostr(), buttonListItem)
        index += 1
    next
    m.top.buttonListAA = ButtonListFactory().BuildButtonList(buttonList)
end sub
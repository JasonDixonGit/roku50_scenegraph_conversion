'******************************************************************
' Author: Jason Dixon
' Description: 
'******************************************************************


'******************************************************************
' Description: 
'******************************************************************
Function ButtonListFactory() as Object
    this = {
        
        BuildButtonList:   BuildButtonList
        BuildLabelListButtons: BuildLabelListButtons
    }
    return this
End Function


'******************************************************************
' Description: 
'******************************************************************
Function BuildButtonList(titles)
    buttonListContent = createObject("RoSGNode","ContentNode")
    'buttonList = CreateObject("roArray", titles.Count(), false)

    for each title in titles
        buttonItem = buttonListContent.createChild("ContentNode")
        buttonItem["TITLE"] = " " + title
    end for
    return buttonListContent
end function


'******************************************************************
' Description: 
'******************************************************************
Function BuildLabelListButtons(labellist as Object)
    'gridscreen node'
    LabelListItems = createObject("RoSGNode","ContentNode")
    'PrintAny(0, "", labellist)
    'for each row on the gridscreen:'
    for each label in labellist
        labelItem = createObject("RoSGNode","ContentNode")
        'labelItem = label.contentlist
        labelItem.Title = " " + label.Title 'space to give left margin'
        LabelListItems.appendChild(labelItem)
    end for
    return LabelListItems
end function
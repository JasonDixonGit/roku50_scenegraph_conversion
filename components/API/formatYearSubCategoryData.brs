'******************************************************************
' Author: Jason Dixon
' Description:
'******************************************************************

sub init()
    m.top.contentSet = false
    m.top.functionName = "getContent"
end sub

sub getContent()
    ?"running getContent"
    m.top.gridscreencontent = GridrowFactory().BuildYearSubCategoryGridRow(m.top.unstructuredContent)' = API_Utils().ParseXMLContent(list)
end sub
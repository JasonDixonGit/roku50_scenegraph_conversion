'******************************************************************
' Author: Jason Dixon
' Description:
'******************************************************************

sub init()
    m.top.contentSet = false
    m.top.functionName = "getContent"
end sub

sub getContent()

    postergridcontent = createObject("RoSGNode","ContentNode")
    readInternet      = createObject("roUrlTransfer")
    taskPort          = CreateObject("roMessagePort")

    readInternet.SetMessagePort(taskPort)
    readInternet.EnableFreshConnection(true) 'Don't reuse existing connections
    readInternet.setUrl(m.top.postergriduri)

    xmlDataIn = readInternet.GetToString()
    'Print xmlDataIn
    m.top.gridscreencontent = GridrowFactory().BuildCategoryGridRow(xmlDataIn)' = API_Utils().ParseXMLContent(list)

end sub

'Function BuildGridscreenContent()
'    
'    oneRow = GetApiArray()
'    list = [
'    {
'        Title:"Categories"
'        ContentList : oneRow
'    }]
'    return ParseXMLContent(list)
'end Function
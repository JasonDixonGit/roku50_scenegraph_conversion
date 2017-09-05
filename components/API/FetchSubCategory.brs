'******************************************************************
' Author: Jason Dixon
' Description:
'******************************************************************


'******************************************************************
' Description: 
'******************************************************************
sub init()
    'm.top.contentSet = false
    m.top.functionName = "getSubCategoryContent"
end sub


'******************************************************************
' Description: 
'******************************************************************
sub getSubCategoryContent()

    postergridcontent = createObject("RoSGNode","ContentNode")
    readInternet      = createObject("roUrlTransfer")
    taskPort          = CreateObject("roMessagePort")

    readInternet.SetMessagePort(taskPort)
    readInternet.EnableFreshConnection(true) 'Don't reuse existing connections
    readInternet.setUrl(m.top.subCategoryUri)

    xmlDataIn = readInternet.GetToString()
    'Print xmlDataIn
    m.top.subCategoryContent = GridrowFactory().BuildPosterGridRow(xmlDataIn)

end sub
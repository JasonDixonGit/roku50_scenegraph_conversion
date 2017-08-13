'******************************************************************
' Author: Jason Dixon
' Description:
'******************************************************************

sub init()
    'm.top.contentSet = false
    m.top.functionName = "getSubCategoryContent"
end sub

sub getSubCategoryContent()

    postergridcontent = createObject("RoSGNode","ContentNode")
    readInternet      = createObject("roUrlTransfer")
    taskPort          = CreateObject("roMessagePort")

    readInternet.SetMessagePort(taskPort)
    readInternet.EnableFreshConnection(true) 'Don't reuse existing connections
    readInternet.setUrl(m.top.subCategoryUri)

    xmlDataIn = readInternet.GetToString()
    'Print xmlDataIn
    m.top.subCategoryContent = GridrowFactory().BuildPosterGrid(xmlDataIn)' = API_Utils().ParseXMLContent(list)

end sub
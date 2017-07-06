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
    
    list0 = [{
              ContentList : landingPageRow
            }] 
            
    m.top.gridscreencontent = m.GridRowFactory().SetGridscreenContent()

end sub

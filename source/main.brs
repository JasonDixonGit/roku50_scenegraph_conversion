'******************************************************************
' Author: Jason Dixon
' Description: Main Thread. 
'******************************************************************

sub Main()
    m.device = CreateObject("roDeviceInfo")
    m.maxWidth = m.device.GetDisplaySize().w

    m.modelGeneration = 6'getModelGeneration(m.device.getModel())

    initSiteSpecificSettings()
    showChannelSGScreen()
end sub

sub showChannelSGScreen()
    m.device = CreateObject("roDeviceInfo")
    m.maxWidth = m.device.GetDisplaySize().w
    'm.modelGeneration = Utils().getModelGeneration(m.device.getModel())

    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    homeScene = screen.CreateScene("HomeScene")
    screen.show()
    
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGNodeEvent"
            

        end if  
    end while
end sub

''    m.global = screen.getGlobalNode()
''    m.global.id = "GlobalNode"
''    m.global.xfer = CreateObject("roUrlTransfer")
''
'

'' 
''    while true
''        msg = wait(0, port)
''        msgType = type(msg)
''
''        if msgType = "roSGNodeEvent"
''            'print "node "; msg.getNode()
''            'print "field name "; msg.getField()
''
''            'exit listener'
''            if(msg.getNode() = "ExitScreen" AND msg.getField() = "exitFlag")
''                if(es.exitFlag = true)
''                    exitProgram()
''                end if
''
''            end if
''        end if
''
''    end while
''
''    if screen <> invalid then
''        screen.Close()
''        screen = invalid
''    end if
''end sub
''
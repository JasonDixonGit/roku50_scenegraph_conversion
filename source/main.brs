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

    'ds   = homeScene.findNode("DetailsScreen")
    'es   = homeScene.findNode("ExitScreen")
    gs   = homeScene.findNode("GridScreen")
    loadingIndicator   = homeScene.findNode("loadingIndicator")

    'ds.observeField("visible", port)
    'ds.observeField("ready", port)
    'ds.observeField("WatchLaterFlagAction", port)
    'ds.observeField("markPlaybackPosition", port)
    'ds.observeField("moviePlayed", port)
    'es.observeField("exitFlag", port)    
    
    'dynamically control loading spinner/text based on model generation capabilities'
    if(m.modelGeneration = 4 or m.modelGeneration > 5) then
        loadingIndicator.imageVisible = true
        loadingIndicator.visible = true
        loadingIndicator.control = "start"
    end if

    if(m.modelGeneration = 3) then
        loadingIndicator.imageVisible = false
        loadingIndicator.visible = true
        loadingIndicator.control = "start"
    end if

    if(m.modelGeneration = 5) then
        loadingIndicator.imageVisible = false
        loadingIndicator.control = "start"
    end if
    
    'set global colors'
    homeScene.globalFocusedColor        = m.focusedColor
    homeScene.globalSecondaryColor      = m.secondaryColor
    homeScene.globalVideoPlayerBarColor = m.videoPlayerBarColor

''    'set global font'
    homeScene.globalFontPath = m.appFont

'   m.landingPageRow = createObject("RoSGNode","ContentNode")

'  list0 = [{
'              ContentList : m.landingPageRow
'          }]
'
'    m.landingPageRow = GridRowFactory().SetGridscreenContent()
'    homeScene.content = m.landingPageRow
    
    
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
''            else if(msg.getNode() = "DetailsScreen" AND msg.getField() = "markPlaybackPosition") then
''                RegWrite(ds.content.id, ds.markPlaybackPosition)
''
''            else if(msg.getNode() = "DetailsScreen" AND msg.getField() = "visible") then
''                'check that operation is opening not closing'
''                if(ds.visible = true) then
''                    '***** detect returning from sceneGridscreen? *******'
''
''                    if(ds.ready = false) then
''                        li.control = "start"
''                    end if
''
''                    if(ds.origin = "SearchScreen") then
''                        itemID = srch.itemIDSelected
''                        title = srch.name
''                        li.control = "start"
''                        thisContent = GridRowFactory().GetProductDetail(null, ds.origin, itemID)
''                    else
''                        itemID = ds.itemID
''                        thisContent = GridRowFactory().GetProductDetail(ds.content, ds.origin, itemID)
''                        title = thisContent.title
''                    End if
''
''                    'next two blocks prevent GA from logging page views twice during navigation into view scenes and back'
''                    if(m.movieGAFirstTimeThroughFlag = 0) then
''                        previousTitle = "initialized"
''                        m.movieGAFirstTimeThroughFlag = 1
''                    end if
''
''                    if(title <> previousTitle) then
''                        'GATrackPageView("Movie Detail Page Viewed", title)
''                    end if
''                    previousTitle = title
''
''                    if(ds.origin = "SearchScreen") then
''                        ds.content      = thisContent.content
''                    end if
''
''                    ds.previewURL       = thisContent.previewURL
''                    ds.previewFormat    = thisContent.previewFormat
''                    ds.content.HDBifurl = thisContent.HDBifurl
''                    ds.content.SDBifUrl = thisContent.SDBifUrl
''                    ds.movieURL         = thisContent.movieURL
''                    ds.content.url      = thisContent.url                    
''                    ds.hdbifurl         = thisContent.HDBifurl
''                    ds.sdbifurl         = thisContent.SDBifUrl
''                    
''                    ds.isWatchLater = thisContent.isWatchLater
''
''                    useResumeButtonset = false
''
''                    'check playback/resume'
''                    if(RegRead(ds.content.id) <> invalid) then
''                        playbackPosition = RegRead(ds.content.id)
''                        'if movie has played for > 10s, then show resume buttonset'
''                        if(strtoi(playbackPosition) > 10) then
''                            useResumeButtonset = true
''                        end if
''                        ds.bookmarkPosition = playbackPosition
''                    end if
''
''
''
''                    if(useResumeButtonset = true) then
''                        ds.buttonConfig = 0
''                        buttonList = ["Resume", "Restart"]
''                        ds.buttonsContent = ButtonListFactory().BuildButtonList(buttonList)
''                    else
''                        ds.buttonConfig = 1
''                        buttonList = ["Play"]
''                        ds.buttonsContent = ButtonListFactory().BuildButtonList(buttonList)
''                    end if
''
''                    ds.ready = true
''                    li.control = "stop"
''                end if
''           
''            else if(msg.getNode() = "DetailsScreen" AND msg.getField() = "moviePlayed") then
''                'GATrackPageView("Movie Watched: ", ds.moviePlayed)
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
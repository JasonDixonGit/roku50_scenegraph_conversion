sub RunUserInterface()
    m.device = CreateObject("roDeviceInfo")
    'm.maxWidth = m.device.GetDisplaySize().w

    m.modelGeneration = 6'getModelGeneration(m.device.getModel())

    initSiteSpecificSettings()
    'InitGATracker(m.GoogleUA, m.BaseUrlAnalytics)
    'skip login thread if already logged in'
    runApp()
end sub

sub runApp()
    port = CreateObject("roMessagePort")
    screen = CreateObject("roSGScreen")
    homeScene = screen.CreateScene("HomeScene")
    ''GATrackPageView("Home", "home")

    m.global = screen.getGlobalNode()
    m.global.id = "GlobalNode"
    m.global.xfer = CreateObject("roUrlTransfer")

    screen.SetMessagePort(port)
    screen.Show()

    ds   = homeScene.findNode("DetailsScreen")
    es   = homeScene.findNode("ExitScreen")
    gs   = homeScene.findNode("GridScreen")
    li   = homeScene.findNode("loadingIndicator")

    ds.observeField("visible", port)
    ds.observeField("ready", port)
    ds.observeField("WatchLaterFlagAction", port)
    ds.observeField("markPlaybackPosition", port)
    ds.observeField("moviePlayed", port)
    es.observeField("exitFlag", port)

    if(m.modelGeneration = 3) then
        li.imageVisible = false
    end if

    if(m.modelGeneration = 5) then
        li.imageVisible = false
        li.visible = true
        li.control = "start"
    end if

    if(m.modelGeneration = 4 or m.modelGeneration > 5) then
        li.imageVisible = true
    end if

    'set global colors'
    homeScene.globalFocusedColor        = m.focusedColor
    homeScene.globalSecondaryColor      = m.secondaryColor
    homeScene.globalVideoPlayerBarColor = m.videoPlayerBarColor

    'set global font'
    homeScene.globalFontPath = m.appFont

   m.landingPageRow = createObject("RoSGNode","ContentNode")

 ''  list0 = [{
 ''              ContentList : m.landingPageRow
 ''          }]

    m.landingPageRow = GridRowFactory().SetGridscreenContent()'GridRowFactory().SetGridscreenContent(list0)
    homeScene.content = m.landingPageRow
 
    while true
        msg = wait(0, port)
        msgType = type(msg)

        if msgType = "roSGNodeEvent"
            'print "node "; msg.getNode()
            'print "field name "; msg.getField()

            'exit listener'
            if(msg.getNode() = "ExitScreen" AND msg.getField() = "exitFlag")
                if(es.exitFlag = true)
                    exitProgram()
                end if

            else if(msg.getNode() = "DetailsScreen" AND msg.getField() = "markPlaybackPosition") then
                RegWrite(ds.content.id, ds.markPlaybackPosition)

            else if(msg.getNode() = "DetailsScreen" AND msg.getField() = "visible") then
                'check that operation is opening not closing'
                if(ds.visible = true) then
                    '***** detect returning from sceneGridscreen? *******'

                    if(ds.ready = false) then
                        li.control = "start"
                    end if

                    if(ds.origin = "SearchScreen") then
                        itemID = srch.itemIDSelected
                        title = srch.name
                        li.control = "start"
                        thisContent = GridRowFactory().GetProductDetail(null, ds.origin, itemID)
                    else
                        itemID = ds.itemID
                        thisContent = GridRowFactory().GetProductDetail(ds.content, ds.origin, itemID)
                        title = thisContent.title
                    End if

                    'next two blocks prevent GA from logging page views twice during navigation into view scenes and back'
                    if(m.movieGAFirstTimeThroughFlag = 0) then
                        previousTitle = "initialized"
                        m.movieGAFirstTimeThroughFlag = 1
                    end if

                    if(title <> previousTitle) then
                        'GATrackPageView("Movie Detail Page Viewed", title)
                    end if
                    previousTitle = title

                    if(ds.origin = "SearchScreen") then
                        ds.content      = thisContent.content
                    end if

                    ds.previewURL       = thisContent.previewURL
                    ds.previewFormat    = thisContent.previewFormat
                    ds.content.HDBifurl = thisContent.HDBifurl
                    ds.content.SDBifUrl = thisContent.SDBifUrl
                    ds.movieURL         = thisContent.movieURL
                    ds.content.url      = thisContent.url                    
                    ds.hdbifurl         = thisContent.HDBifurl
                    ds.sdbifurl         = thisContent.SDBifUrl
                    
                    ds.isWatchLater = thisContent.isWatchLater

                    useResumeButtonset = false

                    'check playback/resume'
                    if(RegRead(ds.content.id) <> invalid) then
                        playbackPosition = RegRead(ds.content.id)
                        'if movie has played for > 10s, then show resume buttonset'
                        if(strtoi(playbackPosition) > 10) then
                            useResumeButtonset = true
                        end if
                        ds.bookmarkPosition = playbackPosition
                    end if



                    if(useResumeButtonset = true) then
                        ds.buttonConfig = 0
                        buttonList = ["Resume", "Restart"]
                        ds.buttonsContent = ButtonListFactory().BuildButtonList(buttonList)
                    else
                        ds.buttonConfig = 1
                        buttonList = ["Play"]
                        ds.buttonsContent = ButtonListFactory().BuildButtonList(buttonList)
                    end if

                    ds.ready = true
                    li.control = "stop"
                end if
           
            else if(msg.getNode() = "DetailsScreen" AND msg.getField() = "moviePlayed") then
                'GATrackPageView("Movie Watched: ", ds.moviePlayed)

            end if
        end if

    end while

    if screen <> invalid then
        screen.Close()
        screen = invalid
    end if
end sub

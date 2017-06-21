Function Init()
''    ? "Init - [DetailsScreen]"

    m.top.observeField("visible", "onVisibleChange")
    m.top.observeField("focusedChild", "OnFocusedChildChange")

    m.videoPlayer       =   m.top.findNode("VideoPlayer")
    m.poster            =   m.top.findNode("Poster")
    m.description       =   m.top.findNode("Description")
    m.background        =   m.top.findNode("Background")

    m.top.viewScenes    = false
    m.top.movieHasScenes = false

    m.buttonsWLF        = m.top.findNode("ButtonsWatchLaterFalse")
    m.buttonsWLT        = m.top.findNode("ButtonsWatchlaterTrue")
    
    setButtonListProperties(m)
    
    m.buttons = m.buttonsWLF
    'AutoSelectButtonSet() 

    m.top.ready          = false
    m.top.readyToExit    = false
    m.buttonsWLF.visible = false
    m.buttonsWLT.visible = false

    'empty content object'
    m.emptyContent              = createObject("RoSGNode", "ContentNode")
    m.emptyContent.streamFormat = "hls"
    m.emptyContent.url          = ""

End Function

Function setButtonListProperties(m)
    'maybe control button list members from here depending on what data comes back from api call in Init() ???'

    m.buttonsWLF.font               = "font:LargeSystemFont"
    m.buttonsWLF.font.size          = m.buttonsWLF.font.size + 20
    m.buttonsWLF.focusedFont        = "font:LargeSystemFont"
    m.buttonsWLF.focusedFont.size   = m.buttonsWLF.focusedFont.size + 20

    m.buttonsWLT.font               = "font:LargeSystemFont"
    m.buttonsWLT.font.size          = m.buttonsWLT.font.size + 20
    m.buttonsWLT.focusedFont        = "font:LargeSystemFont"
    m.buttonsWLT.focusedFont.size   = m.buttonsWLT.focusedFont.size + 20

End Function

Function SetWatchLaterButtonProperties()
    if(m.top.isWatchlater = true) then
        '?"Watch Later Set"
        'give control to button group 1'
        m.buttons               = m.buttonsWLT
        m.buttonsWLF.visible    = false
        m.buttonsWLT.visible    = true
        m.buttons.setFocus(true)
    else
        '?"Watch Later NOT Set"
        'give control to button group 0'
        m.buttons               = m.buttonsWLF
        m.buttonsWLF.visible    = true
        m.buttonsWLT.visible    = false
        m.buttons.setFocus(true)
    end if
end Function

Function OnReady()
    if(m.top.ready = true) then
        'm.buttons.jumpToItem   = 0
        'm.buttons.visible      = true
        SetWatchLaterButtonProperties()
        setCustomFont()
        m.buttons.jumpToItem    = 0

        'prebuffer first choice - either resume or play'
        if(m.top.buttonConfig = 0) then
            m.top.content.playstart = m.top.bookmarkPosition
            m.videoPlayer.control   = "prebuffer"
        else if(m.top.buttonConfig = 1) then
            m.top.content.playstart = 0
            m.videoPlayer.control = "prebuffer"
        end if
    end if
end function

Function setCustomFont()
    m.buttonsWLF.font.uri               = m.top.font
    m.buttonsWLF.focusedFont.uri        = m.top.font
    m.buttonsWLT.font.uri               = m.top.font
    m.buttonsWLT.focusedFont.uri        = m.top.font
End Function

' set proper focus to buttons if Details opened and stops Video if Details closed
Sub onVisibleChange()
    '? "[DetailsScreen] onVisibleChange"

    if m.top.visible = true then
        'clear buttons'
        m.buttonsWLF.visible = false
        m.buttonsWLT.visible = false
        'if returning from scenes gridscreen'
        if(m.top.ready = true)
            SetWatchLaterButtonProperties()
        end if
    else
        m.videoPlayer.visible = false
        m.videoPlayer.control = "stop"
        m.videoPlayer.content = m.emptyContent
        m.poster.uri=""
        m.background.uri=""
    end if
End Sub

' set proper focus to Buttons in case if return from Video PLayer
Sub OnFocusedChildChange()
    '?"OnFocusedChildChange"
    if m.top.isInFocusChain() and not m.buttons.hasFocus() and not m.videoPlayer.hasFocus() then
       m.buttons.setFocus(true)
    end if
End Sub

' set proper focus on buttons and stops video if return from Playback to details
Sub onVideoVisibleChange()
    if m.videoPlayer.visible = false and m.top.visible = true
        m.buttons.setFocus(true)
        m.videoPlayer.control = "stop"
    end if
End Sub

Function OnVideoPlaybackPositionChange()
    position =  m.videoPlayer.position
    'mark playback position every 2 seconds, after 10 seconds'
    if(position mod 2 = 0 AND position > 10) then
        m.top.markPlaybackPosition = fix(position)
    end if
end Function

' event handler of Video player msg
Sub OnVideoPlayerStateChange()
    if m.videoPlayer.state  = "error"
        ' error handling
        ?"ERROR"
        m.videoPlayer.visible = false
    else if m.videoPlayer.state = "playing"
        ' playback handling
        '?"playing"
    else if m.videoPlayer.state = "finished"
        '?"finished"
        m.videoPlayer.visible = false
        'm.videoPlayer.control = "stop"
    end if
End Sub

' on Button press handler -- ready must = true for action
Sub onItemSelected()
    
    setVideoPlayerColors()

    if(m.buttons.id = "ButtonsWatchLaterFalse") then
        m.itemSelected = m.top.itemSelected0
    else
        m.itemSelected = m.top.itemSelected1
    end if

    'first button is preview or resume
    if m.itemSelected = 0
        'preview movie
        if(m.top.ready = true) then
            if(m.top.buttonConfig = 0) then
                setVideoPlayerColors()
                '?"Play Selected"
                if(m.top.preview = true) then
                    m.top.preview = false
                    m.top.content.url = m.top.movieURL
                    m.top.content.streamFormat = "hls"
                    m.top.content.hdbifurl = m.top.hdbifurl
                    m.top.content.sdbifurl = m.top.sdbifurl
                end if
                m.top.content.playstart = m.top.bookmarkPosition
                m.videoPlayer.visible = true
                m.videoPlayer.setFocus(true)
                m.videoPlayer.control = "play"
                m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
                m.videoPlayer.observeField("position", "OnVideoPlaybackPositionChange")'track playback position'
                m.top.moviePlayed = m.top.content.title

            else if(m.top.buttonConfig = 1) then
                setVideoPlayerColors()
                '?"Preview Selected"
                m.top.preview = true
                m.top.content.url = m.top.previewURL
                m.top.content.streamFormat = m.top.previewFormat

                m.top.hdbifurl = m.top.content.hdbifurl
                m.top.sdbifurl = m.top.content.sdbifurl

                m.top.content.hdbifurl = ""
                m.top.content.sdbifurl = ""
                'type should be present in the content object, overwriting any previous mp4 setting from a preview'
                'Print(m.top.content)
                m.top.content.playstart = 0
                m.videoPlayer.visible = true
                m.videoPlayer.setFocus(true)
                m.videoPlayer.control = "play"
                m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
            else
                Print "Error in details screen button config. Value is: ", m.top.buttonConfig
            end if
        end if
    end if
    ' second button is Play
    if m.itemSelected = 1
        if(m.top.ready = true) then
            setVideoPlayerColors()
            '?"Play Selected"
            if(m.top.preview = true) then
                m.top.preview = false
                m.top.content.url = m.top.movieURL
                m.top.content.streamFormat = "hls"
                m.top.content.hdbifurl = m.top.hdbifurl
                m.top.content.sdbifurl = m.top.sdbifurl
            end if
            m.top.content.playstart = 0
            m.videoPlayer.visible = true
            m.videoPlayer.setFocus(true)
            m.videoPlayer.control = "play"
            m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
            m.videoPlayer.observeField("position", "OnVideoPlaybackPositionChange")'track playback position'
            m.top.moviePlayed = m.top.content.title
        end if
    end if
    'third button is watch later
    if m.itemSelected = 2
        if(m.top.ready = true) then
            if(m.top.isWatchlater = true) then
                m.top.isWatchlater = false
                SetWatchLaterButtonProperties()
                m.top.WatchLaterFlagAction = "clear"
            else
                m.top.isWatchlater = true
                SetWatchLaterButtonProperties()
                m.top.WatchLaterFlagAction = "set"
            end if
        end if
    end if
    'fourth button is view scenes
    if m.itemSelected = 3
        if(m.top.ready = true) then
            m.top.viewScenes = true
       end if
    end if
End Sub

' Content change handler
Sub OnContentChange()
    m.description.content   = m.top.content
    m.description.Description.width = "770"
    m.videoPlayer.content   = m.top.content
    'm.top.streamUrl         = m.top.content.streamUrl
    m.poster.uri            = m.top.content.HDPosterUrl
    m.background.uri        = m.top.content.hdBackgroundImageUrl
End Sub

Function setVideoPlayerColors()
    m.videoPlayerColor = m.top.VideoPlayerColor

    bif = m.videoPlayer.bifDisplay
    bif.frameBgBlendColor = m.videoPlayerColor

    tpbar = m.videoPlayer.trickPlayBar
    tpbar.filledBarBlendColor = m.videoPlayerColor 

    rtBar = m.videoPlayer.retrievingBar
    rtBar.filledBarBlendColor = m.videoPlayerColor

    bfBar = m.videoPlayer.bufferingBar
    bfBar.filledBarBlendColor = m.videoPlayerColor
end Function
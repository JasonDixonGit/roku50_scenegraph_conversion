Function Init()
''    ? "Init - [DetailsScreen]"

    m.top.observeField("visible", "onVisibleChange")
    m.top.observeField("focusedChild", "OnFocusedChildChange")

    m.videoPlayer       =   m.top.findNode("VideoPlayer")
    m.poster            =   m.top.findNode("Poster")
    m.description       =   m.top.findNode("Description")
    m.background        =   m.top.findNode("Background")

    m.buttons           = m.top.findNode("Buttons")
     
    setButtonListProperties(m)

    m.top.ready          = false
    m.top.readyToExit    = false
End Function

Function setButtonListProperties(m)

    m.buttons.font               = "font:LargeSystemFont"
    m.buttons.font.size          = m.buttons.font.size + 20
    m.buttons.focusedFont        = "font:LargeBoldSystemFont"
    m.buttons.focusedFont.size   = m.buttons.focusedFont.size + 28

End Function

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

    if m.top.visible = true then
        'clear buttons'
        'm.buttons.visible = false'?????????????????????????
    else
        m.videoPlayer.visible = false
        m.videoPlayer.control = "stop"
        m.poster.uri=""
        m.background.uri=""
    end if
End Sub

'set proper focus to Buttons in case if return from Video PLayer
Sub OnFocusedChildChange()
    '?"OnFocusedChildChange"
    if m.top.isInFocusChain() and not m.buttons.hasFocus() and not m.videoPlayer.hasFocus() then
       m.buttons.setFocus(true)
    end if
End Sub

'set proper focus on buttons and stops video if return from Playback to details
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

    m.itemSelected = m.top.itemSelected

    'first button is preview or resume
    if m.itemSelected = 0
        'preview movie
        if(m.top.ready = true) then
            if(m.top.buttonConfig = 0) then
                'setVideoPlayerColors()
                '?"Play Selected"
                m.top.content.playstart = m.top.bookmarkPosition
                m.videoPlayer.visible = true
                m.videoPlayer.setFocus(true)
                m.videoPlayer.control = "play"
                m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
                m.videoPlayer.observeField("position", "OnVideoPlaybackPositionChange")'track playback position'
                m.top.moviePlayed = m.top.content.title

            else if(m.top.buttonConfig = 1) then
                'setVideoPlayerColors()
                '?"Play Selected - first time on item"
         
                m.top.content.playstart = 0
                m.videoPlayer.visible = true
                m.videoPlayer.setFocus(true)
                m.videoPlayer.control = "play"
                m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
                m.videoPlayer.observeField("position", "OnVideoPlaybackPositionChange")'track playback position'
                m.top.moviePlayed = m.top.content.title
            else
                Print "Error in details screen button config. Value is: ", m.top.buttonConfig
            end if
        end if
    end if
    
    ' second button is Restart if resume is set
    if m.itemSelected = 1
        if(m.top.ready = true) then
            setVideoPlayerColors()
            '?"Play Selected"
            m.top.content.playstart = 0
            m.videoPlayer.visible = true
            m.videoPlayer.setFocus(true)
            m.videoPlayer.control = "play"
            m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
            m.videoPlayer.observeField("position", "OnVideoPlaybackPositionChange")'track playback position'
            m.top.moviePlayed = m.top.content.title
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
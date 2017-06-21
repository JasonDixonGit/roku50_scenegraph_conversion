Function initSiteSpecificSettings()
    app = CreateObject("roAppManager")
    
    m.BaseUrlAnalytics              = "roku.cs50.com"
    m.TrackingPrefix                = ""
    m.SiteName                      = "Elegant Angel"
    m.GoogleUA                      = "UA-54914523-54"
    m.RegistryKeyName               = "EAAuth"


    m.MP4StreamingServers           = getStreamingServersURL(m.SiteCode, m.BaseUrl)

    m.primaryColor                  = "#ffffff"
    m.secondaryColor                = "#E40090" 
    m.focusedColor                  = "#E40090"
    m.videoPlayerBarColor           = "0xE40090FF" 
    m.shadeColor                    = "200"
    m.appFont                       = "pkg:/fonts/Helvetica.ttf"

    ' Theme
    m.theme = CreateObject("roAssociativeArray")
    m.theme.BackgroundColor = "#000000"  
    app.SetTheme(m.theme)

    ' Globals
    m.device = CreateObject("roDeviceInfo")

    'single message port
    m.AddReplace("Port", CreateObject("roMessagePort"))
end Function
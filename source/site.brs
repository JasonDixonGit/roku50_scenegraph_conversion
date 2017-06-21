Function initSiteSpecificSettings()
    app = CreateObject("roAppManager")

    m.ApiKey                        = "510a31ef21144bde49d75149ff96947b1f6037e0"
    m.ApiSecretKey                  = "M2U2NmI0ZGM0MjBiZGExNzdlNTJmZTQ2YjgyMTQ4"

    m.BaseUrlAnalytics              = "roku.adultempire.com"
    m.TrackingPrefix                = ""
    m.BaseUrl                       = "www.empirestores.co"
    m.SiteName                      = "Elegant Angel"
    m.SiteCode                      = "elegantangel"
    m.SiteID                        = 1
    m.GoogleUA                      = "UA-54914523-54"
    m.webUrl                        = "www.elegantangel.com"
    m.RegistryKeyName               = "EAAuth"

    domains                         = []
    domains                         = getAppDomains()
    m.ImageDomain                   = domains.ImageDomain
    m.CapsDomain                    = domains.CapsDomain
    m.PerformerDomain               = domains.PerformerDomain
    m.StudioDomain                  = domains.StudioDomain
    m.DefaultImageServer            = domains.DefaultImageServer
    m.DefaultFrameImageServer       = domains.DefaultFrameImageServer
    m.MissingHeadshotUrl_Male       = domains.MissingHeadshotUrl_Male
    m.MissingHeadshotUrl_Female     = domains.MissingHeadshotUrl_Female
    m.MainScreenImageHD             = domains.MainScreenImageHD
    m.MainScreenImageSD             = domains.MainScreenImageSD
    m.JoinNowBannerHD               = domains.JoinNowBannerHD
    m.BoxcoverUnlimitedSashImage    = domains.BoxcoverUnlimitedSashImage
    m.BoxcoverHDIndicatorImage      = domains.BoxcoverHDIndicatorImage
    m.LegacyView                    = true'no ppm

    m.MP4StreamingServers           = getStreamingServersURL(m.SiteCode, m.BaseUrl)

    'controls browse lists'
    m.initBrowseMovieCatetories     = true
    m.initBrowseSceneTags           = true

    m.PreviewFormat                 = "mp4"
    m.TrailerFormat                 = "hls" 
    m.SceneName                     = "Scene"

    m.SupportEmailAddress           = "info@empirestores.co"
    m.WhatsNewVersion               = "0.1"

    m.primaryColor                  = "#ffffff"
    m.secondaryColor                = "#E40090" 
    m.focusedColor                  = "#E40090"
    m.videoPlayerBarColor           = "0xE40090FF" 
    m.shadeColor                    = "200"
    m.appFont                       = "pkg:/fonts/Helvetica.ttf"
    m.appSecondaryFont              = "pkg:/fonts/Assistant-Regular.ttf"
    m.standard_fl = "id,content_standard_details,content_content_details,content_vod_details"
    ' Theme
    m.theme = CreateObject("roAssociativeArray")

    m.theme.BackgroundColor = "#000000"
'
    m.theme.OverhangOffsetHD_X = "100"
    m.theme.OverhangOffsetHD_Y = "40"
    m.theme.OverhangOffsetSD_X = "60"
    m.theme.OverhangOffsetSD_Y = "35"
'   
    m.theme.OverhangSliceHD = "pkg://images/overhang_slice_hd.jpg"
    m.theme.OverhangSliceSD = "pkg://images/overhang_slice_sd.jpg"

    'welcome and registration dialogs color'
    m.theme.RegistrationCodeColor = "#E40090"
    m.theme.RegistrationFocalColor = "#FFFFFF"
    m.theme.RegistrationFocalRectColor = "#E40090"

    m.theme.loadingScreenText = "Elegant Angel..."
    
    app.SetTheme(m.theme)

    m.performerGAFirstTimeThroughFlag      = 0
    m.movieGAFirstTimeThroughFlag          = 0

    ' Globals
    m.device = CreateObject("roDeviceInfo")
    'm.maxWidth = m.device.GetDisplaySize().w

    'single message port
    m.AddReplace("Port", CreateObject("roMessagePort"))
    m.AddReplace("API", API_Utilities(m.ApiKey, m.ApiSecretKey))
    'm.AddReplace("ServerSettings", m.API.GetServerSettings())
end Function
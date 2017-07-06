Function initSiteSpecificSettings()
    app = CreateObject("roAppManager")
  
    m.RegistryKeyName               = "cs50"

    m.primaryColor                  = "#f1f1f1"
    m.secondaryColor                = "#E40090" 
    m.focusedColor                  = "#ffffff"
    m.videoPlayerBarColor           = "0xE40090FF" 
    m.shadeColor                    = "200"
    m.appFont                       = "pkg:/fonts/SourceSansPro-Light.ttf"

    ' Theme
    m.theme = CreateObject("roAssociativeArray")
    m.theme.BackgroundColor = "#000000"  
    app.SetTheme(m.theme)

    ' Globals
    m.device = CreateObject("roDeviceInfo")

    'single message port
    m.AddReplace("Port", CreateObject("roMessagePort"))
end Function
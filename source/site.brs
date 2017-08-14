Function initSiteSpecificSettings()
    app = CreateObject("roAppManager")
  
    m.RegistryKeyName               = "cs50"

    ' Globals
    m.device = CreateObject("roDeviceInfo")

    'single message port
    m.AddReplace("Port", CreateObject("roMessagePort"))
end Function
Function GridRowFactory() as Object
    this = {
        
        BuildCategoryGridRow:   BuildCategoryGridRow
        'GetRow:                 GetRow
        'SetGridscreenContent:   SetGridscreenContent
    }
    return this
End Function

Function BuildCategoryGridRow(xmlDataIn)
responseXML = API_Utils().ParseXML2(xmlDataIn)
    
    responseArray = responseXML.GetChildElements()
    result = []

    for each xmlItem in responseArray
        if xmlItem.getName() = "category"
            item = {}
            item["Title"] = xmlItem.getAttributes().title
            item["HDPosterUrl"] = xmlItem.getAttributes().hd_img
            item["SDPosterUrl"] = xmlItem.getAttributes().sd_img
            'item["DESCRIPTION"] = xmlItem.getAttributes().title
            item["HDBackgroundImageUrl"] = "pkg:/images/background.jpg"
            item["SDBackgroundImageUrl"] = "pkg:/images/background.jpg"
            'Print item
           result.push(item)
        end if
    end for
    
    categoriesList = [{
              Title: "Categories"
              ContentList : result
            }] 
    
    return API_Utils().ParseXMLContent(categoriesList)
end function

Function GetRow()
    url = CreateObject("roUrlTransfer")

End Function    
Function GridRowFactory() as Object
    this = {
        
        BuildCategoryGridRow:        GridRowFactory_BuildCategoryGridRow
        BuildPosterGrid:             GridRowFactory_BuildPosterGrid
    }
    return this
End Function

Function GridRowFactory_BuildCategoryGridRow(xmlDataIn)
    responseXML = API_Utils().ParseXML2(xmlDataIn)
    
    responseArray = responseXML.GetChildElements()
    result = []

    categoryFeedLinks = []

    for each xmlItem in responseArray
        if xmlItem.getName() = "category"

            item = {}
            'item["Title"] = xmlItem.getAttributes().title
            item["HDPosterUrl"] = xmlItem.getAttributes().hd_img
            item["SDPosterUrl"] = xmlItem.getAttributes().sd_img
            item["DESCRIPTION"] = xmlItem.getAttributes().title
            item["HDBackgroundImageUrl"] = "pkg:/images/background.jpg"
            item["SDBackgroundImageUrl"] = "pkg:/images/background.jpg"

            leaves = xmlItem.GetChildElements()
            titles = []
            feedLinks = []

            for each leaf in leaves
                'print leaf.getAttributes().title, leaf.getAttributes().feed
                titles.push(leaf.getAttributes().title)
                feedLinks.push(leaf.getAttributes().feed)
            next

            item["Actors"] = titles 'this is a string array content meta variable -- use to pass titles
            item["Directors"] = feedLinks 'this is a string array content meta variable -- use to pass feed urls
            'Print item
           result.push(item)
        end if
    end for
    
    categoriesList = [{
              Title: "Course Years"
              ContentList : result
            }] 
    
    return API_Utils().ParseXMLContent(categoriesList)
end function

Function GridRowFactory_BuildPosterGrid(xmlDataIn)

    responseXML = API_Utils().ParseXML2(xmlDataIn)
    responseArray = responseXML.GetChildElements()
    
    'check that incoming JSON is not empty
    if(results <> invalid) then
        hasNext = true
    end if
 
    index = 0

    for each xmlItem in responseArray
        if xmlItem.getName() = "item"
            rowItem = posterRow.createChild("ContentNode")
            'rowItem["id"] = xmlItem.getAttributes().hd_img
            'rowItem["Title"] = xmlItem.getAttributes().title
            rowItem["SDPosterUrl"] = xmlItem.getAttributes().sdImg
            rowItem["HDPosterUrl"] = xmlItem.getAttributes().hdImg
            rowItem["shortdescriptionline1"] = xmlItem.getAttributes().title
            'rowItem["shortdescriptionline2"] = results.data.getEntry(index).attributes.genre  
       end if
    next

    return posterRow
End Function

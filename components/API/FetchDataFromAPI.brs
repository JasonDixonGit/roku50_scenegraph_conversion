'******************************************************************
' Author: Jason Dixon
' Description:
'******************************************************************

sub init()
    m.top.contentSet = false
    m.top.functionName = "getContent"
end sub

sub getContent()

    postergridcontent = createObject("RoSGNode","ContentNode")
    readInternet      = createObject("roUrlTransfer")
    taskPort          = CreateObject("roMessagePort")

    readInternet.SetMessagePort(taskPort)
    readInternet.EnableFreshConnection(true) 'Don't reuse existing connections
    readInternet.setUrl(m.top.postergriduri)

    xmlDataIn = readInternet.GetToString()
    responseXML = ParseXML2(xmlDataIn)
    
    responseArray = responseXML.GetChildElements()
    result = []

    for each xmlItem in responseArray
        if xmlItem.getName() = "category"
            '?"================================= item ====================================="
            'Print xmlItem.getAttributes().title, xmlItem.getAttributes().hd_img, xmlItem.getAttributes.sd_img
            'itemAA = xmlItem.GetChildElements()
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
    
    list = [{
              Title: "Categories"
              ContentList : result
            }] 
    
    m.top.gridscreencontent = ParseXMLContent(list)'BuildGridscreenContent'm.GridRowFactory().SetGridscreenContent()

end sub

Function BuildGridscreenContent()
    
    oneRow = GetApiArray()
    list = [
    {
        Title:"Categories"
        ContentList : oneRow
    }]
    return ParseXMLContent(list)
end Function

Function ParseXMLContent(list As Object)
    RowItems = createObject("RoSGNode","ContentNode")
    
    for each rowAA in list
        row = createObject("RoSGNode","ContentNode")
        row.Title = rowAA.Title

        for each itemAA in rowAA.ContentList
            item = createObject("RoSGNode","ContentNode")
            ' We don't use item.setFields(itemAA) as doesn't cast streamFormat to proper value
            for each key in itemAA
                item[key] = itemAA[key]
            end for
            row.appendChild(item)
        end for
        RowItems.appendChild(row)
    end for

    return RowItems
End Function

'Function ParseXMLContent(list As Object)
'    RowItems = createObject("RoSGNode","ContentNode")
'    
'    for each rowAA in list
'        row = createObject("RoSGNode","ContentNode")
'        row.Title = rowAA.Title
'
'        for each itemAA in rowAA.ContentList
'            item = createObject("RoSGNode","ContentNode")
'            ' We don't use item.setFields(itemAA) as doesn't cast streamFormat to proper value
'            for each key in itemAA
'                item[key] = itemAA[key]
'            end for
'            row.appendChild(item)
'        end for
'        RowItems.appendChild(row)
'    end for
'
'    return RowItems
'End Function


Function GetApiArray()
    url = CreateObject("roUrlTransfer")

    url.SetUrl("http://cs50.tv/?output=roku")
    rsp = url.GetToString()
 
    responseXML = ParseXML2(rsp)
    'printAny(0, "", rsp)

    'responseXML = rsp.GetChildElements()
    responseArray = responseXML.GetChildElements()

    result = []

    for each xmlItem in responseArray
        if xmlItem.getName() = "category"
            '?"================================= item ====================================="
            'Print xmlItem.getAttributes().title, xmlItem.getAttributes().hd_img, xmlItem.getAttributes.sd_img
            'itemAA = xmlItem.GetChildElements()
            item = {}
            item["Title"] = xmlItem.getAttributes().title
            item["HDPosterUrl"] = xmlItem.getAttributes().hd_img
            item["SDPosterUrl"] = xmlItem.getAttributes().sd_img
            'item["DESCRIPTION"] = xmlItem.getAttributes().title
            item["HDBackgroundImageUrl"] = "pkg:/images/background.jpg"
            item["SDBackgroundImageUrl"] = "pkg:/images/background.jpg"

           result.push(item)
        end if
    end for

    return result
End Function


Function ParseXML2(str As String) As dynamic
    if str = invalid return invalid
    xml = CreateObject("roXMLElement")
    if not xml.Parse(str) return invalid
    return xml
End Function

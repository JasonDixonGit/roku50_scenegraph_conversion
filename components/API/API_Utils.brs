'******************************************************************
' Author: Jason Dixon
' Description: Functions to help parse xml content into content nodes
'******************************************************************


'******************************************************************
' Description: Accessor Function for API_Utils file
'******************************************************************
Function API_Utils() as Object
    this = {
        
        ParseXMLContent:           API_ParseXMLContent
        ParsePosterGridXMLContent: API_ParsePosterGridXMLContent
        ParseXML2:                 API_ParseXML2
    }
    return this
End Function


'******************************************************************
' Description: takes in XML object and returns ContentNode object
' for RowList content
'******************************************************************
Function API_ParseXMLContent(list As Object)
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


'******************************************************************
' Description: Takes in XML object and returns ContentNode object
' for postergrid content
'******************************************************************
Function API_ParsePosterGridXMLContent(list As Object)
    RowItems = createObject("RoSGNode","ContentNode")
    
    for each rowAA in list
        row = createObject("RoSGNode","ContentNode")

        for each itemAA in rowAA
            row[itemAA] = rowAA.Lookup(itemAA)
        end for

        RowItems.appendChild(row)
    end for

    return RowItems
End Function


'******************************************************************
' Description: parses string into xml object - ad hoc method 
' overriding via renaming
'******************************************************************
Function API_ParseXML2(xmlString As String) As dynamic
    '?">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    '    Print xmlString
    '?"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    if(xmlString = invalid) then 
        return invalid
    end if

    xml = CreateObject("roXMLElement")
    if(xml.Parse(xmlString)) then
        return xml
    else
        '?">>>>>>>>>>>>>>>> HIT INVALID <<<<<<<<<<<<<<<"
        '    Print xmlString
        '?">>>>>>>>>>>>>>>>>>>>>>>> INVALID >>>>>>>>>>>>>>"
         return invalid
    end if
End Function
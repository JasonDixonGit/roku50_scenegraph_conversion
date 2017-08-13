Function API_Utils() as Object
    this = {
        
        ParseXMLContent:        API_ParseXMLContent
        ParsePosterGridXMLContent: API_ParsePosterGridXMLContent
        ParseXML2:              API_ParseXML2
    }
    return this
End Function

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

Function API_ParsePosterGridXMLContent(list As Object)
    RowItems = createObject("RoSGNode","ContentNode")
    
    for each rowAA in list
        row = createObject("RoSGNode","ContentNode")
        'Print rowAA
        
        'row[rowAA] = list[rowAA]
        for each itemAA in rowAA
            'Print itemAA, rowAA.Lookup(itemAA)
            row[itemAA] = rowAA.Lookup(itemAA)
        end for
        RowItems.appendChild(row)
    end for

    return RowItems
End Function


Function API_ParseXML2(str As String) As dynamic
    if str = invalid return invalid
    xml = CreateObject("roXMLElement")
    if not xml.Parse(str) return invalid
    return xml
End Function

Function GridRowFactory() as Object
    this = {
        
        BuildRow:               BuildRow
        GetRow:                 GetRow
        SetGridscreenContent:   SetGridscreenContent
    }
    return this
End Function

Function BuildRow(row)
    for each movie in row
        rowItem = row.createChild("ContentNode")
        rowItem["id"] = movie.BasicResponseGroup.id
        rowItem["Title"] = movie.BasicResponseGroup.title
        rowItem["LENGTH"] = movie.BasicResponseGroup.length
        rowItem["HDPosterUrl"] = movie.BasicResponseGroup.boxcover
        if(movie.BasicResponseGroup.description = "No Description") then
            rowItem["DESCRIPTION"] = " "
        else
            rowItem["DESCRIPTION"] = movie.BasicResponseGroup.description
        end if
        rowItem["ReleaseDate"] = movie.BasicResponseGroup.releaseDate
        rowItem["url"] = movie.BasicResponseGroup.contentURL
        rowItem["HDBackgroundImageUrl"] = movie.BasicResponseGroup.backgroundUrl
        rowItem["SDBackgroundImageUrl"] = movie.BasicResponseGroup.backgroundUrl
        rowItem["shortdescriptionline2"] = movie.BasicResponseGroup.master_item_id_content
        rowItem["STREAMFORMAT"] = "hls"
    end for
    return row

end function

Function GetRow()
    url = CreateObject("roUrlTransfer")

End Function    


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
            
            'if itemAA <> invalid
            '    item = {}
            '    for each xmlItem in itemAA
            '        item[xmlItem.getName()] = xmlItem.getText()
            '        Print xmlItem.getAttributes().title, xmlItem.getAttributes().feed, xmlItem.getAttributes().hd_img
            '    end for
            Print item
                result.push(item) ''   conn = InitCategoryFeedConnection()
 ''   m.Categories = conn.LoadCategoryFeed(conn)
    'm.CategoryNames = conn.GetCategoryNames(m.Categories)
    'PrintAny(-0, "====================================================================", m.Categories)
    'PrintAny(5, "CATEGORY NAMES ----->", m.CategoryNames)
    
''    for each k in m.Categories.kids
''        item = createObject("RoSGNode","ContentNode")
''
''        item["id"] = productContent.BasicResponseGroup.id
''        item["Title"] = productContent.BasicResponseGroup.title
''        item["LENGTH"] = productContent.BasicResponseGroup.length
''        item["HDPosterUrl"] = productContent.BasicResponseGroup.boxcover
''        if(productContent.BasicResponseGroup.description = "No Description") then
''            item["DESCRIPTION"] = " "
''        else
''            item["DESCRIPTION"] = productContent.BasicResponseGroup.description
''        end if
''        item["ReleaseDate"] = productContent.BasicResponseGroup.resleaseDate
''        item["url"] = productContent.BasicResponseGroup.contentURL
''        item["HDBackgroundImageUrl"] = ""
''        item["SDBackgroundImageUrl"] = ""
''        item["shortdescriptionline2"] = ""
''        'item["Actors"] = movie.BasicResponseGroup.actors
''        item["STREAMFORMAT"] = "mp4"
''    next
''    return m.Categories.kids
'end Function
            'end if
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
'************************************************************
'** initialize the category tree.  We fetch a category list
'** from the server, parse it into a hierarchy of nodes and
'** then use this to build the home screen and pass to child
'** screen in the heirarchy. Each node terminates at a list
'** of content for the sub-category describing individual videos
'************************************************************
'Function initCategoryList() As Void
'
'    conn = InitCategoryFeedConnection()
'
'    m.Categories = conn.LoadCategoryFeed(conn)
'    m.CategoryNames = conn.GetCategoryNames(m.Categories)
'
'End Function

'******************************************************
' Set up the category feed connection object
' This feed provides details about top level categories 
'******************************************************
Function InitCategoryFeedConnection() As Object

    conn = CreateObject("roAssociativeArray")

    conn.UrlPrefix   = "http://cs50.tv"
    conn.UrlCategoryFeed = conn.UrlPrefix + "/?output=roku"

    conn.Timer = CreateObject("roTimespan")

    conn.LoadCategoryFeed    = load_category_feed
    conn.GetCategoryNames    = get_category_names

    print "created feed connection for " + conn.UrlCategoryFeed
    return conn

End Function


'******************************************************************
'** Given a connection object for a category feed, fetch,
'** parse and build the tree for the feed.  the results are
'** stored hierarchically with parent/child relationships
'** with a single default node named Root at the root of the tree
'******************************************************************
Function load_category_feed(conn As Object) As Dynamic

    http = NewHttp(conn.UrlCategoryFeed)

    Dbg("url: ", http.Http.GetUrl())

    m.Timer.Mark()
    rsp = http.GetToStringWithRetry()
    'Dbg("Took: ", m.Timer)

    m.Timer.Mark()
    xml=CreateObject("roXMLElement")
    if not xml.Parse(rsp) then
         print "Can't parse feed"
        return invalid
    endif
    'Dbg("Parse Took: ", m.Timer)

    m.Timer.Mark()
    if xml.category = invalid then
        print "no categories tag"
        return invalid
    endif

    if islist(xml.category) = false then
        print "invalid feed body"
        return invalid
    endif

    if xml.category[0].GetName() <> "category" then
        print "no initial category tag"
        return invalid
    endif

    topNode = MakeEmptyCatNode()
    topNode.Title = "root"
    topNode.isapphome = true

    print "begin category node parsing"

    categories = xml.GetChildElements()
    print "number of categories: " + itostr(categories.Count())
    for each e in categories 
        o = ParseCategoryNode(e)
        if o <> invalid then
            topNode.AddKid(o)
            print "added new child node"
        else
            print "parse returned no child node"
        endif
    next
    'Dbg("Traversing: ", m.Timer)

    return topNode

End Function

'*********************************************************
'** Create an array of names representing the children
'** for the current list of categories. This is useful
'** for filling in the filter banner with the names of
'** all the categories at the next level in the hierarchy
'*********************************************************
Function get_category_names(categories As Object) As Dynamic

    categoryNames = CreateObject("roArray", 100, true)

    for each category in categories.kids
        'print category.Title
        categoryNames.Push(category.Title)
    next

    return categoryNames

End Function

'******************************************************
'MakeEmptyCatNode - use to create top node in the tree
'******************************************************
Function MakeEmptyCatNode() As Object
    return init_category_item()
End Function


'***********************************************************
'Given the xml element to an <Category> tag in the category
'feed, walk it and return the top level node to its tree
'***********************************************************
Function ParseCategoryNode(xml As Object) As dynamic
    o = init_category_item()

    print "ParseCategoryNode: " + xml.GetName()
    'PrintXML(xml, 5)

    'parse the curent node to determine the type. everything except
    'special categories are considered normal, others have unique types 
    if xml.GetName() = "category" then
        print "category: " + xml@title '+ " | " + xml@description
        o.Type = "normal"
        o.Title = xml@title
        o.Description = xml@Description
        o.ShortDescriptionLine1 = xml@Title
        o.ShortDescriptionLine2 = xml@Description
        o.SDPosterURL = xml@sd_img
        o.HDPosterURL = xml@hd_img
    else if xml.GetName() = "categoryLeaf" then
        o.Type = "normal"
    else if xml.GetName() = "specialCategory" then
        if invalid <> xml.GetAttributes() then
            for each a in xml.GetAttributes()
                if a = "type" then
                    o.Type = xml.GetAttributes()[a]
                    print "specialCategory: " + xml@type + "|" + xml@title + " | " + xml@description
                    o.Title = xml@title
                    o.Description = xml@Description
                    o.ShortDescriptionLine1 = xml@Title
                    o.ShortDescriptionLine2 = xml@Description
                    o.SDPosterURL = xml@sd_img
                    o.HDPosterURL = xml@hd_img
                endif
            next
        endif
    else
        print "ParseCategoryNode skip: " + xml.GetName()
        return invalid
    endif

    'only continue processing if we are dealing with a known type
    'if new types are supported, make sure to add them to the list
    'and parse them correctly further downstream in the parser 
    while true
        if o.Type = "normal" exit while
        if o.Type = "special_category" exit while
        print "ParseCategoryNode unrecognized feed type"
        return invalid
    end while 

    'get the list of child nodes and recursed
    'through everything under the current node
    if(xml.GetBody() <> invalid) then
        for each e in xml.GetBody()
            if(e <> invalid) then
                name = e.GetName()
                if name = "category" then
                    print "category: " + e@title + " [" + e@description + "]"
                    kid = ParseCategoryNode(e)
                    kid.Title = e@title
                    kid.Description = e@Description
                    kid.ShortDescriptionLine1 = xml@Description
                    kid.SDPosterURL = xml@sd_img
                    kid.HDPosterURL = xml@hd_img
                    o.AddKid(kid)
                else if name = "categoryLeaf" then
                    print "categoryLeaf: " + e@title + " [" + e@description + "]"
                    kid = ParseCategoryNode(e)
                    kid.Title = e@title
                    kid.Description = e@Description
                    kid.Feed = e@feed
                    o.AddKid(kid)
                else if name = "specialCategory" then
                    print "specialCategory: " + e@title + " [" + e@description + "]"
                    kid = ParseCategoryNode(e)
                    kid.Title = e@title
                    kid.Description = e@Description
                    kid.sd_img = e@sd_img
                    kid.hd_img = e@hd_img
                    kid.Feed = e@feed
                    o.AddKid(kid)
                end if
            end if
        next
    end if

    return o
End Function


'******************************************************
'Initialize a Category Item
'******************************************************
Function init_category_item() As Object
    o = CreateObject("roAssociativeArray")
    o.Title       = ""
    o.Type        = "normal"
    o.Description = ""
    o.Kids        = CreateObject("roArray", 100, true)
    o.Parent      = invalid
    o.Feed        = ""
    o.IsLeaf      = cn_is_leaf
    o.AddKid      = cn_add_kid
    return o
End Function


'********************************************************
'** Helper function for each node, returns true/false
'** indicating that this node is a leaf node in the tree
'********************************************************
Function cn_is_leaf() As Boolean
    if m.Kids.Count() > 0 return true
    if m.Feed <> "" return false
    return true
End Function


'*********************************************************
'** Helper function for each node in the tree to add a 
'** new node as a child to this node.
'*********************************************************
Sub cn_add_kid(kid As Object)
    if kid = invalid then
        print "skipping: attempt to add invalid kid failed"
        return
     endif
    
    kid.Parent = m
    m.Kids.Push(kid)
End Sub


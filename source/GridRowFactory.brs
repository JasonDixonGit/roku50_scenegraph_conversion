Function GridRowFactory() as Object
    this = {
        
        BuildGridRow:               BuildGridRow
        GetGridRow:                 GetGridRow
        GetProductDetail:           GetProductDetail
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

'Function GetGridRow(q, fq, fl, pagesize, sortArg)
Function GetRow()
    url = CreateObject("roUrlTransfer")

    'PrintAny(0, "", rsp.Results)
'    if(rsp.Results = invalid) then
'        ?"**** TIME OUT CAUGHT *******"
'        ?"**** INFORM USER THAT THEIR NETWORK MAY BE SLOW ****"
'    end if
'    gridRow = createObject("RoSGNode","ContentNode")
'    return GridRowFactory().BuildGridRow(gridRow)
End Function

Function GetProductDetail(content, origin, itemID)
    'IF COMING FROM SEARCH SCREEN, GET CONTENT FROM GETPRODUCT()'
    productDetail = createObject("roAssociativeArray")

    productContent = GetGlobalAA().API.ProductDetailForSceneGraph(itemID)

    if(origin = "SearchScreen") then
        item = createObject("RoSGNode","ContentNode")
        item["id"] = productContent.BasicResponseGroup.id
        item["Title"] = productContent.BasicResponseGroup.title
        item["LENGTH"] = productContent.BasicResponseGroup.length
        item["HDPosterUrl"] = productContent.BasicResponseGroup.boxcover
        if(productContent.BasicResponseGroup.description = "No Description") then
            item["DESCRIPTION"] = " "
        else
            item["DESCRIPTION"] = productContent.BasicResponseGroup.description
        end if
        item["ReleaseDate"] = productContent.BasicResponseGroup.resleaseDate
        item["url"] = productContent.BasicResponseGroup.contentURL
        item["HDBackgroundImageUrl"] = productContent.BasicResponseGroup.backgroundUrl
        item["SDBackgroundImageUrl"] = productContent.BasicResponseGroup.backgroundUrl
        item["shortdescriptionline2"] = productContent.BasicResponseGroup.master_item_id_content
        'item["Actors"] = movie.BasicResponseGroup.actors
        item["STREAMFORMAT"] = "hls"

        productDetail.sceneList = productContent.BasicResponseGroup.scenes_list
        productDetail.isWatchLater = productContent.FullResponseGroup.IsWatchLater

        'jay, wtf you doing here?'
        productContent = item
        productDetail.content = item
        'temID = productContent.BasicResponseGroup.id      

        streams = []
        streams = GetGlobalAA().API.ProductStreams(itemID, false, invalid)
        'Print(streams)

        'get either hls or mp4 trailer'
        if(productContent.StarRating = 1) then
            productDetail.previewURL = streams.hlstrailer
            'Print(ds.previewURL)
            productDetail.previewFormat = "hls"
        else
            previewStreams = GetGlobalAA().API.PreviewMovieStreams(productContent.shortdescriptionline2)
            productDetail.previewURL = previewStreams[previewStreams.Count()-1].url
            productDetail.previewFormat = "mp4"
        end if

        'movie bif files'
        length = Str(productContent.length).Trim()
        'we assign master_item_id_content to productContent.shortdescriptionline2'
        strID  = ToString(productContent.shortdescriptionline2)

        productDetail.HDBifurl = "http://" + "caps1cdn.adultempire.com" + "/0/" + length + "/30/" + "HD" + "/" + strID + ".bif"
        productDetail.SDBifUrl = "http://" + "caps1cdn.adultempire.com" + "/0/" + length + "/30/" + "SD" + "/" + strID + ".bif"

        productDetail.movieURL    = streams.hlsvod
        productDetail.url         = streams.hlsvod  

    else
        productDetail.sceneList = productContent.BasicResponseGroup.scenes_list
        productDetail.isWatchLater = productContent.FullResponseGroup.IsWatchLater

        streams = []
        streams = GetGlobalAA().API.ProductStreams(itemID, false, invalid)
        'Print(streams)

        'get either hls or mp4 trailer'
        if(content.StarRating = 1) then
            productDetail.previewURL = streams.hlstrailer
            'Print(ds.previewURL)
            productDetail.previewFormat = "hls"
        else
            previewStreams = GetGlobalAA().API.PreviewMovieStreams(content.shortdescriptionline2)
            productDetail.previewURL = previewStreams[previewStreams.Count()-1].url
            productDetail.previewFormat = "mp4"
        end if

        'movie bif files'
        length = Str(content.length).Trim()
        'we assign master_item_id_content to content.shortdescriptionline2'
        strID  = ToString(content.shortdescriptionline2)

        productDetail.HDBifurl = "http://" + "caps1cdn.adultempire.com" + "/0/" + length + "/30/" + "HD" + "/" + strID + ".bif"
        productDetail.SDBifUrl = "http://" + "caps1cdn.adultempire.com" + "/0/" + length + "/30/" + "SD" + "/" + strID + ".bif"

        productDetail.movieURL    = streams.hlsvod
        productDetail.url         = streams.hlsvod
        productDetail.title       = content.title
    end if
    return productDetail
end Function

'************************************************************
'** initialize the category tree.  We fetch a category list
'** from the server, parse it into a hierarchy of nodes and
'** then use this to build the home screen and pass to child
'** screen in the heirarchy. Each node terminates at a list
'** of content for the sub-category describing individual videos
'************************************************************
Function initCategoryList() As Void

    conn = InitCategoryFeedConnection()

    m.Categories = conn.LoadCategoryFeed(conn)
    m.CategoryNames = conn.GetCategoryNames(m.Categories)

End Function

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
    Dbg("Took: ", m.Timer)

    m.Timer.Mark()
    xml=CreateObject("roXMLElement")
    if not xml.Parse(rsp) then
         print "Can't parse feed"
        return invalid
    endif
    Dbg("Parse Took: ", m.Timer)

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
    Dbg("Traversing: ", m.Timer)

    return topNode

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
        print "category: " + xml@title + " | " + xml@description
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
    for each e in xml.GetBody()
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
    next

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


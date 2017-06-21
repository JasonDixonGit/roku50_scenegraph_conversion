Function GridRowFactory() as Object
    this = {
        
        BuildGridRow:               BuildGridRow
        GetGridRow:                 GetGridRow
        GetWatchlaterGridRow:       GetWatchlaterGridRow
        GetWatchlaterSceneGridRow:  GetWatchlaterSceneGridRow
        SetGridscreenContent:       SetGridscreenContent
        SetSceneListContent:        SetSceneListContent
        GetSceneListGridRow:        GetSceneListGridRow
        GetGridRowOfPerformers:     GetGridRowOfPerformers
        GetMovieCategories:         GetMovieCategories
        GetSceneGridRow:            GetSceneGridRow
        GetSceneTagsRow:            GetSceneTagsRow
        GetGridRowBySceneTag:       GetGridRowBySceneTag
        GetProductScenes:           GetProductScenes
        GetSceneList:               GetSceneList
        GetProductDetail:           GetProductDetail
        GetSort:                    GetSort
    }
    return this
End Function

Function BuildGridRow(gridRow, results, productType)
    if(productType = "movie") then
        for each movie in results
            rowItem = gridRow.createChild("ContentNode")
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
        return gridRow

    else if(productType = "scene") then
        for each scene in results
            rowItem = gridRow.createChild("ContentNode")
            rowItem["id"] = scene.BasicResponseGroup.id
            rowItem["Title"] = scene.BasicResponseGroup.title
            rowItem["LENGTH"] = scene.BasicResponseGroup.length
            rowItem["HDPosterUrl"] = scene.BasicResponseGroup.boxcover
             if(scene.BasicResponseGroup.description = "No Description") then
                rowItem["DESCRIPTION"] = " "
            else
                rowItem["DESCRIPTION"] = scene.BasicResponseGroup.description
            end if
            'rowItem["DESCRIPTION"] = scene.BasicResponseGroup.description
            rowItem["ReleaseDate"] = scene.BasicResponseGroup.releaseDate
            rowItem["url"] = scene.BasicResponseGroup.contentURL
            rowItem["HDBackgroundImageUrl"] = scene.BasicResponseGroup.backgroundUrl
            rowItem["SDBackgroundImageUrl"] = scene.BasicResponseGroup.backgroundUrl
            rowItem["shortdescriptionline1"] = scene.BasicResponseGroup.shortdescriptionline1
            rowItem["shortdescriptionline2"] = scene.BasicResponseGroup.master_item_id_content
            rowItem["EpisodeNumber"] = scene.BasicResponseGroup.EpisodeNumber
            rowItem["STREAMFORMAT"] = "hls"
        end for
        return gridRow

    else if(productType = "performer") then
        for each performer in results
            rowItem = gridRow.createChild("ContentNode")
            rowItem["id"] = performer.contentid
            rowItem["Title"] = performer.shortdescriptionline1
            rowItem["HDPosterUrl"] = performer.HDPosterUrl
            rowItem["DESCRIPTION"] = Performer_Dynamic_Description_Info(performer._custom.baseperformer.performer)
            rowItem["HDBackgroundImageUrl"] = "pkg:/images/performerBackground.jpg"
            rowItem["SDBackgroundImageUrl"] = "pkg:/images/performerBackground.jpg"
            rowItem["shortdescriptionline2"] = performer.contentid
        end for
        return gridRow
    end if

end function

'Function GetGridRow(q, fq, fl, pagesize, sortArg)
Function GetGridRow(q, fq, fl, pagesize, sortArg)
    url = CreateObject("roUrlTransfer")

    Options = createObject("roAssociativeArray")
    Options.fl = [fl]
    Options.sort = [GridRowFactory().GetSort(sortArg)]
    'if(fq <> "") then
        Options.fq = [fq]
    'end if

    Options.q = [q]
    Options.pagesize = [pagesize]
    queryParams = createObject("roAssociativeArray")
    queryParams.Options = Options

    'maybe a -- while invalid call api -- loop for the next line? this would catch an invalid response and keep calling until valid response'
    rsp = GetGlobalAA().API.ListProductsForSceneGraph(queryParams)
    'PrintAny(0, "", rsp.Results)
    if(rsp.Results = invalid) then
        ?"**** TIME OUT CAUGHT *******"
        ?"**** INFORM USER THAT THEIR NETWORK MAY BE SLOW ****"
    end if
    gridRow = createObject("RoSGNode","ContentNode")
    return GridRowFactory().BuildGridRow(gridRow, rsp.Results, "movie")
End Function

Function GetWatchlaterGridRow()
    Options = createObject("roAssociativeArray")
    queryParams = createObject("roAssociativeArray")
    queryParams.Options = Options
    favMovies = GetGlobalAA().API.GetWatchLaterMovies()
    queryParams.Options.pageSize = [100]
    queryParams.Options.sort = ["title"]
    queryParams.Options.q = ["id: (" + arrToStr(ToArray(favMovies, "favID"), " OR ") + ")"]
    Products = GetGlobalAA().API.SceneGraphWatchLaterList(queryParams)
    watchLaterListRow = createObject("RoSGNode","ContentNode")
    return GridRowFactory().BuildGridRow(watchLaterListRow, Products.Results, "movie")
end function

Function GetWatchlaterSceneGridRow()
    Options = createObject("roAssociativeArray")
    queryParams = createObject("roAssociativeArray")
    queryParams.Options = Options
    Scenes = GetGlobalAA().API.GetWatchLaterScenes()
    queryParams.Options.pageSize = [100]
    queryParams.Options.q = ["id: (" + arrToStr(ToArray(Scenes, "favID"), " OR ") + ")"]
    Products = GetGlobalAA().API.SceneGraphSceneList(queryParams)
    sceneList = createObject("RoSGNode","ContentNode")
    return GridRowFactory().BuildGridRow(sceneList, Products.Results, "scene")
end function

Function SetGridscreenContent(list As Object)
    'gridscreen node'
    RowItems = createObject("RoSGNode","ContentNode")

    'for each row on the gridscreen:'
    for each rowAA in list
        row = createObject("RoSGNode","ContentNode")
        row = rowAA.contentlist
        row.Title = rowAA.Title
        RowItems.appendChild(row)
    end for
    return RowItems
End Function

Function SetSceneListContent(sceneList As Object)
    RowItems = createObject("RoSGNode","ContentNode")
    for each listItem in sceneList
        sceneRow = createObject("RoSGNode","ContentNode")
        sceneRow = listItem.contentlist
        sceneRow.Title = listItem.Title
        RowItems.appendChild(sceneRow)
    end for
    return RowItems
End Function

'called for movie-getscenelist'
Function GetSceneListGridRow(rsp)
    sceneList = createObject("RoSGNode","ContentNode")
    return GridRowFactory().BuildGridRow(sceneList, rsp.Results, "scene")
End Function

Function GetGridRowOfPerformers()
    url = CreateObject("roUrlTransfer")

    Options = createObject("roAssociativeArray")
    Options.pagesize = [100]
    Options.sort = ["ag_entity_score desc"]
    Options.fq = ["ag_cast_has_headshot:1 AND doc_type:Cast AND ag_cast_gender:F"]
    Options.filterjoin = ["{!join from=id to=item_id}(doc_type:Item AND tags_vod_options_simple:Subscription)"]
    Options.filterjoin2 = ["{!join from=cast to=id}(doc_type:Item)"]
    queryParams = createObject("roAssociativeArray")
    queryParams.Options = Options
    performerList = GetGlobalAA().API.PerformerList(queryParams)

    gridRow = createObject("RoSGNode","ContentNode")
    return GridRowFactory().BuildGridRow(gridRow, performerList.contentmeta, "performer")
End Function

Function GetMovieCategories()
    Options = createObject("roAssociativeArray")
    Options.q = ["media_id:14"]
    'Options.fq = [fq]
    Options.pagesize = [10]
    Options.sort = ["current_bestseller"]
    'Options["f.category.facet.limit"] = ["-1"] 'some form of fuckery from legacy app titled hackety-hack.....wtf'

    Facets = createObject("roAssociativeArray")
    Facets.category = []

    Refines = createObject("roAssociativeArray")
    Refines.tags_vod_options_extended = ["Subscription"]

    queryParams = createObject("roAssociativeArray")
    queryParams.Options = Options
    queryParams.Facets = Facets   

    rawResult = GetGlobalAA().API.ProductList(queryParams)
    m.ContentMeta = []
    m.Products = {
        totalMatches:   rawResult.Facets["category"].Count()
        firstMatch:     1
        facets:         rawResult.Facets
    }

    for each facet in rawResult.Facets
        gridRow = createObject("RoSGNode","ContentNode")
        for each item in rawResult.Facets["category"]
            if(item.occurances > 0) THEN 
                if(item.category_type = Invalid OR (item.category_type <> "5" AND item.category_type <> "6")) THEN 
                    if(item.name <> "Prebooks") then
                        rowItem = gridRow.createChild("ContentNode")
                        rowItem["id"] = item.id
                        if(item.occurances = 1) then
                            movieString = " Movie"
                        else
                           movieString = " Movies"
                        end if
                        rowItem["Title"] = item.name + " - " + iTOStr(item.occurances) + " " + movieString 
                    end if
                End If
            End If
        end for
    end for
    return gridRow
end Function

Function GetSceneGridRow(q, fq, pagesize, sortArg)
    url = CreateObject("roUrlTransfer")

    Options = createObject("roAssociativeArray")

    Options.q = [q]
    Options.fq = [fq]
    Options.pagesize = [pagesize]

    Options.sort = [GridRowFactory().GetSort(sortArg)]
    queryParams = createObject("roAssociativeArray")
    queryParams.Options = Options

    rsp = GetGlobalAA().API.SceneGraphSceneList(queryParams)
    gridRow = createObject("RoSGNode","ContentNode")
    return GridRowFactory().BuildGridRow(gridRow, rsp.Results, "scene")
End Function

Function GetSceneTagsRow()
    Options = createObject("roAssociativeArray")
    Options.q = ["*:*"]
    Options.fl = [""]
    Options.pagesize = [100]
    Options.sort = ["mostviewed"]

    Facets = createObject("roAssociativeArray")
    Facets.ag_scene_tag_list = []
    queryParams = createObject("roAssociativeArray")
    queryParams.Options = Options
    queryParams.Facets = Facets   

    rawResult = GetGlobalAA().API.SceneList(queryParams)
    'PrintAny(0, "", rawResult)
    m.ContentMeta = []
    m.Products = {
        totalMatches:   rawResult.Facets["ag_scene_tag_list"].Count()
        firstMatch:     1
        facets:         rawResult.Facets
    }
        
    gridRow = createObject("RoSGNode","ContentNode")

    for each facet in rawResult.Facets
        for each item in rawResult.Facets["ag_scene_tag_list"]
            if(item.occurances > 1) THEN 
                'boxart = GetBrowseBoxCover(strtoi(item.id), iif(validBool(item.has_logo), "", item.id))
                if(item.occurances = 1) then
                    movieString = " Scene"
                else
                    movieString = " Scenes"
                end if
                rowItem = gridRow.createChild("ContentNode")
                rowItem["id"] = item.id
                rowItem["Title"] = item.id + " - " + iTOStr(item.occurances) + movieString
            End If
        end for
    end for
    return gridRow
End Function

Function GetGridRowBySceneTag(tagArg)
    url = CreateObject("roUrlTransfer")

    Options = createObject("roAssociativeArray")
    Options.q = ["*:*"]
    Options.f = [""]
    Options.pagesize = [1000]
    Options.sort = ["added"]

    Refines = createObject("roAssociativeArray")
    Refines.tag = [tagArg]

    queryParams = createObject("roAssociativeArray")
    queryParams.Options = Options
    queryParams.Refines = Refines

    rsp = GetGlobalAA().API.SceneGraphSceneList(queryParams)
    gridRow = createObject("RoSGNode","ContentNode")
    return GridRowFactory().BuildGridRow(gridRow, rsp.Results, "scene")
end function

Function GetProductScenes(itemID)
   sceneListResults = GetGlobalAA().API.EAGetProductDetail(itemID)
   sceneIDs = []
   for each scene in sceneListResults.BasicResponseGroup.scenes_list
      sceneIDs.push(scene.sceneID)
   end for
   Scenes = []
   '**** IN CORRECT ORDER HERE **************'
   Scenes = GetSceneGraphMovieScenes(sceneIDs)
   '**** out of order here ***'
   'Print(Scenes)
   sceneRow = GridRowFactory().GetSceneListGridRow(Scenes)
   sceneList = [
   {
       Title:"Scenes"
       ContentList : sceneRow
   }]
   scenesContent = GridRowFactory().SetSceneListContent(sceneList)
   return scenesContent
End Function

Function GetSceneList(sceneList)
   sceneIDs = []
   for each scene in sceneList
      sceneIDs.push(scene.sceneID)
   end for
   Scenes = []
   '**** IN CORRECT ORDER HERE **************'
   Scenes = GetSceneGraphMovieScenes(sceneIDs)
   '**** out of order here ***'
   'Print(Scenes)
   sceneRow = GridRowFactory().GetSceneListGridRow(Scenes)
   sceneList = [
   {
       Title:"Scenes"
       ContentList : sceneRow
   }]
   scenesContent = GridRowFactory().SetSceneListContent(sceneList)
   return scenesContent
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



Function GetSort(sortArg)
    if(sortArg = "added") then
        sortStr = "added"
    else if(sortArg = "trending") then
        sortStr = "ag_entity_score"
    else if(sortArg = "bestselling") then
        sortStr = "current_bestseller"
    else if(sortArg = "released") then
        sortStr = "released"
    else
        'default'
        sortStr = "released"
    end if
   return sortStr
end function
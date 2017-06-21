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

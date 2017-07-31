Function Init()

    ' CategoriesScreen node with RowList
    m.CategoriesScreen               = m.top.findNode("CategoriesScreen")

    ' YearSubCategories Node with description, Video Player
    m.YearSubCategories            = m.top.findNode("YearSubCategories")

End Function

' if content set, focus on CategoriesScreen
Function OnChangeContent()
    m.CategoriesScreen.setFocus(true)
    m.CategoriesScreen.isLoaded = true
End Function

' Row item selected handler
Function OnRowItemSelected()
    'm.CategoriesScreen.visible = false


    for each link in m.CategoriesScreen.focusedContent.Directors
        Print link
    next

   '' m.YearSubCategories.content = m.CategoriesScreen.focusedContent
   '' m.YearSubCategories.itemID  = m.CategoriesScreen.focusedContent.id
   '' m.YearSubCategories.origin  = "CategoriesScreen"
   '' m.YearSubCategories.ready = false
   '' m.CategoriesScreen.visible = false
   '' m.YearSubCategories.visible = true
   '' m.YearSubCategories.setFocus(true)
End Function

' Main Remote keypress event loop
Function OnKeyEvent(key, press) as Boolean
    result = false
    if press then
        'print(key)

        if key = "back"
            
            'catch back press while loading main CategoriesScreen'
            if(m.CategoriesScreen.visible = true and m.CategoriesScreen.isLoaded = false) then
                ?"1 - caught"
                result = true

            else if(m.YearSubCategories.visible = true)

                m.YearSubCategories.visible = false
                m.CategoriesScreen.setFocus(true)
                m.CategoriesScreen.visible = true
                result = true                    

            else
                ?"ERROR -- CATCH BACK-BUTTON CASE HIT"
                result = false
            end if
        end if
    end if
    return result
End Function

'function SetAppColors()

'end function

'function SetAppFont()

'end Function

Function Init()

    ' CategoriesScreen node with RowList
    m.CategoriesScreen               = m.top.findNode("CategoriesScreen")
End Function

' if content set, focus on CategoriesScreen
Function OnChangeContent()
    m.CategoriesScreen.setFocus(true)
    m.CategoriesScreen.isLoaded = true
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

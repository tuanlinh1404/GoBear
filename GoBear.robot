***Settings***
Resource          ./TestKeywords.robot
Suite Teardown    Suite Teardown

***Variables***
${timeout} =    10s

***Test Cases***
TC001 - Test Excel Data
    Open Excel From Path    GoBear.xlsx    TestData1
    Get Data From Excel

TC002 - Test Browser
    [Documentation]    Opening Browser and Navigating to Site
    BrowserTest        ${site}                                   ${browser}    ${title}

TC003 - Choose Insurance Tab
    Click Item    //a[@href='#Insurance']    ${timeout}
    Click Item    //a[@href='#Travel']       ${timeout}

TC004 - Choose Trip Type and Travel Plan
    #Trip type
    Click Item                        //div[contains(text(),'looking for')]//button                ${timeout}
    ${trip-type} =                    Set Variable                                                 single trip
    Choose Item From Dropdown List    //span[contains(text(), '${trip-type}')]//following::link    ${timeout}

    #Traveller
    Click Item                        //div[@data-gb-name='traveller']//button                       ${timeout}
    ${travel-plan} =                  Set Variable                                                   just me
    Choose Item From Dropdown List    //span[contains(text(), '${travel-plan}')]//following::link    ${timeout}

    #Destination
    Click Item                        //div[contains(text(),'going to')]//button                 ${timeout}
    ${country} =                      Set Variable                                               Philippines
    Choose Item From Dropdown List    //span[contains(text(), '${country}')]//following::link    ${timeout}

    #Date
    ${date-from} =    Set Variable                                                                                                                                 23
    ${date-to} =      Set Variable                                                                                                                                 30
    Click Item        //div[@class='date-from']                                                                                                                    10s
    Click Item        
    ...               //tbody//td[(text()='29' and @class!='old disabled day') and (text()='29' and @class!='new day') and (text()='29' and @class!='old day')]    
    ...               10s
    Click Item        //div[@class='date-to']                                                                                                                      10s
    Click Item        
    ...               //tbody//td[(text()='29' and @class!='old disabled day') and (text()='29' and @class!='new day') and (text()='29' and @class!='old day')]    
    ...               10s

TC005 - Search Insurance
    Click Item    //button[contains(text(),'Show my results')]    ${timeout}
    Sleep         5s

TC006 - Filter Insurers
    #Filter - Insurers
    ${insurers} =                  Set Variable                                                                   FPG Insurance
    Click Item                     //label[contains(text(),'${insurers}')]                                        ${timeout}
    Checkbox Should Be Selected    //label[contains(text(),'${insurers}')]//preceding::input[@type='checkbox']

    #Expand SEE MORE
    Click Item    //a[contains(text(),'SEE MORE')]//link    ${timeout}

    # ${slider-name} =  Set Variable  Personal Accident
    # //label[contains(text(),'${slider-name}')]//following-sibling::div//b[@data-min-value]



TC007 - Sort Insurers
    ${sort-by} =    Set Variable                                                Price: Low to high
    Click Item      //input//following::label[contains(text(),'${sort-by}')]    ${timeout}

TC008 - Detailed Insurers
    #Details - Destination
    Click Item                        //div[label[contains(text(),'DESTINATION')]]//following::button    ${timeout}
    ${country} =                      Set Variable                                                       Thailand
    Choose Item From Dropdown List    //span[contains(text(), '${country}')]//following::link            ${timeout}
    
    #Details - Calendar
    ${date-from} =    Set Variable                                                                                                                                 18
    ${date-to} =      Set Variable                                                                                                                                 27
    Click Item        //div[@class='date-from']                                                                                                                    10s
    Click Item        
    ...               //tbody//td[(text()='29' and @class!='old disabled day') and (text()='29' and @class!='new day') and (text()='29' and @class!='old day')]    
    ...               10s
    Click Item        //div[@class='date-to']                                                                                                                      10s
    Click Item
    ...               //tbody//td[(text()='29' and @class!='old disabled day') and (text()='29' and @class!='new day') and (text()='29' and @class!='old day')]
    ...               10s

    

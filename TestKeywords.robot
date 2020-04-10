***Settings***
Library    SeleniumLibrary
Library    String
Library    DateTime
Library    ExcelLibrary.py
Library    Collections
Library    String

***Keywords***
BrowserTest
    [Arguments]                ${site}     ${browser}    ${title}
    Open Browser               ${site}     ${browser}
    Maximize Browser Window
    Title Should Be            ${title}

Suite Teardown
    [Documentation]       Deleting Cookies and Closing Browser
    Delete All Cookies
    Close Browser

Wait Element
    [Arguments]                         ${locator}    ${timeout}
    Wait Until Page Contains Element    ${locator}    ${timeout}                               Element not found | Page not loaded | ${timeout}
    #Element Should Be Visible           ${locator}    Element not visible | Page not loaded

Verify FirstName
    [Arguments]               ${text}                                ${timeout}
    Wait Element              //span[contains(text(), '${text}')]    ${timeout}
    Element Text Should Be    //span[contains(text(), '${text}')]    ${text}

Click Lead by Fullname
    [Arguments]      ${firstname}                                    ${lastname}    ${timeout}
    Wait Element     //tr[td='${firstname}' and td='${lastname}']    ${timeout}
    Click Element    //tr[td='${firstname}' and td='${lastname}']

Click Menu Item
    [Arguments]      ${item}                             ${timeout}
    Wait Element     //a[contains(text(), '${item}')]    ${timeout}
    Click Element    //a[contains(text(), '${item}')]
    Sleep            4s

Click Item
    [Arguments]      ${path}    ${timeout}
    Wait Element     ${path}    ${timeout}
    Click Element    ${path}

Click Button By Text
    [Arguments]      ${text}                                 ${timeout}
    Wait Element     //button[contains(text(),'${text}')]    ${timeout}
    Click Element    //button[contains(text(),'${text}')]

Check Search Data
    [Arguments]           ${searchValue}                 ${timeout}
    Clear Element Text    //input[@name='searchText']
    Input Text            //input[@name='searchText']    ${searchValue}
    Verify FirstName      ${searchValue}                 ${timeout}

Tick Checkbox
    [Documentation]                Ticking Checkbox
    [Arguments]                    ${path}             ${timeout}
    Wait Element                   ${path}             ${timeout}
    Select Checkbox                ${path}             
    Checkbox Should Be Selected    ${path}             

Untick Checkbox
    [Documentation]                    Unticking Checkbox with arguments FROM ... TO ...
    [Arguments]                        ${from}                                                       ${to}         ${timeout}
    Wait Element                       //tr[td='${from}' and td='${to}']//input[@type='checkbox']    ${timeout}
    Unselect Checkbox                  //tr[td='${from}' and td='${to}']//input[@type='checkbox']
    Checkbox Should Not Be Selected    //tr[td='${from}' and td='${to}']//input[@type='checkbox']

Choose Item From Dropdown List
    [Documentation]                     Choosing Item from Dropdown List
    [Arguments]                         ${path}                             ${timeout}
    Wait Until Page Contains Element    ${path}                             ${timeout}    Element not found | Page not loaded | ${timeout}    
    Click Element                       ${path}

Choose Date From Calendar
    [Documentation]                   Choosing YYYY/mm/dd from Calendar
    [Arguments]                       ${yyyy}                              ${mm}      ${dd}           ${right}    ${titlePath}
    #Wait Element                      ${left}                              10s
    Wait Element                      ${right}                             10s
    Switch Case For Month And Year    ${mm}                                ${yyyy}    ${titlePath}    ${left}     ${right}        
    Switch Case For Day               ${dd}
    Sleep                             2s

Switch Case For Day
    [Arguments]    ${dd}

    ${stringDay} =    Convert Day                 ${dd}
    Run Keyword If    '${stringDay}' != 'None'    Click Date    ${stringDay}
    ...               ELSE                        Click Date    ${dd}

Click Date
    [Arguments]      ${date}
    Click Element    //div[@class='date-wrap']/div[contains(text(),'${date}')]

Switch Case For Month And Year
    [Arguments]    ${mm}    ${yyyy}    ${titlePath}    ${left}    ${right}

    ${stringMonth} =       Convert Month to UPPERCASE    ${mm}
    ${currentMonthYear}    Get Text                      ${titlePath}
    @{arrayMonthYear}      Split String From Right       ${currentMonthYear}

    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If       '${yyyy}' <= '@{arrayMonthYear}[1]' and '${stringMonth}' == '@{arrayMonthYear}[0]'
    \    Click Element          ${right}
    \    ${currentMonthYear}    Get Text                                                                              ${titlePath}
    \    @{arrayMonthYear}      Split String From Right                                                               ${currentMonthYear}

    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If       '${yyyy}' >= '@{arrayMonthYear}[1]' and '${stringMonth}' == '@{arrayMonthYear}[0]'
    \    Click Element          ${left}
    \    ${currentMonthYear}    Get Text                                                                              ${titlePath}
    \    @{arrayMonthYear}      Split String From Right                                                               ${currentMonthYear}

Login
    [Arguments]             ${username}                  ${password}    ${timeout}
    Wait Element            //input[@name='email']       ${timeout}
    Wait Element            //input[@name='password']    ${timeout}
    Clear Element Text      //input[@name='email']
    Input Text              //input[@name='email']       ${username}
    Clear Element Text      //input[@name='password']
    Input Password          //input[@name='password']    ${password}
    Click Button By Text    Log in                       ${timeout}

Logout
    [Arguments]      ${timeout}
    Wait Element     //span[contains(@class,'fa-caret-down')]    ${timeout}
    Click Element    //span[contains(@class,'fa-caret-down')]
    Wait Element     //a[contains(text(),'Logout')]              ${timeout}
    Click Element    //a[contains(text(),'Logout')]

Convert Month to UPPERCASE
    [Arguments]       ${mm}
    [Return]          ${stringMonth}
    ${stringMonth}    Set Variable If
    ...               '${mm}' == '01'    JANUARY
    ...               '${mm}' == '02'    FEBRUARY
    ...               '${mm}' == '03'    MARCH
    ...               '${mm}' == '04'    APRIL
    ...               '${mm}' == '05'    MAY
    ...               '${mm}' == '06'    JUNE
    ...               '${mm}' == '07'    JULY
    ...               '${mm}' == '08'    AUGUST
    ...               '${mm}' == '09'    SEPTEMBER
    ...               '${mm}' == '10'    OCTOBER
    ...               '${mm}' == '11'    NOVEMBER
    ...               '${mm}' == '12'    DECEMBER

Convert Month to Lowercase
    [Arguments]       ${mm}
    [Return]          ${stringMonth}
    ${stringMonth}    Set Variable If
    ...               '${mm}' == '01'    January
    ...               '${mm}' == '02'    February
    ...               '${mm}' == '03'    March
    ...               '${mm}' == '04'    April
    ...               '${mm}' == '05'    May
    ...               '${mm}' == '06'    June
    ...               '${mm}' == '07'    July
    ...               '${mm}' == '08'    August
    ...               '${mm}' == '09'    September
    ...               '${mm}' == '10'    October
    ...               '${mm}' == '11'    November
    ...               '${mm}' == '12'    December

Convert Day
    [Arguments]     ${dd}
    [Return]        ${stringDay}
    ${stringDay}    Set Variable If
    ...             '${dd}' == '01'    1
    ...             '${dd}' == '02'    2
    ...             '${dd}' == '03'    3
    ...             '${dd}' == '04'    4
    ...             '${dd}' == '05'    5
    ...             '${dd}' == '06'    6
    ...             '${dd}' == '07'    7
    ...             '${dd}' == '08'    8
    ...             '${dd}' == '09'    9
    ...             '${dd}' >= '10'    ${dd}

Add Ordinate To Day
    [Arguments]    ${dd}
    [Return]       ${ordinate}
    ${ordinate}    Set Variable                                            None
    ${ordinate}    Set Variable If
    ...            '${dd}' == '1' or '${dd}' == '21' or '${dd}' == '31'    st
    ...            '${dd}' == '2' or '${dd}' == '22'                       nd
    ...            '${dd}' == '3' or '${dd}' == '23'                       rd
    ...            '${ordinate}' == 'None'                                 th

Check Dashboard Date
    [Arguments]         ${path}
    ${weekday} =        Get Current Date              result_format=%A
    ${month} =          Get Current Date              result_format=%m
    ${stringMonth} =    Convert Month to Lowercase    ${month}
    ${day} =            Get Current Date              result_format=%d
    ${stringDay} =      Convert Day                   ${day}
    ${ordinate} =       Add Ordinate To Day           ${day}
    ${year} =           Get Current Date              result_format=%Y

    ${stringDate}=            Set Variable    ${weekday}, ${stringMonth} ${stringDay}${ordinate}, ${year}
    Wait Element              ${path}         10s
    Element Text Should Be    ${path}         ${stringDate}

Input Text By Input[Id]
    [Arguments]     ${inputId}                   ${text}       ${timeout}
    Wait Element    //input[@id='${inputId}']    ${timeout}
    Input Text      //input[@id='${inputId}']    ${text}

Verify Text By Input[Id]
    [Arguments]               ${inputId}                   ${text}       ${timeout}
    Wait Element              //input[@id='${inputId}']    ${timeout}
    Element Text Should Be    //input[@id='${inputId}']    ${text}

Select Option By Select[Name]
    [Arguments]      ${selectName}                                                            ${option}     ${timeout}
    Wait Element     //select[@name='${selectName}']//option[contains(text(),'${option}')]    ${timeout}
    Click Element    //select[@name='${selectName}']//option[contains(text(),'${option}')]

Select Radiobutton By Label
    [Arguments]      ${label}                                                                   ${radioButtonOption}    ${timeout}
    Wait Element     //div[label='${label}']//label[contains(text(),'${radioButtonOption}')]    ${timeout}
    Click Element    //div[label='${label}']//label[contains(text(),'${radioButtonOption}')]

Create New Lead
    [Arguments]    ${timeout}              ${firstname}      ${lastname}            ${email}         
    ...            ${streetAddress}        ${city}           ${state}               ${zip}           
    ...            ${country}              ${mobilePhone}    ${homePhone}           ${workPhone}     
    ...            ${contactPreference}    ${objection}      ${collectionSource}    ${emailOptIn}    ${textOptIn}

    Wait Element                     //button[contains(text(),'Create new')]    ${timeout}
    Click Element                    //button[contains(text(),'Create new')]
    Sleep                            3s
    Input Text By Input[Id]          firstName                                  ${firstname}            ${timeout}
    Input Text By Input[Id]          lastName                                   ${lastname}             ${timeout}
    Input Text By Input[Id]          email                                      ${email}                ${timeout}
    Input Text By Input[Id]          streetAddress                              ${streetAddress}        ${timeout}
    Input Text By Input[Id]          city                                       ${city}                 ${timeout}
    Input Text By Input[Id]          zip                                        ${zip}                  ${timeout}
    Select Option By Select[Name]    country                                    ${country}              ${timeout}
    Sleep                            3s
    Select Option By Select[Name]    state                                      ${state}                ${timeout}
    Input Text By Input[Id]          mobilePhone                                ${mobilePhone}          ${timeout}
    Input Text By Input[Id]          homePhone                                  ${homePhone}            ${timeout}
    Input Text By Input[Id]          workPhone                                  ${workPhone}            ${timeout}
    Select Option By Select[Name]    contactPreference                          ${contactPreference}    ${timeout}
    Select Option By Select[Name]    objection                                  ${objection}            ${timeout}
    Select Option By Select[Name]    collectionSource                           ${collectionSource}     ${timeout}
    Select Radiobutton By Label      Email Opt-In                               ${emailOptIn}           ${timeout}
    Select Radiobutton By Label      Text Opt-In                                ${textOptIn}            ${timeout}
    Click Button By Text             SAVE                                       ${timeout}

Verify Text By Label[Class]
    [Arguments]               ${class}                      ${text}       ${timeout}
    Wait Element              //label[@class='${class}']    ${timeout}
    Element Text Should Be    //label[@class='${class}']    ${text} 

Verify Element Attribute By Input[Id]
    [Arguments]                          ${inputId}                   ${attribute}    ${text}    ${timeout}
    Wait Element                         //input[@id='${inputId}']    ${timeout}
    Element Attribute Value Should Be    //input[@id='${inputId}']    ${attribute}    ${text}

Verify Phone
    [Arguments]        ${inputId}               ${attribute}                 ${text}    ${timeout}
    ${phone} =         Get Element Attribute    //input[@id='${inputId}']    value
    ${number} =        Remove String            ${phone}                     -
    Should Be Equal    ${number}                ${text}

Check New Created Lead
    [Arguments]    ${timeout}              ${firstname}      ${lastname}            ${email}         
    ...            ${streetAddress}        ${city}           ${state}               ${zip}           
    ...            ${country}              ${mobilePhone}    ${homePhone}           ${workPhone}     
    ...            ${contactPreference}    ${objection}      ${collectionSource}    ${emailOptIn}    ${textOptIn}

    Verify Text By Label[Class]              title               ${firstname} ${lastname}    ${timeout}
    ${date} =                                Get Current Date    result_format=%m/%d/%Y
    #Verify Text By Label[Class]    follow-up           ${date}                     ${timeout}
    #Commended for project business
    Verify Element Attribute By Input[Id]    firstName           value                       ${firstname}        ${timeout}
    Verify Element Attribute By Input[Id]    lastName            value                       ${lastname}         ${timeout}
    Verify Element Attribute By Input[Id]    email               value                       ${email}            ${timeout}
    Verify Element Attribute By Input[Id]    streetAddress       value                       ${streetAddress}    ${timeout}
    Verify Element Attribute By Input[Id]    city                value                       ${city}             ${timeout}
    Verify Element Attribute By Input[Id]    zip                 value                       ${zip}              ${timeout}

    Verify Phone    mobilePhone    value    ${mobilePhone}    ${timeout}
    Verify Phone    homePhone      value    ${homePhone}      ${timeout}
    Verify Phone    workPhone      value    ${workPhone}      ${timeout}

    Log To Console    \nUnverified: Country
    Log To Console    \nUnverified: State
    Log To Console    \nUnverified: Contact Preference
    Log To Console    \nUnverified: Objection
    Log To Console    \nUnverified: Collection Source
    Log To Console    \nUnverified: Email & Text Opt-In

Open Excel From Path
    [Arguments]            ${path}           ${docId}
    Open Excel Document    ${path}           ${docId}
    log to console         \nExcel Opened

Get Data From Excel
    #Set Variable URL
    ${temp}=              Read Excel Cell    2          1    Login
    Set Suite Variable    ${site}            ${temp}

    #Set Variable Browser type
    ${temp}=              Read Excel Cell    2          2    Login
    Set Suite Variable    ${browser}         ${temp}

    #Set Variable Title
    ${temp}=              Read Excel Cell    2          3    Login
    Set Suite Variable    ${title}           ${temp}

Hover and Click Element
    [Arguments]      ${hoverPath}    ${clickPath}    ${timeout}
    Wait Element     ${hoverPath}    ${timeout}
    Mouse Over       ${hoverPath}
    Sleep            1s
    Wait Element     ${clickPath}    ${timeout}
    Click Element    ${clickPath}

Change TimeFormat
    [Arguments]          ${bookTime}
    [Return]             ${formatBookTime}
    ${formatBookTime}    Set Variable If
    ...                  '${bookTime}' == '13'    1:00 PM
    ...                  '${bookTime}' == '14'    2:00 PM
    ...                  '${bookTime}' == '15'    3:00 PM
    ...                  '${bookTime}' == '16'    4:00 PM
    ...                  '${bookTime}' == '17'    5:00 PM
    ...                  '${bookTime}' == '18'    6:00 PM
    ...                  '${bookTime}' == '19'    7:00 PM
    ...                  '${bookTime}' == '20'    8:00 PM
    ...                  '${bookTime}' == '21'    9:00 PM
    ...                  '${bookTime}' == '22'    10:00 PM
    ...                  '${bookTime}' == '23'    11:00 PM
    ...                  '${bookTime}' == '24'    12:00 PM
    ...                  '${bookTime}' <= '12'    ${bookTime}:00 AM

Book Intro
    [Arguments]               ${timeout}          ${leadFirstName}    ${leadLastName}    ${yyyy}    ${mm}    ${dd}    ${titlePath}    ${left}    ${right}    ${bookTime}
    Click Lead by Fullname    ${leadFirstName}    ${leadLastName}     ${timeout}
    Sleep                     5s

    Click Element    //a[contains(text(),'Book Intro')]

    #help
    Switch Case For Month And Year    ${mm}                    ${yyyy}    ${titlePath}    ${left}    ${right}    
    log to console                    \npass month and year
    Switch Case For Day               ${dd}
    log to console                    \npass day
    #i'm so tired

    Sleep                      5s
    ${formatBookTime}=         Change TimeFormat    ${bookTime}
    Hover and Click Element    ${formatBookTime}    ${formatBookTime}    ${timeout}
    #//div[contains(p,'2:00 PM')]

Move Slider
    [Arguments]  ${minValuePath}  ${maxValuePath}

    ${stringMonth} =       Convert Month to UPPERCASE    ${mm}
    ${currentMonthYear}    Get Text                      ${titlePath}
    @{arrayMonthYear}      Split String From Right       ${currentMonthYear}

    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If       
    \    Click Element          ${right}
    \    ${currentMonthYear}    Get Text                                                                              ${titlePath}
    \    @{arrayMonthYear}      Split String From Right                                                               ${currentMonthYear}

    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If       
    \    Click Element          ${left}
    \    ${currentMonthYear}    Get Text                                                                              ${titlePath}
    \    @{arrayMonthYear}      Split String From Right                                                               ${currentMonthYear}


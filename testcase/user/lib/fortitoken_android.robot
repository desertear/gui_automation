*** Settings ***
Documentation     This file contains keywords for FortiToken on Android only

*** Variables ***
${locator_digit_9}    id=digit_9
${locator_digit_1}    id=digit_1
${locator_plus}    accessibility_id=plus
${locator_equal}    xpath=//android.widget.Button[@content-desc="equals"]
${locator_result}   id=com.android.calculator2:id/result
${locator_enter_manully}   id=btn_enter_manually
${username}    user
${password}    123456

*** Keywords ***
Add key to FotiTokenMobile
    [Arguments]    ${name}    ${key}    ${appPackage}=com.fortinet.android.ftm    ${appActivity}=com.fortinet.android.ftm.StartActivity    ${noReset}=${False}
    open application    ${APPIUM_REMOTE_URL}    platformName=${ANDROID_PLATFORM_NAME}    platformVersion=${ANDROID_PLATFORM_VERSION}    deviceName=${ANDROID_DEVICE_NAME}    automationName=${APPIUM_AUTOMATION_NAME}
    ...     appPackage=${appPackage}    appActivity=${appActivity}    noReset=${noReset}
    AppiumLibrary.Wait Until Page Contains Element    ${FTM_ENTER_MANUALLY}
    AppiumLibrary.Click Element    ${FTM_ENTER_MANUALLY}
    AppiumLibrary.Wait Until Page Contains    Manual account
    AppiumLibrary.Click Element    ${FTM_ACCOUNT_TYPE_TEXT}
    AppiumLibrary.Wait Until Page Contains    Add account
    AppiumLibrary.Input Text        ${FTM_ACCOUNT_NAME}    ${name}
    AppiumLibrary.Input Text        ${FTM_ACCOUNT_KEY}    ${key}
    AppiumLibrary.Click Element    ${FTM_ACCOUNT_ADD_BUTTON}    
    AppiumLibrary.Wait Until Page Contains    FortiToken
    [Teardown]    Close Application

Get token from FotiTokenMobile
    [Arguments]    ${appPackage}=com.fortinet.android.ftm    ${appActivity}=com.fortinet.android.ftm.StartActivity    ${noReset}=${True}
    [Tags]    token
    open application    ${APPIUM_REMOTE_URL}    platformName=${ANDROID_PLATFORM_NAME}    platformVersion=${ANDROID_PLATFORM_VERSION}    deviceName=${ANDROID_DEVICE_NAME}    automationName=${APPIUM_AUTOMATION_NAME}
    ...     appPackage=${appPackage}    appActivity=${appActivity}    noReset=${noReset}
    AppiumLibrary.Get Source
    ${token_number}=    display and return token number
    [Teardown]    Close Application
    [Return]    ${token_number}

display and return token number
    AppiumLibrary.Wait Until Page Contains Element    ${FTM_TOKEN_TEXT}
    ${token_number}=    AppiumLibrary.Get Text    ${FTM_TOKEN_TEXT}
    ${if_displayed}=    Run keyword and return status    Should match Regexp    ${token_number}    \\d{6}
    Run keyword if    "${if_displayed}"!="True"    AppiumLibrary.Click Element    ${FTM_TOKEN_HIDE_BUTTON}
    ${token_number}=    AppiumLibrary.Get Text    ${FTM_TOKEN_TEXT}
    Should match Regexp    ${token_number}    \\d{6}
    [return]    ${token_number}


open browser on andriod
    [Tags]    browser
    # open application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=7.0    deviceName=Android Emulator    app=${CURDIR}${/}OrangeDemoApp.apk    appPackage=com.netease.qa.orangedemo     appActivity=MainActivity
    open browser    https://www.google.ca    browser=chrome    remote_url=http://172.16.106.53:4723/wd/hub
    ...    desired_capabilities=deviceName:emulator-5554,udid:emulator-5554,platformName:Android,platformVersion:9,browserName:Chrome,noReset:True
    # input text    xpath://input[@id="username"]    ${username}
    # input password    xpath://input[@id="credential"]    ${password}
    #sleep    5
    #Capture Page Screenshot
    # click button    name:login_button
    sleep    10
    [Teardown]    close browser

login SSLVPN using forticlient on Android
    [Tags]    forticlient
    # open application    http://localhost:4723/wd/hub    platformName=Android    platformVersion=7.0    deviceName=Android Emulator    app=${CURDIR}${/}OrangeDemoApp.apk    appPackage=com.netease.qa.orangedemo     appActivity=MainActivity
    open application    http://172.16.106.47:4723/wd/hub    platformName=Android
    ...    platformVersion=8.1    deviceName=Android Emulator    automationName=appium
    ...    appPackage=com.fortinet.forticlient_vpn    appActivity=com.fortinet.forticlient_vpn.start.StartActivity    noReset=${True}
    AppiumLibrary.Wait Until Page Contains Element    id=tunnel_reconnect_connect_button    timeout=60
    AppiumLibrary.click Element    id=tunnel_reconnect_connect_button
    AppiumLibrary.Wait Until Page Contains Element    id=password_value
    AppiumLibrary.input text    id=password_value    123456
    AppiumLibrary.click Element    id=buttonDefaultPositive
    AppiumLibrary.Wait Until Page Contains Element    id=tunnel_conntected_status_vpn_label    timeout=60
    ${tunnle_name}=    AppiumLibrary.get text    id=tunnel_conntected_status_vpn_label
    should be equal    ${tunnle_name}    sslvpn_automation
    Background App    60
    AppiumLibrary.click Element    id=tunnel_connected_disconnect_button
    AppiumLibrary.Wait Until Page does not Contain Element    id=tunnel_conntected_status_vpn_label    timeout=60
    [Teardown]    Close Application

case
    [Tags]    case
    open application    http://172.16.106.47:4723/wd/hub    alias=forticlient    platformName=Android
    ...    platformVersion=8.1    deviceName=Android Emulator    automationName=appium
    ...    appPackage=com.fortinet.forticlient_vpn    appActivity=com.fortinet.forticlient_vpn.start.StartActivity    noReset=${True}    dontStopAppOnReset=${True}
    AppiumLibrary.Wait Until Page Contains Element    id=tunnel_reconnect_connect_button    timeout=60
    AppiumLibrary.click Element    id=tunnel_reconnect_connect_button
    AppiumLibrary.Wait Until Page Contains Element    id=password_value
    AppiumLibrary.input text    id=password_value    123456
    AppiumLibrary.click Element    id=buttonDefaultPositive
    AppiumLibrary.Wait Until Page Contains Element    id=tunnel_conntected_status_vpn_label    timeout=60
    ${tunnle_name}=    AppiumLibrary.get text    id=tunnel_conntected_status_vpn_label
    should be equal    ${tunnle_name}    sslvpn_automation
    ${contexts}=    Get Contexts
    ${older_context}=    Get Current Context
    # Background App    20
    # AppiumLibrary.Go To Url    http://172.16.200.55

    # open application    http://172.16.106.47:4723/wd/hub    alias=fortitoken    platformName=Android    platformVersion=8.1    deviceName=Android Emulator    automationName=appium    appPackage=com.fortinet.android.ftm    appActivity=com.fortinet.android.ftm.StartActivity    noReset=${True}
    start activity    com.fortinet.android.ftm    com.fortinet.android.ftm.StartActivity
    ${result}=    display and return token number
    ${contexts}=    Get Contexts
    ${newer_context}=    Get Current Context

    Switch To Context    ${older_context}
    # open browser    http://172.16.200.55    alias=chrome    browser=chrome    remote_url=http://172.16.106.47:4723/wd/hub
    # ...    desired_capabilities=deviceName:Android Emulator,udid:emulator-5554,platformName:Android,platformVersion:8.1,browserName:Chrome,noReset:True
    # Page Should Contain    pc5
    sleep    10

    close application
    # close browser
case1
    [Tags]    demo
    open application    http://172.16.106.53:4723/wd/hub    alias=calculator    platformName=Android
    ...    platformVersion=8.1    deviceName=emulator-5556    automationName=UiAutomator2
    ...    appPackage=com.android.calculator2    appActivity=.Calculator    noReset=${True}

    # open application    http://172.16.106.47:4723/wd/hub    alias=clock    platformName=Android
    # ...    platformVersion=8.1    deviceName=Android Emulator    automationName=appium
    # ...    appPackage=com.google.android.deskclock    appActivity=com.android.deskclock.DeskClock    noReset=${True}

    start activity    com.google.android.deskclock    com.android.deskclock.DeskClock
    sleep    3
    Switch Application    calculator
    sleep    3
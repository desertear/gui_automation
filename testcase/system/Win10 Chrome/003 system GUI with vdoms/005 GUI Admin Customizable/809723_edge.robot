*** Settings ***
Documentation    Verify GUI can enter/exit full screen mode with IE
Resource    ../../../system_resource.robot

*** Variables ***
${system_GUI_mainpage_fullscreen_button}     xpath://header/div[4]/button[2]
${system_GUI_mainpage_fullscreen_exit_button_wrapper}    id:screen-mode-wrapper
${system_GUI_mainpage_fullscreen_exit_button}    xpath://div/div/div/button[span[text()="Exit Full Screen Mode"]]

*** Test Cases ***
807923
##  GUI can enter/exit full screen mode by click the button on the main page##
    [Tags]    v6.0    chrome   807923B    Medium    win10,64bit    browsers    system   norun
    Login FortiGate    browser=edge
    sleep  2s
    Wait and click    ${system_GUI_mainpage_fullscreen_button}
    ${full_screen}=   Run keyword and return status     Wait Until Element Is Visible   ${system_GUI_mainpage_fullscreen_button}
    Should be equal   "${full_screen}"   "False"
    sleep   2s
    Mouse over        ${system_GUI_mainpage_fullscreen_exit_button_wrapper}
    sleep   1s
    wait and click    ${system_GUI_mainpage_fullscreen_exit_button}
    sleep   2s
    ${full_screen}=   Run keyword and return status     Wait Until Element Is Visible   ${system_GUI_mainpage_fullscreen_button}
    Should be equal   "${full_screen}"   "True"
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

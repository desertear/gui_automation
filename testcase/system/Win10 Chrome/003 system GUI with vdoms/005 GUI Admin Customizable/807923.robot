*** Settings ***
Documentation    Verify GUI can enter/exit full screen mode with Chrome
Resource    ../../../system_resource.robot

*** Variables ***


*** Test Cases ***
807923
##  GUI can enter/exit full screen mode by click the button on the main page##
    [Tags]    v6.0    chrome   807923    Medium    win10,64bit    browsers    runable  
    Login FortiGate    
    sleep  2s
    ### click full screen button and the button will be hide ###
    Wait and click     ${system_GUI_mainpage_fullscreen_button}
    ${full_screen}=    Run keyword and return status     Wait Until Element Is Visible   ${system_GUI_mainpage_fullscreen_button}
    Should be equal    "${full_screen}"   "False"
    sleep   2s
    ### exit full screen button and the button will be shown ###
    wait and click    ${system_GUI_mainpage_fullscreen_exit_button_wrapper}
    sleep   1s
    wait and click    ${system_GUI_mainpage_fullscreen_exit_button}
    sleep   2s
    ${full_screen}=    Run keyword and return status     Wait Until Element Is Visible   ${system_GUI_mainpage_fullscreen_button}
    Should be equal    "${full_screen}"   "True"
    
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

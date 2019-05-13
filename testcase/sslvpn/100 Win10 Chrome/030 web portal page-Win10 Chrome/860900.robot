*** Settings ***
Documentation    Verify "Launch" button show inside the sslvpn login page and the button works for windows forticlient 6.0
Library    SikuliLibrary    mode=NEW
Resource    ../../sslvpn_resource.robot
Suite Setup    begin 860900 test
Suite Teardown    clear up

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
##this case can only be run on chrome
${browser}    Chrome
${url}    ${SSLVPN_URL}
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
${image_dir}    ${SIKULI_IMAGE_DIR}${/}forticlient
*** Test Cases ***
860900
    [Tags]    screen_alive    no_grid    forticlient    v6.0    chrome    860900    high    win10,64bit
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys,selenium.webdriver
    ${excluded_schemes}=    create dictionary    forticlient=${false}
    ${prefs}=    create dictionary    protocol_handler.excluded_schemes=${excluded_schemes}
    Call method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    ${desired_capabilities}=    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys,selenium.webdriver
    create webdriver    ${browser}    chrome_options=${chrome_options}    desired_capabilities=${desired_capabilities}
    go to    ${url}
    Maximize Browser Window
    input text    ${LOGIN_SSLVPN_USERNAME_TEXT}    ${username}
    input password    ${LOGIN_SSLVPN_PASSWORD_TEXT}    ${password}
    click button    ${LOGIN_SSLVPN_LOGIN_BUTTON}
    wait Until page contains element    ${PORTAL_LAUNCH_FORTICLIENT_BUTTON}
    click element    ${PORTAL_LAUNCH_FORTICLIENT_BUTTON}
    Wait Until Screen Contain    header_forticlient.png    20
    click    header_forticlient.png
    Click in    full_header_forticlient.png    close_forticlient.png
    Wait Until Screen Not Contain    header_forticlient.png    5
    [Teardown]    case Teardown
*** Keywords ***
begin 860900 test
    Start Sikuli Process
    Set Library Search Order    SeleniumLibrary    SikuliLibrary
    Add Image Path    ${image_dir}
clear up
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close browser
    run keyword and ignore error    Stop Remote Server

case Teardown
    [Arguments]
    write test result to file    ${CURDIR}
*** Settings ***
Documentation    Verify sslvpn web mode login successfully when require client certificate.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
##this case can only be run on chrome, and cannot support Selenium Grid
${browser}    Chrome
${url}    ${SSLVPN_URL}
${username}    ${SSLVPN_GUI_USERNAME}
${password}    ${SSLVPN_GUI_PASSWORD}
*** Test Cases ***
751011
    #Warning: In order to run this case, need to add certificate to Chrome and 
    #configure "{\"pattern\":\"https://10.1.100.1:1443\",\"filter\":{\"ISSUER\":{\"CN\":\"FOS GUI Automation Root CA\"}}}" on registry of Windows.
    [Tags]    preconfig    no_grid    v6.0    chrome    751011    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys,selenium.webdriver
    ${desired_capabilities}=    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys,selenium.webdriver
    create webdriver    ${browser}    chrome_options=${chrome_options}    desired_capabilities=${desired_capabilities}
    go to    ${url}
    Maximize Browser Window
    input text    ${LOGIN_SSLVPN_USERNAME_TEXT}    ${username}
    input password    ${LOGIN_SSLVPN_PASSWORD_TEXT}    ${password}
    click button    ${LOGIN_SSLVPN_LOGIN_BUTTON}
    ${right_top_button_containing_username}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_ICON_BUTTON}    ${username}
    wait Until page contains element    ${right_top_button_containing_username}
    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

    
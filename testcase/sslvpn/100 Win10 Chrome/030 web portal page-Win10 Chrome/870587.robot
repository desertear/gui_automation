*** Settings ***
Documentation    Verify sslvpn valid pki user can login sslvpn web portal
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
##this case can only be run on chrome, and cannot support Selenium Grid
${browser}    Chrome
${part_of_username}    ${FGT_PKI_PEER_NAME}
${url}    ${SSLVPN_URL}
*** Test Cases ***
870587
    #Warning: In order to run this case, need to add certificate to Chrome and 
    #configure "{\"pattern\":\"https://10.1.100.1:1443\",\"filter\":{\"ISSUER\":{\"CN\":\"FOS GUI Automation Root CA\"}}}" on registry of Windows.
    [Tags]    preconfig    no_grid    v6.0    chrome    870587    medium    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys,selenium.webdriver
    ##below prefs are useless indeed.
    ${tmp_dic1}=    create dictionary    CN=Eternity-CA
    ${tmp_dic2}=    create dictionary    ISSUER=${tmp_dic1}  
    ${tmp_dic3}=    create dictionary    pattern=https://10.1.100.1:1443    filter=${tmp_dic2}
    ${default_certificate}=    create dictionary    profile.managed_auto_select_certificate_for_urls=${tmp_dic3}
    Call method    ${chrome_options}    add_experimental_option    prefs    ${default_certificate}
    ${desired_capabilities}=    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    sys,selenium.webdriver
    create webdriver    ${browser}    chrome_options=${chrome_options}    desired_capabilities=${desired_capabilities}
    go to    ${url}
    Maximize Browser Window
    ${right_top_button_containing_username}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${PORTAL_VAR_ICON_BUTTON}    ${part_of_username}
    wait Until page contains element    ${right_top_button_containing_username}
    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

    
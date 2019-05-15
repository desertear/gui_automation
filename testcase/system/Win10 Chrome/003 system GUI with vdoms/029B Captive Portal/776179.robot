*** Settings ***
Documentation      Verify Captive Portal can be configured and dispaly well in GUi
...                Failcase #536896
Resource    ../../../system_resource.robot

*** Variables ***
${username}    ${FGT_GUI_USERNAME}    
${password}    ${FGT_GUI_PASSWORD}
${test_interface}    ${SYSTEM_TEST_INTF_3}
${test_interface_tp}    ${SYSTEM_TEST_INTF_4}
*** Test Cases ***
776179
    [Tags]    Failcase!Bug#536896    v6.0    chrome   776179    High    win10,64bit    browsers    runable    env2fail
    [Setup]   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt 
    Login FortiGate
    sleep  2
    go to vdom    ${SYSTEM_TEST_VDOM_NAME_1}
    test Captive     ${test_interface}
    ############ go to vdom to check the function####
    sleep  2
    Go to network_Interfaces
    Go to network
    go to vdom    ${SYSTEM_TEST_VDOM_NAME_tp}   ${SYSTEM_TEST_VDOM_NAME_1}
    test Captive    ${test_interface_tp}
    ############ go to global to check the function####
    go to Global
    sleep  2
    Go to network
    Go to network_Interfaces
    network edit interface      ${test_interface}
    Set Interface Role To    LAN
    network edit interface      ${test_interface}
    sleep  2
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_MENU}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_MENU_OP_CAPTIVE}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_BUTTON}    Source
    wait and click   ${new_locator}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_1}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_CLOSE_BUTTON}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_BUTTON}    Destination
    wait and click   ${new_locator}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_1}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_CLOSE_BUTTON}
    ${status}=   run keyword and return status   checkbox should not be selected    ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_CHKBOX}
    run keyword if     "${status}"=="False"    wait and click    ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_LABEL}
    wait and click    ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_LABEL}
    sleep   1
    unselect frame
    sleep   1
    select frame     ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_SLIDE_FRAME}
    select frame     ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_EDITOR_FRAME}
    Wait Until Element Is Visible     ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_SPAN_MESSAGE}
    unselect frame
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_SPAN_CLOSE_BUTTON}
    select frame     ${NETWORK_FRAME}
    wait and click   ${SUBMIT_OK_BUTTON}
    unselect frame
    Logout FortiGate 
    Close all browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}setup_banner_cli.txt 
    ###  go to login page, pre_ban and post_ban should be shown 
    Open Browser    ${FGT_URL}    ${FGT_BROWSER}
    Set Window Size    ${SCREEN_SIZE_WIDTH}    ${SCREEN_SIZE_HEIGTH}
    Wait Until Element Is Visible  ${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_PRE_BAN}
    wait and click    ${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_ACPT}
    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    input text    ${LOGIN_USERNAME_TEXT}    ${username}
    input password    ${LOGIN_PASSWORD_TEXT}    ${password}
    Run Keyword And Continue On Failure    click button    ${LOGIN_LOGIN_BUTTON}
    sleep  2
    Wait Until Element Is Visible  ${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_POST_BAN}
    wait and click    ${NETWORK_INTERFACES_CAPTIVE_PTL_LGIN_ACPT}
    ##### login to foritgate ####
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    Wait Until Page Contains Element    ${FIPS_DISCLAIMER_HEAD}
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    click button    ${FIPS_ACCEPT_BUTTON}
    #Judge if warning of changing password would be shown on GUI
    ${if_password_change}=    run keyword and return status    Wait Until Page Contains Element    ${PWD_CHANGE_HEAD}
    run keyword if    "${if_password_change}"=="True"    Run Keyword And Continue On Failure    click button    ${PWD_CHANGE_LATER_BUTTON}
    #Judge if warning of being managed by FortiManager device would be shown on GUI
    ${if_managed_by_fmg}=    run keyword and return status    Wait Until Page Contains Element    ${FMG_LOGIN_HEAD}
    run keyword if    "${if_managed_by_fmg}"=="True"    Run Keyword And Continue On Failure    click button    ${FMG_LOGIN_READ_WRITE_BUTTON}
    #Judge if warning of out-of-sync on FortiManager device would be shown on GUI
    ${out_of_sync_warning_fmg}=    run keyword and return status    Wait Until Page Contains Element    ${OUT_OF_SYNC_FMG_TEXT}
    run keyword if    "${out_of_sync_warning_fmg}"=="True"    Run Keyword And Continue On Failure    click button    ${OUT_OF_SYNC_FMG_YES_BUTTON}
    #Judge if warning of out-of-sync on FortiManager device would be shown on GUI
    ${forticare_registration_required}=    run keyword and return status    Wait Until Page Contains    FortiCare Registration Required
    run keyword if    "${forticare_registration_required}"=="True"    Run Keyword And Continue On Failure    click button    ${FORTICARE_REQUIRED_BUTTON}
    Run Keyword And Continue On Failure    Wait Until Keyword Succeeds    3x    2s    Element Text Should Be    ${PLTF_TYPE_DIV}    ${FGT_HW_TYPE}
    sleep  2
    Go to network
    Go to network_Interfaces
    network edit interface      ${SYSTEM_TEST_INTF_3}
    sleep  2
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_MENU}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_MENU_OP_NONE}
    wait and click   ${SUBMIT_OK_BUTTON}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    Run Cli commands in File on Terminal Server       ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

test Captive
    [Arguments]    ${test_interface}
    sleep  2
    Go to network
    Go to network_Interfaces
    network edit interface      ${test_interface}
    Set Interface Role To    LAN
    network edit interface      ${test_interface}
    sleep  2
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_MENU}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_MENU_OP_CAPTIVE}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_BUTTON}    Source
    wait and click   ${new_locator}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_1}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_CLOSE_BUTTON}
    ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_BUTTON}    Destination
    wait and click   ${new_locator}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_1}
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_EXEMPT_SPAN_CLOSE_BUTTON}
    ${status}=   run keyword and return status   checkbox should not be selected    ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_CHKBOX}
    run keyword if     "${status}"=="False"    wait and click    ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_LABEL}
    wait and click    ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_LABEL}
    sleep   1
    unselect frame
    select frame     ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_SLIDE_FRAME}
    select frame     ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_EDITOR_FRAME}
    Wait Until Element Is Visible     ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_SPAN_MESSAGE}
    unselect frame
    wait and click   ${NETWORK_INTERFACES_CAPTIVE_CUSTOMIZE_SPAN_CLOSE_BUTTON}
    select frame     ${NETWORK_FRAME}
    wait and click   ${SUBMIT_CANCEL_BUTTON}
    unselect frame
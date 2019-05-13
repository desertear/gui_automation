*** Settings ***
Documentation  Verify that An admin can display different between 2 configuration via GUI.
Resource    ../../../system_resource.robot
*** Variables ***
${username}    admin
${test_user_name}    598168
${test_user_intf}    ${SYSTEM_TEST_INTF_3}
*** Test Cases ***
598168
    [Tags]    v6.0    chrome   598168    Critical    win10,64bit    runable    
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate  
    go to network
    go to network_Interfaces
    network edit interface  ${test_user_intf}
    Set Interface Role To   DMZ
    sleep   2
    go to network_Interfaces
    sleep   2
    logout FortiGate  
    
    Login FortiGate  
    go to network
    go to network_Interfaces
    network edit interface  ${test_user_intf}
    Set Interface Role To   LAN
    sleep    2
    go to network_Interfaces
    sleep   2
    Logout FortiGate  

    Login FortiGate  
    ${locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${LOGOUT_ICON_BUTTON}    ${username}
    wait and click     ${locator}
    Mouse over         ${ADMIN_CONFIGURATION_BAR}
    ${exist}=    run keyword and return status    wait until element is visible     ${ADMIN_CONFIGURATION_REVISION_BUTTON}
    run keyword if    "${exist}"=="False"   wait and click    ${ADMIN_CONFIGURATION_BAR}
    wait and click    ${ADMIN_CONFIGURATION_REVISION_BUTTON}
    ${new_expand_button}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_REVISION_ITEM_BUTTON}    ${FGT_BUILD}
    ${expand}=    Run Keyword and Return Status    wait until element is visible    ${new_expand_button}
    ${expand_status}=    Run Keyword If   "${expand}"=="True"    get toggle_button status    ${new_expand_button}
    Run keyword if   "${expand}"=="True" and "${expand_status}"=="False"    wait and click    ${new_expand_button}
    ${new_header}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_REVISION_ITEM_ENTRY_HEAD}     ${FGT_BUILD}
    ${new_item_1}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_REVISION_ITEM_ENTRY}     1
    ${new_item_2}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${ADMIN_CONFIGURATION_REVISION_ITEM_ENTRY}     2
    ${new_item_1}=    CATENATE  SEPARATOR=    ${new_header}   ${new_item_1}
    ${new_item_2}=    CATENATE  SEPARATOR=    ${new_header}   ${new_item_2}
    click element     ${new_item_1}   
    click element     ${new_item_2}    CTRL
    wait and click    ${ADMIN_CONFIGURATION_REVISION_DIFF_BUTTON}
    Wait Until Element Is Visible   ${ADMIN_CONFIGURATION_REVISION_DIFF_DIAGBOX_TITLE}
    sleep   2
    wait and click    ${SUBMIT_RETURN_BUTTON}
    wait and click    ${new_item_1}
    wait and click    ${ADMIN_CONFIGURATION_REVISION_DELETE_BUTTON}
    wait and click    ${CONFIRM_OK_BUTTON}
    sleep   2
    wait and click    ${new_item_2}
    wait and click    ${ADMIN_CONFIGURATION_REVISION_DELETE_BUTTON}
    wait and click    ${CONFIRM_OK_BUTTON}
    sleep   2
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}


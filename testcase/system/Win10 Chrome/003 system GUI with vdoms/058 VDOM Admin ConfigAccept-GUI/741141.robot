*** Settings ***
Documentation      To verify the management vdom can not be disabled from GUI
Resource    ../../../system_resource.robot

*** Variables ***
@{menu_list}     Dashboard    Security Fabric    FortiView    Network    System   
...              Policy & Objects    Security Profiles   VPN   User & Device
...              WiFi & Switch Controller   Log & Report    Monitor
@{menu_list_tp}     Dashboard    Security Fabric    FortiView    Network    System   
...              Policy & Objects    Security Profiles   User & Device
...              WiFi & Switch Controller   Log & Report    Monitor
${SYSTEM_ENTRY_TEST_XPATH}    xpath://div[span="\${PLACEHOLDER}"]
*** Test Cases ***
741141
##
    [Tags]    v6.0    chrome   741141    high    win10,64bit    browsers    runable   test10
    Login FortiGate    
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    :FOR   ${element}   IN    @{menu_list}
    \      ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ENTRY_TEST_XPATH}    ${element}
    \      wait until element is visible    ${new_locator}
    Go to Global
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_2}
    :FOR   ${element}   IN    @{menu_list}
    \      ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ENTRY_TEST_XPATH}    ${element}
    \      wait until element is visible    ${new_locator}
    Go to Global
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_tp}   
    :FOR   ${element}   IN    @{menu_list_tp}
    \      ${new_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ENTRY_TEST_XPATH}    ${element}
    \      wait until element is visible    ${new_locator}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}


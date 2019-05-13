*** Settings ***
Documentation    [GUI]  Verify DDNS will display  DDNS setting and function works on GUI
...              Failcase!  bug  #534807
Resource    ../../../system_resource.robot

*** Variables ***
${available}          xpath://span[contains(text(),"Available")]
${interface}          ${SYSTEM_TEST_INTF_1}
${Unique_location_fix}     BurnabyBCFORTINET
*** Test Cases ***
711291
    [Documentation]    
    [Tags]    sometimeFailcase!   v6.0    chrome   711291    High    win10,64bit    system   runable   
    ######
    Login FortiGate
    Go to Global
    Go to network
    ###  set ddns config ##
    go to network_dns
    wait and click    ${network_dns_dns settings_type_fortiguard}
    ${status}=    Run Keyword and return status    Checkbox Should Be Selected   ${network_dns_ddns_enable_checkbox}
    Run Keyword if   "${status}"=="False"    wait and click    ${network_dns_ddns_enable_label}
    SELECT MEBU BAR FROM DROPDOWN MENU   ${interface}    Interface
    wait and click    ${network_interfaces_create or edit_Interface members_close_button}
    wait and click    ${network_dns_ddns_Server}
    wait and click    ${network_dns_ddns_Server_fortiddns.com}
    wait and click    ${network_dns_ddns_Unique Location}
    ${random}=   Evaluate   random.randint(0,10000000000)    modules=random,sys
    ${Unique_location}=    Set Variable      ${random}${Unique_location_fix}
    Input Text        ${network_dns_ddns_Unique Location}    ${Unique_location}
    wait and click    ${NETWORK_DNS_DDNS_UNIQUE LOCATION_LABEL}
    wait and click    ${SUBMIT_APPLY_BUTTON}
    Unselect frame
    sleep   10
    ### test connection in embed console ####
    @{cmd_list}=    Create list    
    APPEND TO LIST    ${cmd_list}    config vdom    edit ${SYSTEM_TEST_VDOM_NAME_1}    exec ping ${Unique_location}.fortiddns.com
    TEST FROM CLI AND CHECK REGXP    ${cmd_list}    ${NETWORK_DNS_DNS_PING_TEST_RETURN_CLI}  
    Unselect Frame
    Go to network
    go to network_dns
    ${status}=    Run Keyword and return status    Checkbox Should Be Selected   ${network_dns_ddns_enable_checkbox}
    Run Keyword if   "${status}"=="True"    wait and click    ${network_dns_ddns_enable_label}
    

    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}


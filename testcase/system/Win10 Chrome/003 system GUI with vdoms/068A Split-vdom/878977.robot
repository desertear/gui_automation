*** Settings ***
Documentation    Verify can create/edit/delete wifi interface on global/vdom level (0526090,0526107)
Resource    ../../../system_resource.robot

*** Variables ***
@{list_interface}    ${SYSTEM_TEST_INTF_3}
${interface}    ${SYSTEM_TEST_INTF_3}
${password}    123
@{list_defult_vdom}   Security Fabric    CPU    Memory    Sessions
${vdom}    ${SYSTEM_TEST_VDOM_NAME_TRAFFIC}  
${wifi_name_locator}    xpath://tbody[tr/td[contains(label,"WiFi")]]/following-sibling::tbody[1]/tr[td[@class="name"][span/b="878977"]]/following-sibling::tr[1]/td[@class="name"]
*** Test Cases ***
878977
    [Tags]    Failcase!Bug533718   v6.0    chrome   878977    Medium    win10,64bit    browsers    runable   env2fail
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}splitvdom_setup_cli.txt
    Login FortiGate
    Go to network
    Go to network_Interfaces
    Create Network Interface  name=878977   type=WiFi   physical_interface=${list_interface}   vdom=${vdom}   ipmask=10.10.10.1/255.255.255.0    wifi_psk=123456789012
    network delete interface  main_interface_name=wqt.${vdom}    table_type=Software Switch
    select frame    ${NETWORK_FRAME}
    ${wifi_name}=   GET TEXT   ${wifi_name_locator}
    unselect frame
    network delete interface  main_interface_name=878977   subside_interface_name=${wifi_name}  table_type=WiFi
    unselect frame
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate    
    Close All Browsers
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    write test result to file    ${CURDIR}

    

*** Settings ***
Documentation      Verify FGT System information,serial,time,version etc are correct on status page with a vdom admin
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   590371
*** Test Cases ***
590371
    [Tags]    v6.0    chrome   590371    High    win10,64bit    browsers    runable   rest
    [Setup]   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate  username=${admin_name}  password=123
    sleep   2
    go to dashboard
    go to dashboard_main
    ${hostname_in_system_widget}=    Get text    ${system_info_widget_hostname}
    ${sn_in_system_widget}=    Get text    ${system_info_widget_SN}
    ${Firmware_in_system_widget}=    Get text    ${system_info_widget_firmware}
    ${Vdom_mode_in_system_widget}=    Get text    ${system_info_widget_Vdom_mode}
    Should Be Equal    ${hostname_in_system_widget}     ${FGT_HOSTNAME}
    Should Be Equal    ${sn_in_system_widget}           ${FGT_SN}
    Should Contain     ${Firmware_in_system_widget}     ${FGT_VERSION}  
    Should Contain     ${Firmware_in_system_widget}     ${FGT_BUILD}
    Should Be Equal    ${Vdom_mode_in_system_widget}    Virtual Domains
    ${time_pc}=    Get Current Date   
    ${time_pc}=    Convert Date    ${time_pc}    epoch
    ${time_fgt}=   Get Text   ${system_info_widget_system_time}   
    ${time_fgt}=   Convert Date    ${time_fgt}    epoch
    ${diff}=    Evaluate   ${time_pc}-${time_fgt}
    Should Be True    -3600<${diff}<3600
    ${vdom_mode}=    Get Text    ${system_info_widget_Vdom_mode} 
    Should Contain    ${vdom_mode}    Dom
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  username=${admin_name}
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

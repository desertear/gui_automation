*** Settings ***
Documentation      Verify FGT system information,embedded console,system resource,unit operation are correct on status page with a vdom admin when HA active-avtive mode.
...                Fail with bug #533179 duplicate with original bug #532907
...                Fixed in B0821 ECO#137785
Resource    ../../../system_resource.robot

*** Variables ***
${admin_name}   590397
@{list_defult}   Security Fabric   CPU   Memory   Sessions
*** Test Cases ***
590397
    [Tags]    Fixedcase!    v6.0    chrome   590397    High    win10,64bit    browsers    runable   rest
    [Setup]   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate  username=${admin_name}  password=123
    sleep  2
    go to dashboard
    go to dashboard_main
    sleep  2
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
    ${diff}=       Evaluate   ${time_pc}-${time_fgt}
    Should Be True    -3600<${diff}<3600
    ${uptime_fgt}=   Get Text   ${SYSTEM_INFO_WIDGET_uptime}
    ${uptime_fgt_day}=   Fetch from left   ${uptime_fgt}  :
    should be true   ${uptime_fgt_day}<300
    ${uptime_8}=   Get Substring   ${uptime_fgt}   -8  -1
    ${uptime_1}=   Get Substring   ${uptime_fgt}   -1
    ${uptime}=     CATENATE  SEPARATOR=    ${uptime_8}    ${uptime_1}
    ${uptime}=     Convert Time      ${uptime}
    should be true   ${uptime}<86400
    ${vdom_mode}=    Get Text    ${system_info_widget_Vdom_mode} 
    Should Contain   ${vdom_mode}    Dom
    Go to Global
    sleep   2
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    check if the widget is reset to default    @{list_defult}  
    unselect frame
    popup embed console 
    go to embed console
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate  username=${admin_name}
    Run Cli commands in File on Terminal Server    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    Close All Browsers
    write test result to file    ${CURDIR}

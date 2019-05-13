*** Settings ***
Documentation    Verify System information widget, Verify all the information visible and display correctly
...              Fail with bug #533179 duplicate with original bug #532907
...              Fixed in B0821 ECO#137785
Resource    ../../../system_resource.robot

*** Variables ***
*** Test Cases ***
180733
##   Verify System information widget's infor
    [Tags]    Fixedcase!    v6.0    chrome   180733    Critical    win10,64bit    browsers    runable
    Login FortiGate    
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
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

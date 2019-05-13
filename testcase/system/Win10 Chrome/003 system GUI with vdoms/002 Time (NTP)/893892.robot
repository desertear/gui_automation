*** Settings ***
Documentation    Verify FGT can work as a NTP server
Resource    ../../../system_resource.robot

*** Variables ***
@{ssh_cmd_FGT_B_setup}     config global    exec time 0:0:0    config sys ntp   set ntpsync enable    set type custom     
...                        config ntpserver   edit 1   set server 10.1.100.1   end   set syncinterval 5   end   end

*** Test Cases ***
893892

    [Tags]      v6.0    chrome   893892    High    win10,64bit    system   runable
    Login FortiGate   
    Go to system
    Go to system_Settings
    ${time_old}=   Get Text    ${system_time_in_setting_page}
    ${time_old}=   Convert Date    ${time_old}    epoch
    set checkbox enable    Setup device as local NTP server
    set ntp listen on interface to    ${FGT_VLAN20_INTERFACE}
    Wait Until Element Is Visible    ${system_gui_apply}
    Click Element    ${system_gui_apply}
    Wait Until Element Is Visible    ${SYSTEM_CHANGE_SAVE_NOTIFY_MESSAGE}
    Execute CLI commands on FortiGate Via Terminal Server   ${ssh_cmd_FGT_B_setup}    telnet_port=${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}     prompt=${FGTB_CLI_PROMPT}
    sleep    20s
    Logout FortiGate
    Login FortiGate  url=${FGTB_URL}  
    go to dashboard
    go to dashboard_main
    ##go to mainborad and get the new time after synchronized
    Wait Until Element Is Visible    ${system_info_widget_system_time_value}
    ${time_syn}=    get system_time_in_main_widget 
    ${time_syn}=    Convert Date     ${time_syn}    epoch
    #campare with the saved time, the difference should less than 100s in consideration of script running time#
    ${diff}=    Evaluate   ${time_syn}-${time_old}
    Should Be True    -200<${diff}<200
    
    [Teardown]   case teardown

*** Keywords ***
case teardown
   Logout FortiGate
   Close All Browsers
   write test result to file    ${CURDIR}


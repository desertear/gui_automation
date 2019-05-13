*** Settings ***
Documentation    Verify Fortiguard NTP server works GUI 
...              Failcase! Bug#055703  "cutom" button is grayed out and cannot be clicked
Resource    ../../../system_resource.robot

*** Variables ***
*** Test Cases ***
731129
##judge if the system time can sychronized with Fortiguard, can be set to custom server, and can be dispalyed correctly in system widget
    [Tags]    Failcase!Bug#055703  v6.0    chrome   731129    High    win10,64bit    browsers    system   runable
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate    
    Go to system
    Go to system_Settings
    Wait Until Element Is Visible    ${system_ntp-custom_settings_label}
    Click Element    ${system_ntp-custom_settings_label}
    ##test if the ntp server has been set to custom and can be display##
    ${ntp_server_name}=    Get Element Attribute    ${system_ntp_custom_server_name}    value    
    Should Be Equal   ${ntp_server_name}     time1.google.com
    ##get current time, it will be used for comparison with the sychronized time later##
    ${time_old}=   Get Text    ${system_time_in_setting_page}
    ${time_old}=   Convert Date    ${time_old}    epoch
    ##manual set time to another##
    Wait Until Element Is Visible    ${system_ntp-manual settings_label}
    Click Element    ${system_ntp-manual settings_label}
    input time       10    10    10
    ##set time to synchronize mode##
    Wait Until Element Is Visible    ${system_ntp_server_label}
    Click Element    ${system_ntp_server_label}
    sleep    2s
    Wait Until Element Is Visible    ${system_gui_apply}
    Click Element    ${system_gui_apply}
    sleep    30s
    Login FortiGate    
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
   Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
   write test result to file    ${CURDIR}

input time 
    [Arguments]    ${hours}    ${minutes}    ${seconds}  
    Wait Until Element Is Visible     ${system_ntp-manual settings_second}
    Wait Until Element Is Visible     ${system_ntp-manual settings_date}
    Clear Element Text   ${system_ntp-manual settings_date}
    Wait Until Element Is Visible     ${system_time_set_time_prev_month}
    sleep    2s
    Click Element    ${system_time_set_time_prev_month}
    sleep    3s
    Click Element    ${system_time_set_time_prev_month}
    sleep    2s
    Wait Until Element Is Visible     ${system_time_set_time_date_first} 
    Click Element    ${system_time_set_time_date_first} 
    sleep    2s
    Input Text    ${system_ntp-manual settings_hour}    ${hours}
    sleep    2s
    Input Text    ${system_ntp-manual settings_minute}  ${minutes}
    sleep    2s
    Input Text    ${system_ntp-manual settings_second}  ${seconds}
    sleep    2s
    Wait Until Element Is Visible    ${system_gui_apply}
    Click Element    ${system_gui_apply}
    sleep   2s

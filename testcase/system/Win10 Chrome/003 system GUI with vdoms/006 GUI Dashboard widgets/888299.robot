*** Settings ***
Documentation    Verify time on widget changed according to setting of gui-date-time-source (0499352)

Resource    ../../../system_resource.robot

*** Variables ***
@{fgt_set_time_system}      config global    config system global    set gui-date-time-source system     end     end 
@{fgt_set_time_browser}     config global    config system global    set gui-date-time-source browser    end     end 
*** Test Cases ***
888299
##  Verify time on widget changed according to setting of gui-date-time-source
    [Tags]        v6.0    chrome   888299    Medium   win10,64bit    browsers    norun
    ## set system time to eastern-time first, should be earlier 3 hours
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Execute CLI commands on FortiGate Via Direct Telnet   ${fgt_set_time_system}
    Login FortiGate    
    go to dashboard
    go to dashboard_main
    ${time_pc}=    Get Current Date   
    ${time_pc}=    Convert Date    ${time_pc}    epoch
    ${time_fgt}=   Get Text   ${system_info_widget_system_time}   
    ${time_fgt}=   Convert Date    ${time_fgt}    epoch
    ${diff}=    Evaluate   ${time_fgt}-${time_pc}
    Should Be True    10800<${diff}<10980
    Logout FortiGate
    Close All Browsers
    Execute CLI commands on FortiGate Via Direct Telnet   ${fgt_set_time_browser}
    Login FortiGate    
    go to dashboard
    go to dashboard_main
    ${time_pc}=    Get Current Date   
    ${time_pc}=    Convert Date    ${time_pc}    epoch
    ${time_fgt}=   Get Text   ${system_info_widget_system_time}   
    ${time_fgt}=   Convert Date    ${time_fgt}    epoch
    ${diff}=    Evaluate   ${time_fgt}-${time_pc}
    Should Be True    -180<${diff}<180
    Execute CLI commands on FortiGate Via Direct Telnet   ${fgt_set_to_other_timezone}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

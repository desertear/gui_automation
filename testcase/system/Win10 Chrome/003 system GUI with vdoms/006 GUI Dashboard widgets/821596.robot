*** Settings ***
Documentation    Verify When connected to FGD, GUI System Information widget can display detailed public IP info include city/province/contry.
Resource    ../../../system_resource.robot

*** Variables ***
@{command}     config global    diag sys waninfo | grep "WAN IP:"
*** Test Cases ***
821596
##   Verify System information widget's infor
    [Tags]    v6.0    chrome   821596    High    win10,64bit    browsers    runable   
    [setup]    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    @{response}=    Execute CLI commands on FortiGate Via Terminal Server     ${command}  
    ${resp}=        SET VARIABLE   @{response}[-1]
    ${system_wanip}=    FETCH FROM RIGHT  ${resp}          IP:
    ${system_wanip}=    FETCH FROM LEFT   ${system_wanip}  \r
    ${system_wanip}=    STRIP STRING      ${system_wanip}
    sleep   10
    go to dashboard
    go to dashboard_main
    Reload Page 
    Wait Until Element Is Visible    ${system_info_widget_WAN IP_value}
    ${wanip}=    Get text    ${system_info_widget_WAN IP_value}
    should be equal   "${wanip}"   "${system_wanip}"


    # Mouse Over     ${system_info_widget_WAN IP_value}
    # sleep   3
    # ## cannot wait the tooltip ####
    # Wait Until Element Is Visible     ${system_info_widget_WAN IP_location_tooltip} 
    # ${wan ip location_in_system_widget}=    Get text    ${system_info_widget_WAN IP_location_tooltip} 
    # Should Contain     ${wan ip location_in_system_widget}     Burnaby, British Columbia, Canada
    [teardown]    case teardown  

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

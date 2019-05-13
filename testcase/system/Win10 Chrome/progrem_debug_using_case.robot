*** Settings ***
Documentation  using to debug program  
Resource  ../system_resource.robot

*** Variables ***

*** Test Cases ***
program_test
    [Tags]   program_test  norun
    :FOR  ${i}   IN RANGE   1   1002
         \  create a policy     ${i}
    #[teardown]    case teardown
#python -m robot --loglevel TRACE:TRACE -v FGT_BROWSER:chrome -v FGT_ENV:env.aaron.firewall.robot -v FIREWALL_ENV:firewall_env_FGT_300E.robot -i firewall ./
*** Keywords ***
case Teardown
    #Logout FortiGate
    #Close All Browsers

deleted_test
    Wait Until Element Is Visible ${dnscase_database_configed_entry}

system_click_widget_setting_button
    Mouse Over      ${system_widget_dashboard_blank_page}
    # ${exist}=   run keyword and return status    Wait Until Element Is Visible   ${system_widget_CPU_widgetbanner}
    # run keyword if    "${exist}"=="True"     Mouse Over         ${system_widget_CPU_widgetbanner}
    # run keyword if    "${exist}"=="True"     Mouse Out          ${system_widget_CPU_widgetbanner}
    # run keyword if    "${exist}"=="True"     sleep   1
    # run keyword if    "${exist}"=="True"     Mouse Over         ${system_widget_CPU_widgetbanner}
    Wait Until Element Is Visible    ${system_widget_setting_button}
    Click Element      ${system_widget_setting_button}
create a policy
    [Arguments]   ${policyid}
    @{command}=   create list     config vdom    edit vdom1    config firewall policy    edit ${policyid}   set name test${policyid}    set srcintf any    set dstintf any   set srcaddr all   set dstaddr all    set service ALL    set schedule always    set acction accept     end    end
    Execute CLI commands on FortiGate Via Direct Telnet      ${command}
    
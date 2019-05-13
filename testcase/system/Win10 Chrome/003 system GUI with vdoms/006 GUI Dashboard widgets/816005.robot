*** Settings ***
Documentation    Verify GUI will give notification when connection to FortiGate is broken
Resource    ../../../system_resource.robot

*** Variables ***
${system_widget_fortigate_connect_interface}    xpath://td[contains(text(),"${FGT_VLAN20_IP}")]
${system_widget_fortigate_disconnect_dialogbox}   xpath://div[text()="Attempting to reconnect"]
${Network_interfaces_Edit interface_state_disabled_button}    xpath://span[text()=" Disabled"]
${Network_interfaces_iframe}        xpath://iframe[@name="embedded-iframe"]
${Network_interfaces_Edit interface_OK_button}    xpath://button[@id="submit_ok"]
${system_widget_fortigate_reconnect_dialogbox}    xpath://div[contains(text(),"FortiGate was lost temp")]
*** Test Cases ***
816005
##   Verify GUI will give notification when connection to FortiGate is broken, "Attempting ro reconnect" appeared
    [Tags]    v6.0    chrome   816005    Critical    win10,64bit    browsers    norun
    
    Login FortiGate     
    # sleep  5s
    # Go to network
    # Go to Interfaces
    # Select Frame     ${Network_interfaces_iframe} 
    # wait Until Element Is Visible  ${system_widget_fortigate_connect_interface}
    # Mouse over    ${system_widget_fortigate_connect_interface}
    # sleep   2s
    # Double Click Element    ${system_widget_fortigate_connect_interface}
    # sleep   2s
    # Unselect Frame    
    # Select Frame     ${Network_interfaces_iframe} 
    # Capture Page Screenshot 
    # wait and click    ${system_widget_fortigate_connect_interface_state_disabled_button}
    # sleep   1s
    # wait and click    ${Network_interfaces_Edit interface_OK_button} 
    # Unselect Frame    
    # Wait Until Element Is Visible   ${system_widget_fortigate_disconnect_dialogbox}
    # Mouse over    ${system_widget_fortigate_disconnect_dialogbox}
    # sleep   2s
    # Mouse out
    # sleep   2s
    # Mouse over    ${system_widget_fortigate_disconnect_dialogbox}
    # sleep   2s
    # Reload Page
    
     [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

test_in_gui
    Go to network
    Go to Interfaces
    Select Frame     ${Network_interfaces_iframe} 
    wait Until Element Is Visible  ${system_widget_fortigate_connect_interface}
    Double Click Element    ${system_widget_fortigate_connect_interface}
    sleep   2s
    
    wait and click    ${system_widget_fortigate_connect_interface_state_disabled_button}
    sleep   1s
    wait and click    ${Network_interfaces_Edit interface_OK_button} 
    Unelect Frame    
    Wait Until Element Is Visible   ${system_widget_fortigate_disconnect_dialogbox}
    Mouse over    ${system_widget_fortigate_disconnect_dialogbox}
    sleep   2s
    Mouse out
    sleep   2s
    Mouse over    ${system_widget_fortigate_disconnect_dialogbox}
    sleep   2s
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    sleep   5s
    Wait Until Element Is Visible regardless of iframe    ${system_widget_fortigate_reconnect_dialogbox}  
    Mouse over     ${system_widget_fortigate_reconnect_dialogbox} 
    sleep   2s
    Mouse out
    sleep   2s
    Mouse over    ${system_widget_fortigate_reconnect_dialogbox} 
    sleep   2s
    Reload Page
    
  

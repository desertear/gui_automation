*** Settings ***
Documentation     Verify DHCP interface has only Receive LLDP enabled
Resource    ../../../system_resource.robot

*** Variables ***

*** Test Cases ***
875410
    [Documentation]    
    [Tags]    v6.0    chrome   875410   High    win10,64bit    runable    
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    network edit interface  ${SYSTEM_TEST_INTF_3}
    Set Interface Role To   LAN
    network edit interface  ${SYSTEM_TEST_INTF_3}
    sleep   2
    Set Interface Addressing Mode To  DHCP
    network edit interface  ${SYSTEM_TEST_INTF_3}
    sleep   2
    Wait Until Element Is Visible     ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_REC_TITLE}

    ### check if the transmission label is on the screen  ###
    ${exist}=    Run Keyword and Return Status    Wait Until Element Is Visible     ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_TITLE}
    should be equal   "${exist}"    "False"
    #${style}=   get element attribute     ${NETWORK_INTERFACE_ADMINISTRATIVE_ACESS_LLDP_TRANS_TITLE}   style
    #should contain    ${style}    none
    
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

  

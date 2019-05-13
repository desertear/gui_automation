*** Settings ***
Documentation    Verify 'interface alias' displayed correctly in firewall policy list page and create address and vip drop down list.
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${intf_alias_1}    ~intf@1 $a%b^c&d*e-F+G=
${intf_alias_2}    [alias 2]r:t;yu,i.op/a\d

*** Test Cases ***
178352
    [Documentation]    
    [Tags]    chrome    178352    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    ${expect_intf1}=    Generate Interface Alias and Name Display    ${intf_alias_1}    ${FW_TEST_INTF_1}
    ${expect_intf2}=    Generate Interface Alias and Name Display    ${intf_alias_2}    ${FW_TEST_INTF_2}
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Alias displayed correctly in firewall policy list 
    Log    ==================== Step 1: Alias displayed correctly in firewall policy list ====================
    Go to IPv4 policy   
    View By Sequence
    @{column_list}=    Create List    To     
    ${display_1}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_1}
    Should Be Equal    ${display_1[1]}    ${expect_intf1}        
    @{column_list}=    Create List    From
    ${display_2}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_1}
    Should Be Equal    ${display_2[1]}    ${expect_intf2}
    
    Go to IPv6 policy   
    View By Sequence
    @{column_list}=    Create List    To     
    ${display_1}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V6_POLICY_ID_1}
    Should Be Equal    ${display_1[1]}    ${expect_intf1}        
    @{column_list}=    Create List    From
    ${display_2}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V6_POLICY_ID_1}
    Should Be Equal    ${display_2[1]}    ${expect_intf2}

#Step 2: Alias displayed correctly when creating address 
    Log    ==================== Step 2: Alias displayed correctly when creating address ====================
    Go to Addresses
    Click Create New on Addresses List
    Click Element    ${POLICY_ADDRESSES_INTERFACE_DIV}
    Wait Until Element Contains    ${POLICY_ADDRESSES_INTERFACE_SELECTION}    ${expect_intf1}
    Wait Until Element Contains    ${POLICY_ADDRESSES_INTERFACE_SELECTION}    ${expect_intf2}
    Click Element    ${POLICY_ADDRESSES_INTERFACE_SELECTED}
    Click Cancel Button on Address Editor
   
#Step 3: Alias displayed correctly when creating vip 
    Log    ==================== Step 3: Alias displayed correctly when creating vip ====================   
    Go to Virtual IP
    Click Create New on Virtual IP List
    Click Element    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_DIV}
    Wait Until Element Contains    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTION}    ${expect_intf1}
    Wait Until Element Contains    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTION}    ${expect_intf2}
    Click Element    ${POLICY_VIRTUAL_IP_VIP_INTERFACE_SELECTED}
    Click Cancel Button on Virtual IP Editor 

    Logout FortiGate

*** Keywords ***
Generate Interface Alias and Name Display    
    [Arguments]   ${alias}    ${intf}
    ${display} =	Catenate	${alias}    (
    ${display} =	Catenate	SEPARATOR=    ${display}    ${intf}
    ${display} =	Catenate	SEPARATOR=    ${display}    )
    [return]    ${display}

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
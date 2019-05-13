*** Settings ***
Documentation    Verify policy with multiple addr/addrgrp can be edited and addr/addrgrp can be added or removed.
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
#for step 1 test
@{column_list}    Source    Destination
${original_src_addr}    ${FW_TEST_ADDR_1}${FW_TEST_ADDR_2}
@{add_src_addr}    ADDRESS:${FW_TEST_ADDR_4}    ADDRESS:${FW_TEST_ADDR_GROUP_2}
${new_src_addr}    ${FW_TEST_ADDR_1}${FW_TEST_ADDR_2}${FW_TEST_ADDR_4}${FW_TEST_ADDR_GROUP_2}
${original_dst_addr}    ${FW_TEST_ADDR_3}${FW_TEST_ADDR_GROUP_1}
@{add_dst_addr}    ADDRESS:${FW_TEST_ADDR_GROUP_3}
${new_dst_addr}    ${FW_TEST_ADDR_3}${FW_TEST_ADDR_GROUP_1}${FW_TEST_ADDR_GROUP_3}

@{column_list6}    Source    Destination Address
${original_src_addr6}    ${FW_TEST_ADDR6_1}${FW_TEST_ADDR6_2}
@{add_src_addr6}    ADDRESS:${FW_TEST_ADDR6_4}    ADDRESS:${FW_TEST_ADDR6_GROUP_2}
${new_src_addr6}    ${FW_TEST_ADDR6_1}${FW_TEST_ADDR6_2}${FW_TEST_ADDR6_4}${FW_TEST_ADDR6_GROUP_2}
${original_dst_addr6}    ${FW_TEST_ADDR6_3}${FW_TEST_ADDR6_GROUP_1}
@{add_dst_addr6}    ADDRESS:${FW_TEST_ADDR6_GROUP_3}
${new_dst_addr6}    ${FW_TEST_ADDR6_3}${FW_TEST_ADDR6_GROUP_1}${FW_TEST_ADDR6_GROUP_3}

#for step 2 test
@{del_src_addr}    ADDRESS:${FW_TEST_ADDR_2}    ADDRESS:${FW_TEST_ADDR_4}
${2new_src_addr}    ${FW_TEST_ADDR_1}${FW_TEST_ADDR_GROUP_2}
@{del_dst_addr}    ADDRESS:${FW_TEST_ADDR_3}    ADDRESS:${FW_TEST_ADDR_GROUP_1}
${2new_dst_addr}    ${FW_TEST_ADDR_GROUP_3}

@{del_src_addr6}    ADDRESS:${FW_TEST_ADDR6_2}
${2new_src_addr6}    ${FW_TEST_ADDR6_1}${FW_TEST_ADDR6_4}${FW_TEST_ADDR6_GROUP_2}
@{del_dst_addr6}    ADDRESS:${FW_TEST_ADDR6_3}    ADDRESS:${FW_TEST_ADDR6_GROUP_1}
${2new_dst_addr6}    ${FW_TEST_ADDR6_GROUP_3}


*** Test Cases ***
599492
    [Documentation]
    [Tags]    chrome    599492    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: address and address group can be added to policy
    Log    ==================== Step 1: address and address group can be added to policy ====================
    Go to IPv4 policy
    View By Sequence
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${original_src_addr}
    Should Be Equal    ${display[2]}    ${original_dst_addr}
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Select Address on Policy Editor    Source    ${add_src_addr}
    sleep    1
    Select Address on Policy Editor    Destination    ${add_dst_addr}    
    Click Ok Button on Policy Editor
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${new_src_addr}
    Should Be Equal    ${display[2]}    ${new_dst_addr}

    Go to IPv6 policy
    View By Sequence
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list6}    ${FW_TEST_V6_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${original_src_addr6}
    Should Be Equal    ${display[2]}    ${original_dst_addr6}
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Select Address on Policy Editor    Source    ${add_src_addr6}
    sleep    1
    Select Address on Policy Editor    Destination Address    ${add_dst_addr6}    
    Click Ok Button on Policy Editor
    ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list6}    ${FW_TEST_V6_POLICY_ID_1}
    Should Be Equal    ${display[1]}    ${new_src_addr6}
    Should Be Equal    ${display[2]}    ${new_dst_addr6}    
 

# Step 2: address and address group can be removed from policy
     Log    ==================== Step 2: address and address group can be removed from policy ==================== 
     Go to IPv4 policy
     View By Sequence
     Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
     Unselect Address on Policy Editor    Source    ${del_src_addr}
     sleep    1
     Unselect Address on Policy Editor    Destination    ${del_dst_addr}      
     Click Ok Button on Policy Editor
     ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list}    ${FW_TEST_V4_POLICY_ID_1}
     Should Be Equal    ${display[1]}    ${2new_src_addr}
     Should Be Equal    ${display[2]}    ${2new_dst_addr}

     Go to IPv6 policy
     View By Sequence
     Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
     Unselect Address on Policy Editor    Source    ${del_src_addr6}
     sleep    1
     Unselect Address on Policy Editor    Destination Address    ${del_dst_addr6}      
     Click Ok Button on Policy Editor
     ${display}=    Get Policy Config by Column Name and Policy ID    ${column_list6}    ${FW_TEST_V6_POLICY_ID_1}
     Should Be Equal    ${display[1]}    ${2new_src_addr6}
     Should Be Equal    ${display[2]}    ${2new_dst_addr6}    
    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

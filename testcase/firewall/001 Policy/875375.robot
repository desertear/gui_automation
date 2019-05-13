*** Settings ***
Documentation    Verify fixed-port and ip pool can be shown correctly on GUI
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
875375
    [Documentation]    
    [Tags]    chrome    875375    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: fixed port can be enabled and disabled on policy editor
    Log    ==================== Step 1: fixed port can be enabled and disabled on policy editor ====================
    #test ipv4 policy
    Go to IPv4 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_FIXED_PORT_INPUT}
    Select Checkbox by JS on Policy Editor    Preserve Source Port    ${POLICY_V4V6_FIXED_PORT_ID}    ${POLICY_V4V6_FIXED_PORT_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Checkbox Should Be Selected    ${POLICY_V4V6_FIXED_PORT_INPUT}    
    Unselect Checkbox by JS on Policy Editor    Preserve Source Port    ${POLICY_V4V6_FIXED_PORT_ID}    ${POLICY_V4V6_FIXED_PORT_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_FIXED_PORT_INPUT}
    Click Cancel Button on Policy Editor

    #test ipv6 policy
    Go to IPv6 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_FIXED_PORT_INPUT}
    Select Checkbox by JS on Policy Editor    Preserve Source Port    ${POLICY_V4V6_FIXED_PORT_ID}    ${POLICY_V4V6_FIXED_PORT_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Checkbox Should Be Selected    ${POLICY_V4V6_FIXED_PORT_INPUT}    
    Unselect Checkbox by JS on Policy Editor    Preserve Source Port    ${POLICY_V4V6_FIXED_PORT_ID}    ${POLICY_V4V6_FIXED_PORT_INPUT}    NO
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Checkbox Should Not Be Selected    ${POLICY_V4V6_FIXED_PORT_INPUT}
    Click Cancel Button on Policy Editor  

#Step 2: All ippools are available when fixed-port is disabled; only one-to-one and overloaded when fixed port is enabled
    Log    ==================== Step 2: All ippools are available when fixed-port is disabled; only one-to-one and overloaded when fixed port is enabled ====================     
    #test ipv4 policy
    Go to IPv4 policy    
    View By Sequence
    #change setting to use Dynamic IP Pool
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Element Attribute Value Should Be    ${POLICY_V4V6_IP_POOL_INTF_INPUT}    checked    true
    Change IP Pool to Dynamic Pool on Policy Editor
    ${ip_pool_list} =    Create List    ${FW_TEST_IP_POOLS_1}    ${FW_TEST_IP_POOLS_2}    ${FW_TEST_IP_POOLS_3}    ${FW_TEST_IP_POOLS_4}
    Click Element    ${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_DIV}
    Check Element Visibility in Selection Pane    ${ip_pool_list}    YES    NA
    Close Selection Pane
    #check ip pool list when fixed port is enable
    Select Checkbox by JS on Policy Editor    Preserve Source Port    ${POLICY_V4V6_FIXED_PORT_ID}    ${POLICY_V4V6_FIXED_PORT_INPUT}    NO
    Click Element    ${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_DIV}
    ${ip_pool_list} =    Create List    ${FW_TEST_IP_POOLS_3}    ${FW_TEST_IP_POOLS_4}
    Check Element Visibility in Selection Pane    ${ip_pool_list}    NO    NA
    ${ip_pool_list} =    Create List    ${FW_TEST_IP_POOLS_1}    ${FW_TEST_IP_POOLS_2}
    Check Element Visibility in Selection Pane    ${ip_pool_list}    YES    NA
    Select Element in Selection Pane    ${ip_pool_list}
    Close Selection Pane
    Click OK Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Verify Settings By locator on Policy Editor    ${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_SELECT}     ${ip_pool_list}
    Click Cancel Button on Policy Editor

    #test ipv6 policy
    Go to IPv6 policy    
    View By Sequence
    #change setting to use Dynamic IP Pool
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Element Attribute Value Should Be    ${POLICY_V4V6_IP_POOL_INTF_INPUT}    checked    true
    Change IP Pool to Dynamic Pool on Policy Editor
    ${ip_pool_list} =    Create List    ${FW_TEST_IP_POOLS6_1}    ${FW_TEST_IP_POOLS6_2}
    Click Element    ${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_DIV}
    Check Element Visibility in Selection Pane    ${ip_pool_list}    YES    NA
    Close Selection Pane
    #check ip pool list when fixed port is enable
    Select Checkbox by JS on Policy Editor    Preserve Source Port    ${POLICY_V4V6_FIXED_PORT_ID}    ${POLICY_V4V6_FIXED_PORT_INPUT}    NO
    Click Element    ${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_DIV}
    Check Element Visibility in Selection Pane    ${ip_pool_list}    YES    NA
    Select Element in Selection Pane    ${ip_pool_list}
    Close Selection Pane
    Click OK Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Verify Settings By locator on Policy Editor    ${POLICY_V4V6_IP_POOL_DYNAMIC_POOL_SELECT}     ${ip_pool_list}
    Click Cancel Button on Policy Editor
    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
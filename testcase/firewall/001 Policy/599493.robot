*** Settings ***
Documentation    Verify traffic shapers can be shown correctly on GUI
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
599493
    [Documentation]    
    [Tags]    chrome    599493    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Traffic shaper setting only shown when it is enabled in ipv4 policy
    Log    ==================== Step 1: Traffic shaper setting only shown when it is enabled in ipv4 policy ====================
    Go to IPv4 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Traffic Shaping Should be Visible
    Disable All Traffic Shaping
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Traffic Shaping Should Not be Visible
    Click Cancel Button on Policy Editor

#Step 2: Traffic shaper setting only shown when it is enabled in ipv6 policy
    Log    ==================== Step 2: Traffic shaper setting only shown when it is enabled in ipv6 policy ====================
    Go to IPv6 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Traffic Shaping Should be Visible
    Disable All Traffic Shaping
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Traffic Shaping Should Not be Visible
    Click Cancel Button on Policy Editor    
    Logout FortiGate

*** Keywords ***

Traffic Shaping Should Not be Visible
    Element Should Not Be Visible     ${POLICY_V4V6_POLICY_TRAFFIC_SHAPING_H2}
    Element Should Not Be Visible     ${POLICY_V4V6_SHARED_SHAPER_INPUT}
    Element Should Not Be Visible     ${POLICY_V4V6_SHARED_SHAPER_REVERSE_INPUT}
    Element Should Not Be Visible     ${POLICY_V4V6_PER_IP_SHAPER_INPUT}

Traffic Shaping Should be Visible
    Element Should Be Visible     ${POLICY_V4V6_POLICY_TRAFFIC_SHAPING_H2}
    Checkbox Should Be Selected    ${POLICY_V4V6_SHARED_SHAPER_INPUT}
    Verify Setting By Attribute on Policy Editor    Shared Shaper    ${FW_TEST_SHAPER_SHARED_DEFAULT_2}
    Checkbox Should Be Selected    ${POLICY_V4V6_SHARED_SHAPER_REVERSE_INPUT}
    Verify Setting By Attribute on Policy Editor    Reverse Shaper    ${FW_TEST_SHAPER_SHARED_DEFAULT_3}
    Checkbox Should Be Selected    ${POLICY_V4V6_PER_IP_SHAPER_INPUT}
    Verify Setting By Attribute on Policy Editor    Per-IP Shaper    ${FW_TEST_SHAPER_PER_IP_1}

Disable All Traffic Shaping
    Unselect Checkbox by JS on Policy Editor    Shared Shaper    ${POLICY_V4V6_SHARED_SHAPER_ID}    ${POLICY_V4V6_SHARED_SHAPER_INPUT}
    Unselect Checkbox by JS on Policy Editor    Reverse Shaper    ${POLICY_V4V6_SHARED_SHAPER_REVERSE_ID}    ${POLICY_V4V6_SHARED_SHAPER_REVERSE_INPUT}
    Unselect Checkbox by JS on Policy Editor    Per-IP Shaper    ${POLICY_V4V6_PER_IP_SHAPER_ID}    ${POLICY_V4V6_PER_IP_SHAPER_INPUT}


case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
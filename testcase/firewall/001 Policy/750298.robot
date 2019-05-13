*** Settings ***
Documentation    Verify profile group can be displayed well on address policy/id-based policy/device policy
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
   

*** Test Cases ***
750298
    [Documentation]    
    [Tags]    chrome    750298    critical
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    ${profile_group_setting_locator}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${VAR_POLICY_V4V6_DIV_LIST_SELECTION}    Use Security Profile Group

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: profile group should be displayed correctly under different policy settings
    Log    ==================== Step 1: profile group should be displayed correctly under different policy settings ====================
    #test ipv4 policy
    Go to IPv4 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_1}
    Click Cancel Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_2}
    Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_2}
    Click Cancel Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_3}
    Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_1}
    Click Cancel Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_4}
    Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_2}
    Click Cancel Button on Policy Editor

    #test ipv6 policy
    Go to IPv6 policy    
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT} 
    Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_1} 
    Click Cancel Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_2}
    Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_2}  
    Click Cancel Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_3}
    Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_1}  
    Click Cancel Button on Policy Editor     
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_4}
    Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_2}  
    Click Cancel Button on Policy Editor     

#Step 2: profile group can be disabled and enabled
    Log    ==================== Step 2: profile group can be disabled and enabled ====================
    #test ipv4 policy
    Go to IPv4 policy    
    View By Sequence
    
    #disable profile group
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_4}
    Unselect Checkbox by JS on Policy Editor    Use Security Profile Group    ${POLICY_V4V6_PROFILE_GROUP_ID}    ${POLICY_V4V6_PROFILE_GROUP_INPUT}   
    Select from List on Policy Editor    SSL Inspection${SPACE}    no-inspection
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_4}    
    Checkbox Should Not Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Element Should Not Be Visible    ${profile_group_setting_locator}

    #enable profile group
    #Iven 2019-01-08: after enable checkbox by using js, the moniselect list is still not avilable. have not found a solution yet. Will investigate later
    #Select Checkbox by JS on Policy Editor    Use Security Profile Group    ${POLICY_V4V6_PROFILE_GROUP_ID}    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    #Select from List on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_2}
    #Click Ok Button on Policy Editor
    #Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_4}    
    #Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    #Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_2}
    #Iven 2019-01-08: End
    
    Click Cancel Button on Policy Editor

    
    #test ipv6 policy
    Go to IPv6 policy    
    View By Sequence
    #disable profile group
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_4}
    Unselect Checkbox by JS on Policy Editor    Use Security Profile Group    ${POLICY_V4V6_PROFILE_GROUP_ID}    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Select from List on Policy Editor    SSL Inspection${SPACE}    no-inspection
    Click Ok Button on Policy Editor
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_4}    
    Checkbox Should Not Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    Element Should Not Be Visible    ${profile_group_setting_locator}
    #enable profile group    
    #Iven 2019-01-08: after enable checkbox by using js, the moniselect list is still not avilable. have not found a solution yet. Will investigate later
    #Select Checkbox by JS on Policy Editor    Use Security Profile Group    ${POLICY_V4V6_PROFILE_GROUP_ID}    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    #Select from List on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_2}
    #Click Ok Button on Policy Editor
    #Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_4}    
    #Checkbox Should Be Selected    ${POLICY_V4V6_PROFILE_GROUP_INPUT}
    #Verify Setting By Attribute on Policy Editor    Use Security Profile Group    ${FW_TEST_UTM_PROFILE_GROUP_2}
    #Iven 2019-01-08: End

    Click Cancel Button on Policy Editor

    Logout FortiGate

*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
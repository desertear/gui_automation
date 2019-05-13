*** Settings ***
Documentation    Verify Online_Help/Video_tutorials/FortiGate_Cookbook_video link can shown and work in gutter area of policy
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${ipv4_policy_help_href}    cshid=policy_newedit    #http://help.fortinet.com/fos60hlp/62/index.htm#cshid=policy_newedit
${ipv6_policy_help_href}    cshid=policy_newedit    #http://help.fortinet.com/fos60hlp/62/index.htm#cshid=policy_newedit
${nat64_policy_help_href}    cshid=policy64_list    #http://help.fortinet.com/fos60hlp/62/index.htm#cshid=policy64_list    
${nat46_policy_help_href}    cshid=policy46_list    #http://help.fortinet.com/fos60hlp/62/index.htm#cshid=policy46_list     
${multicast_policy_help_href}    cshid=multicast_policy    #http://help.fortinet.com/fos60hlp/62/index.htm#cshid=multicast_policy   

${ipv4_policy_help_content}    Policy configuration
${ipv6_policy_help_content}    Policy configuration
${nat64_policy_help_content}    NAT64 policy     
${nat46_policy_help_content}    NAT46 policy     
${multicast_policy_help_content}    Example: Multicast Address 

*** Test Cases ***
858401
    [Documentation]    
    [Tags]    chrome    858401    medium
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Verfiy help link works on ipv4 policy 
    Log    ==================== Step 1: Verify help link works on ipv4 policy ====================
    Go to IPv4 policy   
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V4_POLICY_ID_1}
    Verify Help Link in Gutter Area    ${ipv4_policy_help_href} 
    Click Help Link And Check Display    ${ipv4_policy_help_href}    ${ipv4_policy_help_content}
    Click Cancel Button on Policy Editor   

#Step 2: Verify help link works on ipv6 policy 
    Log    ==================== Step 2: Verify help link works on ipv6 policy ====================
    Go to IPv6 policy   
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_V6_POLICY_ID_1}
    Verify Help Link in Gutter Area    ${ipv6_policy_help_href} 
    Click Help Link And Check Display    ${ipv6_policy_help_href}    ${ipv6_policy_help_content}
    Click Cancel Button on Policy Editor 

#Step 3: Verify help link works on policy64
    Log    ==================== Step 3: Verify help link works on policy64 ====================
    Go to NAT64 policy   
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_POLICY64_ID_1}
    Verify Help Link in Gutter Area    ${nat64_policy_help_href} 
    Click Help Link And Check Display    ${nat64_policy_help_href}    ${nat64_policy_help_content}
    Click Cancel Button on Policy Editor 

#Step 4: Verify help link works on policy46
    Log    ==================== Step 4: Verify help link works on policy46 ====================
    Go to NAT46 policy   
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_POLICY46_ID_1}
    Verify Help Link in Gutter Area    ${nat46_policy_help_href} 
    Click Help Link And Check Display    ${nat46_policy_help_href}    ${nat46_policy_help_content}
    Click Cancel Button on Policy Editor 

#Step 5: Verify help link works on multicast policy
    Log    ==================== Step 5: Verify help link works on multicast policy ====================    
    Go to Multicast policy   
    View By Sequence
    Edit Policy By ID on Policy list    ${FW_TEST_MULTICAST_POLICY_ID_1}
    Verify Help Link in Gutter Area    ${multicast_policy_help_href} 
    Click Help Link And Check Display    ${multicast_policy_help_href}    ${multicast_policy_help_content}
    Click Cancel Button on Policy Editor 

    Logout FortiGate

*** Keywords ***
Verify Help Link in Gutter Area
    [Arguments]   ${href_pattern}
    Wait Until Element Is Visible    ${POLICY_GUTTER_AREA}
    Wait Until Element Is Visible    ${POLICY_GUTTER_HELP_LINK}
    ${full_href}=    Get Element Attribute    ${POLICY_GUTTER_HELP_LINK}    href    
    Should Contain    ${full_href}    ${href_pattern} 

Click Help Link And Check Display
    [Arguments]   ${href_pattern}    ${help_pattern}
    ${help_window}=    Get Window Handles           
    Click Link    ${POLICY_GUTTER_HELP_LINK}
    ${ori_window}=    Select Window    ${help_window}
    ${url}=    Get Location
    Should Contain    ${url}    ${href_pattern}
    Wait Until Element Is Visible    ${POLICY_HELP_LINK_CONTENT}
    Wait Until Element Contains    ${POLICY_HELP_LINK_H}    ${help_pattern}
    Close Window
    Select Window    ${ori_window}   


case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
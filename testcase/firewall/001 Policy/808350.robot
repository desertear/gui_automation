*** Settings ***
Documentation    Verify shortcut to "Edit in CLI" work for objects (M262852)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${edit_in_cli_button}    Edit in CLI

#copy policy config from 808350_setup_cli.txt
@{ipv4_policy_config}    ${FGT_HOSTNAME} # config vdom
...    ${FGT_HOSTNAME} (vdom) # edit ${FW_TEST_VDOM_NAME_1} 
...    ${FGT_HOSTNAME} (${FW_TEST_VDOM_NAME_1}) # config firewall policy
...    ${FGT_HOSTNAME} (policy) # edit "${FW_TEST_V4_POLICY_ID_1}"
...    ${FGT_HOSTNAME} (${FW_TEST_V4_POLICY_ID_1}) # show
...    config firewall policy
...    edit ${FW_TEST_V4_POLICY_ID_1}
...        set srcintf "${FW_TEST_INTF_2}"
...        set dstintf "${FW_TEST_INTF_1}"
...        set srcaddr "${FW_TEST_ADDR_1}"
...        set dstaddr "${FW_TEST_ADDR_ALL}"
...        set action accept                
...        set schedule "${FW_TEST_SCHEDULE_ALWAYS}"
...        set service "${FW_TEST_SERVICE_ALL}"
...        set nat enable                
...        set utm-status enable
...        set av-profile "${FW_TEST_UTM_G_DEFAULT}"
...        set logtraffic all
...    next
...    end
...    ${FGT_HOSTNAME} (${FW_TEST_V4_POLICY_ID_1}) #

#copy policy config from 808350_setup_cli.txt
@{ipv6_policy_config}    ${FGT_HOSTNAME} # config vdom
...    ${FGT_HOSTNAME} (vdom) # edit ${FW_TEST_VDOM_NAME_1} 
...    ${FGT_HOSTNAME} (${FW_TEST_VDOM_NAME_1}) # config firewall policy6
...    ${FGT_HOSTNAME} (policy6) # edit "${FW_TEST_V6_POLICY_ID_1}"
...    ${FGT_HOSTNAME} (${FW_TEST_V6_POLICY_ID_1}) # show
...    config firewall policy6
...    edit ${FW_TEST_V6_POLICY_ID_1}
...        set srcintf "${FW_TEST_INTF_2}"
...        set dstintf "${FW_TEST_INTF_1}"
...        set srcaddr "${FW_TEST_ADDR6_1}"
...        set dstaddr "${FW_TEST_ADDR6_ALL}"
...        set action accept                
...        set schedule "${FW_TEST_SCHEDULE_ALWAYS}"
...        set service "${FW_TEST_SERVICE_ALL}"
...        set nat enable                
...        set utm-status enable
...        set webfilter-profile "${FW_TEST_UTM_G_DEFAULT}"
...    next
...    end
...    ${FGT_HOSTNAME} (${FW_TEST_V6_POLICY_ID_1}) #

#copy address config from fw_setup_cli.txt
@{address_config}    ${FGT_HOSTNAME} # config vdom
...    ${FGT_HOSTNAME} (vdom) # edit ${FW_TEST_VDOM_NAME_1} 
...    ${FGT_HOSTNAME} (${FW_TEST_VDOM_NAME_1}) # config firewall address
...    ${FGT_HOSTNAME} (address) # edit "${FW_TEST_ADDR_1}"
#...    ${FGT_HOSTNAME} (${FW_TEST_ADDR_1}) # show        comment because address name is too long to be shown in full
...    config firewall address
...        edit "${FW_TEST_ADDR_1}"
...            set type iprange
...            set start-ip 10.1.100.6
...            set end-ip 10.1.100.10
...        next
...    end
#...    ${FGT_HOSTNAME} (${FW_TEST_ADDR_1}) #        comment because address name is too long to be shown in full

@{service_config}    ${FGT_HOSTNAME} # config vdom
...    ${FGT_HOSTNAME} (vdom) # edit ${FW_TEST_VDOM_NAME_1} 
...    ${FGT_HOSTNAME} (${FW_TEST_VDOM_NAME_1}) # config firewall service custom
...    ${FGT_HOSTNAME} (custom) # edit "ALL"
...    ${FGT_HOSTNAME} (ALL) # show
...    config firewall service custom
...        edit "ALL"
...            set category "General"
...            set protocol IP
...        next
...    end
...    ${FGT_HOSTNAME} (ALL) #

@{schedule_config}    ${FGT_HOSTNAME} # config vdom
...    ${FGT_HOSTNAME} (vdom) # edit ${FW_TEST_VDOM_NAME_1} 
...    ${FGT_HOSTNAME} (${FW_TEST_VDOM_NAME_1}) # config firewall schedule recurring
...    ${FGT_HOSTNAME} (recurring) # edit "always"
...    config firewall schedule recurring
...        edit "always"
...            set day sunday monday tuesday wednesday thursday friday saturday
...        next
...    end
...    ${FGT_HOSTNAME} (always) #

@{shaper_config}    ${FGT_HOSTNAME} # config vdom
...    ${FGT_HOSTNAME} (vdom) # edit ${FW_TEST_VDOM_NAME_1} 
...    ${FGT_HOSTNAME} (${FW_TEST_VDOM_NAME_1}) # config firewall shaper traffic-shaper
...    ${FGT_HOSTNAME} (traffic-shaper) # edit "${FW_TEST_SHAPER_SHARED_DEFAULT_1}"
...    ${FGT_HOSTNAME} (${FW_TEST_SHAPER_SHARED_DEFAULT_1}) # show
...    config firewall shaper traffic-shaper
...        edit "${FW_TEST_SHAPER_SHARED_DEFAULT_1}"
...            set maximum-bandwidth 1024
...        next
...    end
...    ${FGT_HOSTNAME} (${FW_TEST_SHAPER_SHARED_DEFAULT_1}) #

@{shaping_policy_config}    ${FGT_HOSTNAME} # config vdom
...    ${FGT_HOSTNAME} (vdom) # edit ${FW_TEST_VDOM_NAME_1} 
...    ${FGT_HOSTNAME} (${FW_TEST_VDOM_NAME_1}) # config firewall shaping-policy
...    ${FGT_HOSTNAME} (shaping-policy) # edit "${FW_TEST_SHAPING_POLICY_ID_1}"
...    ${FGT_HOSTNAME} (${FW_TEST_SHAPING_POLICY_ID_1}) # show
...    config firewall shaping-policy
...        edit "${FW_TEST_SHAPING_POLICY_ID_1}"
...            set srcaddr "${FW_TEST_ADDR_ALL}"
...            set dstaddr "${FW_TEST_ADDR_ALL}"
...            set service "${FW_TEST_SERVICE_ALL}"
...            set dstintf "${FW_TEST_INTF_2}"
...        next
...    end
...    ${FGT_HOSTNAME} (${FW_TEST_SHAPING_POLICY_ID_1}) #

*** Test Cases ***
808350
    [Documentation]    
    [Tags]    chrome    808350    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
        
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects    

#Step 1: Verify "Edit in CLI" works on ipv4 Policy 
    Log    ==================== Step 1: Verify "Edit in CLI" works on ipv4 Policy ====================
    Go to IPv4 policy   
    View By Sequence
    Right Click Policy By ID on Policy List    ${FW_TEST_V4_POLICY_ID_1}
    Click Button in Context Menu    ${edit_in_cli_button}
    Verify Display in Embed Console    ${ipv4_policy_config}

#Step 2: Verify "Edit in CLI" works on ipv6 Policy 
    Log    ==================== Step 2: Verify "Edit in CLI" works on ipv6 Policy ====================
    Go to IPv6 policy   
    View By Sequence
    Right Click Policy By ID on Policy List    ${FW_TEST_V6_POLICY_ID_1}
    Click Button in Context Menu    ${edit_in_cli_button}
    Verify Display in Embed Console    ${ipv6_policy_config}


#Step 3: Verify "Edit in CLI" works on Address 
    Log    ==================== Step 3: Verify "Edit in CLI" works on Address ====================
    Go to Addresses
    Open Section Label on Address List    Address
    Right Click Address on Address List    ${FW_TEST_ADDR_1}
    Click Button    ${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI}
    Verify Display in Embed Console    ${address_config}
#Step 4: Verify "Edit in CLI" works on Service 
    Log    ==================== Step 4: Verify "Edit in CLI" works on Service ====================
    Go to Services
    Open Section Label on Service List    General
    Right Click Service on Service List    ALL
    Click Button    ${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI}
    Verify Display in Embed Console    ${service_config}  

#Step 5: Verify "Edit in CLI" works on Schedule 
    Log    ==================== Step 5: Verify "Edit in CLI" works on Schedule ====================
    Go to Schedules
    Right Click Schedule on Schedule List    always
    Select Frame    ${POLICY_OBJECT_FRAME}
    Click Button    ${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI}      
    Unselect Frame
    Verify Display in Embed Console    ${schedule_config}

#Step 6: Verify "Edit in CLI" works on Traffic Shaper 
    Log    ==================== Step 6: Verify "Edit in CLI" works on Traffic Shaper ====================
    Go to Traffic Shaper
    Right Click Traffic Shaper on Shaper list    ${FW_TEST_SHAPER_SHARED_DEFAULT_1}
    Select Frame    ${POLICY_OBJECT_FRAME}
    Click Button    ${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI}      
    Unselect Frame
    Verify Display in Embed Console    ${shaper_config}   
    
#Step 7: Verify "Edit in CLI" works on Traffic Shaping Policy 
    Log    ==================== Step 7: Verify "Edit in CLI" works on Traffic Shaping Policy ====================
    Go to Shaping policy
    Open Shaping Policy Section
    Right Click Traffic Shaping Policy by ID    ${FW_TEST_SHAPING_POLICY_ID_1}
    Click Button    ${POLICY_CONTEXT_MENU_BUTTON_EDIT_IN_CLI}  
    Verify Display in Embed Console    ${shaping_policy_config}                  
    ##move mouse to remove tooltip
    Mouse Over    ${PLTF_TYPE_DIV}
    Logout FortiGate

*** Keywords ***



case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
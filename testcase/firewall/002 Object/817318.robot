*** Settings ***
Documentation    Verify color configured for firewall objects visible on object list page and policy list page
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
*** Test Cases ***
817318
    [Documentation]
    [Tags]    chrome    817318    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: color is shown on address page
    Log    ==================== Step 1: color is shown on address page ====================
    Go to Addresses
    Open Section Label on Address List    Address
    Verify Color by Class    ${FW_TEST_ADDR_1}    ftnt-color-2    Service
    Verify Color by Class    ${FW_TEST_ADDR_2}    ftnt-color-3    Service
    Verify Color by Class    ${FW_TEST_ADDR_3}    ftnt-color-4    Service
    Verify Color by Class    ${FW_TEST_ADDR_4}    ftnt-color-5    Service
    Close Section Label on Address List    Address    
    
    Open Section Label on Address List    Address Group
    Verify Color by Class    ${FW_TEST_ADDR_GROUP_1}    ftnt-color-6    Service
    Close Section Label on Address List    Address Group

    Open Section Label on Address List    IPv6 Address
    Verify Color by Class    ${FW_TEST_ADDR6_1}    ftnt-color-9    Service
    Verify Color by Class    ${FW_TEST_ADDR6_2}    ftnt-color-10    Service
    Verify Color by Class    ${FW_TEST_ADDR6_3}    ftnt-color-11    Service
    Verify Color by Class    ${FW_TEST_ADDR6_4}    ftnt-color-12    Service
    Close Section Label on Address List    IPv6 Address

    Open Section Label on Address List    IPv6 Address Group
    Verify Color by Class    ${FW_TEST_ADDR6_GROUP_1}    ftnt-color-13    Service
    Close Section Label on Address List    IPv6 Address Group

# Step 2: color is shown on service page
    Log    ==================== Step 2: color is shown on service page ====================
    Go to Services
    Open Section Label on Service List    Uncategorized
    Verify Color by Class    ${FW_TEST_SERVICE_1}    ftnt-color-27    Service
    Close Section Label on Service List    Uncategorized

    Open Section Label on Service List    Firewall Group    
    Verify Color by Class    ${FW_TEST_SERVICE_GROUP_1}    ftnt-color-32    Service
    Close Section Label on Service List    Uncategorized

# Step 3: color is shown on schedule page
    Log    ==================== Step 3: color is shown on schedule page ====================
    Go to Schedules
    Select Frame    ${POLICY_OBJECT_FRAME}
    Verify Color by Class    ${FW_TEST_SCHEDULE_1}    ftnt-color-16    Schedule  
    Verify Color by Class    ${FW_TEST_SCHEDULE_ONE_TIME_1}    ftnt-color-17    Schedule
    Verify Color by Class    ${FW_TEST_SCHEDULE_GROUP_1}    ftnt-color-18    Schedule
    Unselect Frame
    
# Step 4: color is shown on vip page
    Log    ==================== Step 4: color is shown on vip46 page ====================
    Go to Virtual IP
    Open Section Label on VIP List    IPv4 Virtual IP   
    Verify Color by Class    ${FW_TEST_VIP_1}    ftnt-color-19    VIP
    Open Section Label on VIP List    IPv6 Virtual IP   
    Verify Color by Class    ${FW_TEST_VIP6_1}    ftnt-color-20    VIP 
    Open Section Label on VIP List    NAT46 Virtual IP   
    Verify Color by Class    ${FW_TEST_VIP46_1}    ftnt-color-21    VIP 
    Open Section Label on VIP List    NAT64 Virtual IP   
    Verify Color by Class    ${FW_TEST_VIP64_1}    ftnt-color-22    VIP    
    
    Open Section Label on VIP List    IPv4 Virtual IP Group   
    Verify Color by Class    ${FW_TEST_VIP_GROUP_1}    ftnt-color-23    VIP 
    Open Section Label on VIP List    IPv6 Virtual IP Group  
    Verify Color by Class    ${FW_TEST_VIP6_GROUP_1}    ftnt-color-24    VIP 
    Open Section Label on VIP List    NAT46 Virtual IP Group   
    Verify Color by Class    ${FW_TEST_VIP46_GROUP_1}    ftnt-color-25    VIP 
    Open Section Label on VIP List    NAT64 Virtual IP Group   
    Verify Color by Class    ${FW_TEST_VIP64_GROUP_1}    ftnt-color-26    VIP

# Step 5: color is shown on ipv4 policy page
    Go to IPv4 policy  
    View By Sequence    
    Verify Color by Class    ${FW_TEST_ADDR_1}    ftnt-color-2    Policy List
    Verify Color by Class    ${FW_TEST_ADDR_GROUP_1}    ftnt-color-6    Policy List
    Verify Color by Class    ${FW_TEST_SCHEDULE_ONE_TIME_1}    ftnt-color-17    Policy List
    Verify Color by Class    ${FW_TEST_SERVICE_1}    ftnt-color-27    Policy List

# Step 6: color is shown on ipv6 policy page
    Go to IPv6 policy  
    View By Sequence  
    Verify Color by Class    ${FW_TEST_ADDR6_1}    ftnt-color-9    Policy List
    Verify Color by Class    ${FW_TEST_ADDR6_GROUP_1}    ftnt-color-13    Policy List
    Verify Color by Class    ${FW_TEST_SCHEDULE_GROUP_1}    ftnt-color-18    Policy List
    Verify Color by Class    ${FW_TEST_SERVICE_GROUP_1}    ftnt-color-32    Policy List  


    Logout FortiGate

*** Keywords ***

case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

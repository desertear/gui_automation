*** Settings ***
Documentation    Verify icons of firewall objects shown properly when displayed on GUI
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
*** Test Cases ***
702399
    [Documentation]
    [Tags]    chrome    702399    high
    [Teardown]    case Teardown

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

# Step 1: icon is shown on address page
    Log    ==================== Step 1: icon is shown on address page ====================
    Go to Addresses
    Open Section Label on Address List    Address
    Verify Icon by Class    ${FW_TEST_ADDR_1}    ftnt-address-iprange    Address
    Verify Icon by Class    ${FW_TEST_ADDR_2}    ftnt-address-geo    Address
    Verify Icon by Class    ${FW_TEST_ADDR_3}    ftnt-address-fqdn    Address
    Verify Icon by Class    ${FW_TEST_ADDR_4}    ftnt-address${SPACE}    Address
    Close Section Label on Address List    Address    
    
    Open Section Label on Address List    Address Group
    Verify Icon by Class    ${FW_TEST_ADDR_GROUP_1}    ftnt-address-group    Address
    Close Section Label on Address List    Address Group

    Open Section Label on Address List    IPv6 Address
    Verify Icon by Class    ${FW_TEST_ADDR6_1}    ftnt-address-ipv6    Address
    Verify Icon by Class    ${FW_TEST_ADDR6_2}    ftnt-address-ipv6    Address
    Verify Icon by Class    ${FW_TEST_ADDR6_3}    ftnt-address-ipv6    Address
    Verify Icon by Class    ${FW_TEST_ADDR6_4}    ftnt-address-ipv6    Address
    Close Section Label on Address List    IPv6 Address

    Open Section Label on Address List    IPv6 Address Group
    Verify Icon by Class    ${FW_TEST_ADDR6_GROUP_1}    ftnt-address-group    Address
    Close Section Label on Address List    IPv6 Address Group

    Open Section Label on Address List    IPv6 Address Template
    Verify Icon by Class    ${FW_TEST_ADDR6_TEMPLATE_1}    fa-file-text    Address
    Close Section Label on Address List    IPv6 Address Template

# Step 2: icon is shown on service page
    Log    ==================== Step 2: icon is shown on service page ====================
    Go to Services
    Open Section Label on Service List    Uncategorized
    Verify Icon by Class    ${FW_TEST_SERVICE_1}    ftnt-service${SPACE}    Service
    Close Section Label on Service List    Uncategorized

    Open Section Label on Service List    Firewall Group    
    Verify Icon by Class    ${FW_TEST_SERVICE_GROUP_1}    ftnt-service-group    Service
    Close Section Label on Service List    Uncategorized

# Step 3: icon is shown on schedule page
    Log    ==================== Step 3: icon is shown on schedule page ====================
    Go to Schedules
    Select Frame    ${POLICY_OBJECT_FRAME}
    Verify Icon by Class    ${FW_TEST_SCHEDULE_1}    ftnt-schedule-recurring    Schedule  
    Verify Icon by Class    ${FW_TEST_SCHEDULE_ONE_TIME_1}    ftnt-schedule${SPACE}    Schedule
    Verify Icon by Class    ${FW_TEST_SCHEDULE_GROUP_1}    ftnt-schedule-group    Schedule
    Unselect Frame

# Step 4: icon is shown on wildcard FQDN page
    Log    ==================== Step 4: icon is shown on wildcard FQDN page ====================
    Go to Wildcard FQDN Address
    Open Section Label on Wildcard FQDN Address List    Wildcard FQDN
    Verify Icon by Class    ${FW_TEST_W_FQDN_FORTINET}    ftnt-address-global-wildcard-fqdn    Wildcard FQDN  
    Close Section Label on Wildcard FQDN Address List    Wildcard FQDN
    Open Section Label on Wildcard FQDN Address List    Wildcard FQDN Group
    Verify Icon by Class    ${FW_TEST_W_FQDN_GROUP_1}    ftnt-address-wildcard-fqdn    Wildcard FQDN
    Close Section Label on Wildcard FQDN Address List    Wildcard FQDN Group

    
# Step 5: icon is shown on vip page
    Log    ==================== Step 5: icon is shown on vip46 page ====================
    Go to Virtual IP
    Open Section Label on VIP List    IPv4 Virtual IP   
    Verify Icon by Class    ${FW_TEST_VIP_1}    ftnt-virtual-ip    VIP
    Open Section Label on VIP List    IPv6 Virtual IP   
    Verify Icon by Class    ${FW_TEST_VIP6_1}    ftnt-virtual-ip    VIP 
    Open Section Label on VIP List    NAT46 Virtual IP   
    Verify Icon by Class    ${FW_TEST_VIP46_1}    ftnt-virtual-ip    VIP 
    Open Section Label on VIP List    NAT64 Virtual IP   
    Verify Icon by Class    ${FW_TEST_VIP64_1}    ftnt-virtual-ip    VIP    
    
    Open Section Label on VIP List    IPv4 Virtual IP Group   
    Verify Icon by Class    ${FW_TEST_VIP_GROUP_1}    ftnt-virtual-ip-group    VIP 
    Open Section Label on VIP List    IPv6 Virtual IP Group  
    Verify Icon by Class    ${FW_TEST_VIP6_GROUP_1}    ftnt-virtual-ip-group    VIP 
    Open Section Label on VIP List    NAT46 Virtual IP Group   
    Verify Icon by Class    ${FW_TEST_VIP46_GROUP_1}    ftnt-virtual-ip-group    VIP 
    Open Section Label on VIP List    NAT64 Virtual IP Group   
    Verify Icon by Class    ${FW_TEST_VIP64_GROUP_1}    ftnt-virtual-ip-group    VIP

    Logout FortiGate

*** Keywords ***


case Teardown
    write test result to file    ${CURDIR}

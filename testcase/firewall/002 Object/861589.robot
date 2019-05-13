*** Settings ***
Documentation    Verify default wildcard-fqdn objects move to Wildcard FQDN Addresses page from Addresses page (M434904)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
@{wildfqdn_list_in_address}    wildcard.dropbox.com    wildcard.google.com
*** Test Cases ***
861589
    [Documentation]
    [Tags]    chrome    861589    Medium
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
# Step 1: test only two wildcard fqdn in firewall.address is shown on address page
    Log    ==================== Step 1: test only two wildcard fqdn is shown on address page ====================
    go to Addresses
    :FOR   ${element}   IN   @{wildfqdn_list_in_address}
    \    ${exist}=    if address exists  ${element}  Wildcard FQDN
    \    should be equal   "${exist}"   "True"
# Step 2: test default wild fqdn address is shown on wildcard fqdn page
    Log    ==================== Step 2: test default wild fqdn address is shown on wildcard fqdn page ====================
    Go to Wildcard FQDN Address
    ${wildfqdn_list_in_wildcard_fqdn}=    get wildcard fqdn list from cli
    :FOR   ${element}   IN   @{wildfqdn_list_in_wildcard_fqdn}
    \    ${exist}=    if address exists   ${element}   Wildcard FQDN
    \    should be equal   "${exist}"   "True"
    Logout FortiGate

*** Keywords ***
case Teardown
    Close all browsers
    write test result to file    ${CURDIR}

    
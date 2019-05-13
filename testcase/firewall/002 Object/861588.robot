*** Settings ***
Documentation    Verify wildcard-fqdn object created from firewall.address only can be displayed on Addresses page (M434904)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${test_wildfqdn_name}    wildcard.861588.net
${test_wildfqdn_domain}    *.861588.net
*** Test Cases ***
861588
    [Documentation]
    [Tags]    chrome    861588    Medium
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects
# Step 1: test wildcard fqdn created from firewall.address is shown on address page
    Log    ==================== Step 1: test wildcard fqdn is shown on address page ====================
    go to Addresses
    ${exist}=    if address exists  ${test_wildfqdn_name}  Wildcard FQDN
    should be equal   "${exist}"   "True"
# Step 2: test wild fqdn address created from firewall.address isn't shown on wildcard fqdn page
    Log    ==================== Step 2: test wild fqdn address isn't shown on wildcard fqdn page ====================
    Go to Wildcard FQDN Address
    ${exist}=    if address exists   ${test_wildfqdn_name}   Wildcard FQDN
    should be equal   "${exist}"   "False"
    Logout FortiGate

*** Keywords ***
case Teardown
    Close all browsers
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

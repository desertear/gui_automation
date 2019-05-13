*** Settings ***
Documentation    Verify the reference entries can list in column filter and the most common values will always be on top (M504474)
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
873661
    [Documentation]    
    [Tags]    chrome    873661    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    ##################Check IPV4 Policy#################
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    ####Get Filter Text from To Column####
    ${filter_text}=    Get Filter Text from Policy Filter by Order Number    To    1
    Should be Equal    ${filter_text}    ${FW_TEST_INTF_1}
    ${filter_text}=    Get Filter Text from Policy Filter by Order Number    To    2
    Should be Equal    ${filter_text}    ${FW_TEST_INTF_2}
    ${filter_text}=    Get Filter Text from Policy Filter by Order Number    To    3
    Should be Equal    ${filter_text}    any
    ##################Check IPV6 Policy#################
    Go to policy and objects
    Go to IPv6 policy
    View By Sequence
    ####Get Filter Text from From Column####
    ${filter_text}=    Get Filter Text from Policy Filter by Order Number    From    1
    Should be Equal    ${filter_text}    ${FW_TEST_INTF_2}
    ${filter_text}=    Get Filter Text from Policy Filter by Order Number    From    2
    Should be Equal    ${filter_text}    ipsec
    ${filter_text}=    Get Filter Text from Policy Filter by Order Number    From    3
    Should be Equal    ${filter_text}    SSL-VPN tunnel interface (ssl.${FW_TEST_VDOM_NAME_1})
    Logout FortiGate
 
*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
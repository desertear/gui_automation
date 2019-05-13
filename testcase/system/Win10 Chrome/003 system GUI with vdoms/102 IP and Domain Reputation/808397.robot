*** Settings ***
Documentation   Database: Verify searching entry from Trusted host works
Resource    ../../../system_resource.robot

*** Variables ***
@{trust_hosts_name}      fortinet.com    mail.fortinet.com
${trust_hosts}           *.fortinet.com
@{cmd}    config vdom    edit ${SYSTEM_TEST_VDOM_NAME_1}    config router static    show
*** Test Cases ***
808397
    [Documentation]    
    [Tags]    v6.0    chrome   808397    High     win10,64bit   runable   test06    env2fail
    login FortiGate
    go to vdom     ${SYSTEM_TEST_VDOM_NAME_1}
    Go to system
    go to system_feature visibility
    Enable_FGT_Feature_Additional   Reputation
    Enable_FGT_feature_noRC  Intrusion Prevention
    sleep   2
    go to system_feature visibility
    sleep    2
    Go to system
    Go to system_reputation
    @{resonse}=    Execute CLI commands on FortiGate Via Direct Telnet    ${cmd}
    :FOR     ${element}    IN     @{trust_hosts_name} 
        \    wait and click       ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
        \    clear element text   ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT} 
        \    input text    ${SYSTEM_REPUTATION_IP_DOMAIN_INPUT}     ${element}
        \    sleep   1
        \    ${new_locator}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_REPUTATION_URL_TRUST}    ${trust_hosts} 
        \    Wait Until Element Is Visible     ${new_locator}
    [Teardown]    Case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}
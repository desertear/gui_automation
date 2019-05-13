*** Settings ***
Documentation    Verify that APP custom signatures can be created/deleted on Custom Application page
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${custom_signature_name}    AirVantage
${custom_signature_signature}    F-SBID( --attack_id 6238; --name airvantage; --dst_addr [172.16.200.216]; --dst_port 80:80; --app_cat 29; )


*** Test Cases ***
833625
    [Documentation]    
    [Tags]    6.2.0    application    chrome    833625    high    win10    norun

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    Create New Custom Signatures  ${custom_signature_name}  ${custom_signature_signature}
    Delete New Custom Signatures

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
write test result to file    ${CURDIR}
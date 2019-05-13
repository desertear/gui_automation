*** Settings ***
Documentation    Verify custom signature can be deleted
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${custom_signature_name}    gui-test
${custom_signature_sig}  F-SBID( --name \"gui-test\"; --attack_id 6406; --severity low; --protocol tcp; --pattern \"ABCDEFG\";)
    
*** Test Cases ***
205785
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205785    high    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create New Custom Signature
    Create New IPS Custom Signatures    ${custom_signature_name}    ${custom_signature_sig}
    Wait Until Element is Visible    ${CUSTOM_SIGNATURE_EDIT_VERIFY}    
    Delete New Custom Signatures


    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}
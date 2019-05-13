*** Settings ***
Documentation    Verify custom signature can be deleted
Resource    ../ips_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${custom_signature_name1}    gui-test1
${custom_signature_name2}    gui-test2
${custom_signature_sig1}  F-SBID( --name \"gui-test1\"; --attack_id 6406; --severity low; --protocol tcp; --pattern \"ABCDEFG\";)
${custom_signature_sig2}  F-SBID( --name \"gui-test2\"; --attack_id 6407; --severity low; --protocol tcp; --pattern \"ABCDEFG\";)
    
*** Test Cases ***
205784
    [Documentation]    
    [Tags]    6.2.0    ips    chrome    205784    high    win10    runable

    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Create New Custom Signature
    Create New IPS Custom Signatures    ${custom_signature_name1}    ${custom_signature_sig1}
    Wait Until Element is Visible    xpath://td[@class="q_origin_key"]  

    #Edit Custom Signature
    Edit IPS Custom Signatures Signature    ${custom_signature_sig2} 
    Wait Until Element is Visible    xpath://td[@class="q_origin_key"]  

    #Verify edits were saved
    Wait Until Element is Visible    xpath://div[contains(text(),"ID: 6407")]

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Delete New Custom Signatures
    Logout FortiGate
    write test result to file    ${CURDIR}
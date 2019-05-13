*** Settings ***
Documentation    Verify generate the 2048 bit certificate Local Certificates  GUI
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
730712
    [Documentation]    
    [Tags]    chrome    730712    high
    # [Teardown]    case Teardown
    Login FortiGate
    Go to system
    Go to Certificates
    ${units}=    create list    FOS-QA
    Generate Certificate Signing Request    test_certificate    Host IP    1.1.1.1
    ...    ${units}    Fortinet    Burnaby    BC    Canada    xyan@fortinet.com
    ...    IP:172.16.200.1    123456    RSA    1536 Bit
    Download Certificate    test_certificate    C:${/}Users${/}fosqa${/}Downloads
    Delete Certificate  test_certificate
    Logout FortiGate
    
*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
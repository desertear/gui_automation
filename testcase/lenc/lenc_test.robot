*** Settings ***
Documentation    LENC testing file
Resource    ./lenc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Test Cases ***
lenc_test
    [Documentation]    
    [Tags]    lenc_test
    # Burn Image on BIOS     10.6.30.55    10.6.30.1    FGT_301E-v6-build0221-FORTINET.out
    # Burn Image on BIOS     10.6.30.55    10.6.30.1    FGT_300D-v6-build0792-FORTINET.out
    Login FortiGate
    sleep    5s
    Logout FortiGate

*** Settings ***
Documentation   failcase!  bug #0521674
...             Verify LLDP settings are applied from the GUI 
Resource    ../../../system_resource.robot

*** Variables ***

@{list}         vdom    enable   disable 
*** Test Cases ***
875405
    [Documentation]    
    [Tags]    Failcase!Bug#0521674   v6.0    chrome   875405    High    win10,64bit    runable    env2fail
    login FortiGate
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1} 
    Go to network
    Go to network_Interfaces
    :FOR   ${element}   IN    @{list}
        \  network edit interface      ${SYSTEM_TEST_INTF_3}
        \  sleep   2
        \  select radio button   lldp-reception      ${element}
        \  select radio button   lldp-transmission   ${element}
        \  wait and click   ${SUBMIT_OK_BUTTON}
        \  unselect frame
        \  network edit interface      ${SYSTEM_TEST_INTF_3}
        \  sleep   2
        \  radio button should be set to  lldp-reception   ${element}
        \  radio button should be set to   lldp-transmission   ${element}
        \  wait and click   ${SUBMIT_OK_BUTTON}
        \  unselect frame
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

   


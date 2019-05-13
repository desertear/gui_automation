*** Settings ***
Documentation    Verify feature store default is UTM for 200 and below, which include antivirus/IPS&app-control/FortiClient/webfilter
Resource    ../../../system_resource.robot

*** Variables ***
@{feature_list}    AntiVirus    Application Control    DNS Filter    Endpoint Control    Intrusion Prevention    Web Filter
*** Test Cases ***
771120
    [Tags]    v6.0    chrome   771120    High    win10,64bit    browsers    runable   rest
    
    Login FortiGate     
    sleep   2
    Go To Vdom     ${SYSTEM_TEST_VDOM_NAME_1}   
    Go to system
    go to system_feature visibility
    :FOR     ${element}    IN    @{feature_list}
        \    ${new_label}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_FEATURE_VIS_LABEL}     ${element}
        \    ${new_status}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_FEATURE_VIS_STATUS}    ${element}
        \    ${new_button}=   REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_FEATURE_VIS_BUTTON}    ${element}
        \    wait Until Element Is Visible   ${new_label}
        \    ${already_enabled}=    Run keyword and return status    Checkbox Should Be Selected  ${new_status}    
        \    Run keyword if     "${already_enabled}"=="False"    Click Element   ${new_button}  
    Click Element   ${system_feature_vis_apply_button}

    sleep    2
    Go to Security Profiles
    wait and click    ${Security Profile_Antivirus_menu_bar}
    sleep  1
    select frame    ${Security Profile_infoframe} 
    Wait Until Element Is Visible     ${SECURITY PROFILE_CREATE_NEW_BUTTON}
    Unselect Frame
    
    wait and click    ${Security Profile_Web Filter_menu_bar} 
    sleep  1     
    Wait Until Element Is Visible     ${SECURITY PROFILE_CREATE_NEW_BUTTON}
    Unselect Frame

    wait and click    ${Security Profile_IPS_menu_bar} 
    sleep  1
    select frame    ${Security Profile_infoframe} 
    Wait Until Element Is Visible     ${SECURITY PROFILE_CREATE_NEW_BUTTON}
    Unselect Frame

    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

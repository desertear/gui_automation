*** Settings ***
Documentation    Verify the " admin password " must be entered as duplicates,GUI
Resource    ../fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***

*** Test Cases ***
730566
    [Documentation]    
    [Tags]    chrome    730566    high
    [Teardown]    case Teardown
    Login FortiGate
    Go to system
    ${vdom1}=    create list   ${FIPSCC_TEST_VDOM_NAME_1}
    #use all digits as password
    Go to System_administrators
    wait and click    ${system_administrators_create new}
    ${admin_menu_bar}=    REPLACE PLACEHOLDER IN LOCATOR WITH VALUE    ${SYSTEM_ADMINISTRATORS_CREATE_ADMINISTRATOR}    Administrator
    ##pop_up sometimes is not shown, and clicking "Create New" will go to edit page directly.
    ${if_pop_up}=    Run keyword and return status    Wait Until Element Is Visible     ${admin_menu_bar}
    Run keyword if    ${if_pop_up}    wait and click    ${admin_menu_bar}
    Wait Until Element Is Visible    ${system_administrators_edit_admin_password_confirm}
    Logout FortiGate
    
*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
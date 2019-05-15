*** Settings ***
Documentation    Verify GUI can create/edit/delete SSO-Admin (0546295/0542088)
Resource    ../../../system_resource.robot

*** Variables ***
${admin_type}    Single Sign-On Administrator
${admin_name}    890585
${admin_profile}    prof_admin
@{vdom}    ${SYSTEM_TEST_VDOM_NAME_1} 
${edit_profile}    admin_no_access
@{edit_vdom}   ${SYSTEM_TEST_VDOM_NAME_2}
@{all_vdom}    Global
*** Test Cases ***
890585
    [Tags]      v6.0    chrome   890585    high    win10,64bit    browsers    runable  test12
    Login FortiGate
    Go to system
    go to System_administrators
    Create SSO_ADMIN  ${admin_name}   admin_profile=${admin_profile}  vdom=${vdom}

    #########  edit admin without vdom shown
    EDIT ADMINISTRATOR  ${admin_name}  admin_type=${admin_type}
    change admin profile and vdom  admin_type=${admin_type}   profile=${edit_profile}   vdom=${edit_vdom}
    ## for admin_no_access, vdom should be global
    test if profile and vdom changed     ${admin_type}    ${admin_name}   ${edit_profile}   ${all_vdom}

    #########  change back to prof_admin, and change vdom
    EDIT ADMINISTRATOR  ${admin_name}  admin_type=${admin_type}
    change admin profile and vdom  ${admin_type}    ${admin_profile}   ${edit_vdom}
    test if profile and vdom changed  ${admin_type}  ${admin_name}   ${admin_profile}   ${edit_vdom}
    
    DELETE ADMINISTRATOR    ${admin_name}    admin_type=${admin_type}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate    
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}

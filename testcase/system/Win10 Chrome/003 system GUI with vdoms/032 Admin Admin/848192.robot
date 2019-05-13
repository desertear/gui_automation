*** Settings ***
Documentation    Verify Password Change will be prompted on GUI when admin login in the first time without initial password 
Resource    ../../../system_resource.robot

*** Variables ***
${username}    admin
${password}    ${EMPTY}
*** Test Cases ***
848192
    [Documentation]    
    [Tags]    v6.0    chrome   848192    High    win10,64bit   runable
    go to login page
    Run Keyword And Continue On Failure    input text      ${LOGIN_USERNAME_TEXT}    ${username}
    Run Keyword And Continue On Failure    input password  ${LOGIN_PASSWORD_TEXT}    ${password}
    Run Keyword And Continue On Failure    click button    ${LOGIN_LOGIN_BUTTON}
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    Wait Until Page Contains Element    ${FIPS_DISCLAIMER_HEAD}
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    click button    ${FIPS_ACCEPT_BUTTON}
    Wait Until Page Contains Element    ${PWD_CHANGE_HEAD}
    ${status}=    run keyword and return status     wait until Page Contains Element    ${PWD_CHANGE_LATER_BUTTON}
    should be equal    "${status}"    "True"
    click button    ${PWD_CHANGE_LATER_BUTTON}
    #Judge if warning of being managed by FortiManager device would be shown on GUI
    ${if_managed_by_fmg}=    run keyword and return status    Wait Until Page Contains Element    ${FMG_LOGIN_HEAD}
    run keyword if    "${if_managed_by_fmg}"=="True"    Run Keyword And Continue On Failure    click button    ${FMG_LOGIN_READ_WRITE_BUTTON}
    #Judge if warning of out-of-sync on FortiManager device would be shown on GUI
    ${out_of_sync_warning_fmg}=    run keyword and return status    Wait Until Page Contains Element    ${OUT_OF_SYNC_FMG_TEXT}
    run keyword if    "${out_of_sync_warning_fmg}"=="True"    Run Keyword And Continue On Failure    click button    ${OUT_OF_SYNC_FMG_YES_BUTTON}
    #Judge if warning of out-of-sync on FortiManager device would be shown on GUI
    ${forticare_registration_required}=    run keyword and return status    Wait Until Page Contains    FortiCare Registration Required
    run keyword if    "${forticare_registration_required}"=="True"    Run Keyword And Continue On Failure    click button    ${FORTICARE_REQUIRED_BUTTON}
    # Set Selenium Timeout    ${orig timeout}
    Run Keyword And Continue On Failure    Wait Until Keyword Succeeds    3x    2s    Element Text Should Be    ${PLTF_TYPE_DIV}    ${FGT_HW_TYPE}
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate  
    Close All Browsers
    write test result to file    ${CURDIR}


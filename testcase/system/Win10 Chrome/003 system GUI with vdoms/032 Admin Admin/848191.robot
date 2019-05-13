*** Settings ***
Documentation    Verify Password Change will be prompted on GUI when admin login in the first time without initial password 
Resource    ../../../system_resource.robot

*** Variables ***
${username}    admin
${password}    ${EMPTY}
*** Test Cases ***
848191
    [Documentation]    
    [Tags]    v6.0    chrome   848191    Critical    win10,64bit   runable
    go to login page
    Run Keyword And Continue On Failure    input text      ${LOGIN_USERNAME_TEXT}    ${username}
    Run Keyword And Continue On Failure    input password  ${LOGIN_PASSWORD_TEXT}    ${password}
    Run Keyword And Continue On Failure    click button    ${LOGIN_LOGIN_BUTTON}
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    Wait Until Page Contains Element    ${FIPS_DISCLAIMER_HEAD}
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    click button    ${FIPS_ACCEPT_BUTTON}
    Wait Until Page Contains Element    ${PWD_CHANGE_HEAD}
    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Close All Browsers
    write test result to file    ${CURDIR}


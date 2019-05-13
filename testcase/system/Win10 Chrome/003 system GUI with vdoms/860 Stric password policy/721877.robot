*** Settings ***
Documentation   GUI:Support admin users force-password-change feature
Resource    ../../../system_resource.robot

*** Variables ***
${username}    ${FGT_GUI_USERNAME}    
${password}    ${FGT_GUI_PASSWORD}
*** Test Cases ***
721877
    [Documentation]    
    [Tags]    v6.0    chrome   721877    High    win10,64bit      runable
    ######
    Open Browser       ${FGT_URL}    ${FGT_BROWSER}
    Set Window Size    ${SCREEN_SIZE_WIDTH}    ${SCREEN_SIZE_HEIGTH}
    Wait Until Element Is Visible    ${LOGIN_USERNAME_TEXT}
    input text         ${LOGIN_USERNAME_TEXT}  ${username}
    input password     ${LOGIN_PASSWORD_TEXT}  ${password}
    Run Keyword And Continue On Failure    click button    ${LOGIN_LOGIN_BUTTON}
    sleep  2
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    Wait Until Page Contains Element    ${FIPS_DISCLAIMER_HEAD}
    run keyword if    "${FGT_FIPS_CC_MODE}"=="True"    Run Keyword And Continue On Failure    click button    ${FIPS_ACCEPT_BUTTON}
    #Judge if warning of changing password would be shown on GUI
    Wait Until Page Contains Element    ${PWD_CHANGE_HEAD}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Close All Browsers
    write test result to file    ${CURDIR}


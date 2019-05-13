*** Settings ***
Documentation    Verify app DB and industrial DB information can be shown in GUI
Resource    ../app_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${fortiguard_entry}    xpath://span[@class='ng-binding'][contains(text(),"FortiGuard")]
${fortiguard_appDB}    xpath://td[contains(text(),"Application Control Signatures")]
${fortiguard_appDB_version}    xpath://tbody//tr[4]//td[2]
${fortiguard_industrialDB}    xpath://td[contains(text(),"Industrial DB")]
${fortiguard_industrialDB_version}    xpath://*[@id="ftgd-info"]/section[1]/f-entitlement-table/table/tbody/tr[19]/td[2]/f-entitlement-version-entry/span


*** Test Cases ***
821647
    [Documentation]    
    [Tags]    6.2.0    application    chrome    821647    high    win10    norun

    Login FortiGate
    Go to system
    Wait Until Element Is Visible    ${fortiguard_entry}
    click element    ${fortiguard_entry}
    Wait Until Element Is Visible    ${fortiguard_appDB}
    Wait Until Element Is Visible    ${fortiguard_appDB_version}
    Press Down Key
    Wait Until Element Is Visible    ${fortiguard_industrialDB}
    Wait Until Element Is Visible    ${fortiguard_industrialDB_version}

    [Teardown]    case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate
    write test result to file    ${CURDIR}
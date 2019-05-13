*** Settings ***
Documentation    Verify FGT sslvpn portals page predefined http bookmark could set "ssl-vpn login" SSO and work
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${https_url}    https://${FAC_IP}/login
${bookmark_name}   http_sso_591444
${bookmark_description}    automation test for bookmark ${bookmark_name}
${matching_text}    ${FAC_HEAD}
*** Test Cases ***
591444
    [Tags]    v6.0    chrome    firefox    edge    safari    591444    high    win10,64bit  
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    open and check http bookmark    ${bookmark_name}    ${matching_text}    if_predefined=${True}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
*** Settings ***
Documentation    Verify the SSL-VPN portal customize forticlient download via direct work (0437883)
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${portal_name}    testportal
${window_url}    qa-portal.corp.fortinet.com
${mac_url}    qa-portal.corp.fortinet.com
&{variables_dic_cli_file}    PORTAL_NAME=${portal_name}    WIN_URL=${window_url}    MAC_URL=${mac_url}
*** Test Cases ***
838537
    [Tags]    v6.0    firefox    chrome    edge    safari    838537    high    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt    &{variables_dic_cli_file}
    Login SSLVPN Portal
    #click "Download fortiClient" button
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_BUTTON}
    #record opened windows
    ${exclude}=    Get window handles
    #click "Windows" button
    click button    ${PORTAL_DOWNLOAD_FORTICLIENT_WINDOWS_BUTTON}
    #a new window is opened
    ${older_window}=    Select window    ${exclude}
    #check if url of the new window contains "forticlient.com", which means it opens Forticlient home page.
    ${url}=    Get Location
    should contain    ${url}    ${window_url}
    #close newer window
    close window
    #switch back to sslvpn portal
    [Teardown]    case Teardown    ${older_window}

*** Keywords ***
case Teardown
    [Arguments]    ${older_window}
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    &{variables_dic_cli_file}
    run keyword and ignore error    switch back to ssl vpn portal    ${older_window}
    write test result to file    ${CURDIR}
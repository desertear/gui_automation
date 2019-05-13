*** Settings ***
Documentation    Verify GUI can change http/https to other port and still work after change
Resource    ../../../system_resource.robot

*** Variables ***
${port}    8080
${sport}   2443
${url_http}     http://${FGT_IP_ADDRESS}:${port}
${url_https}    https://${FGT_IP_ADDRESS}:${sport}


*** Test Cases ***
768116
    [Documentation]    
    [Tags]    v6.0    chrome   768116    High    win10,64bit   runable
    Login FortiGate  
    Go to system
    Go to system_Settings
    wait and click      ${SYSTEM_SETTINGS_HTTP_PORT_INPUT}
    clear element text  ${SYSTEM_SETTINGS_HTTP_PORT_INPUT}
    input text          ${SYSTEM_SETTINGS_HTTP_PORT_INPUT}    ${port}

    wait and click      ${SYSTEM_SETTINGS_HTTPS_PORT_INPUT}
    clear element text  ${SYSTEM_SETTINGS_HTTPS_PORT_INPUT}
    input text          ${SYSTEM_SETTINGS_HTTPS_PORT_INPUT}   ${sport}
    wait and click      ${SUBMIT_APPLY_SPAN}
    
    ${status}=   run keyword and return status    Login FortiGate  url=${url_http}
    should be equal   "${status}"    "True"
    Logout FortiGate  
    ${status}=   run keyword and return status    Login FortiGate  url=${url_https}
    should be equal   "${status}"    "True"

    [Teardown]   case Teardown
*** Keywords ***
case Teardown
    Logout FortiGate 
    Close All Browsers
    Run Cli commands in File    ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file   ${CURDIR}


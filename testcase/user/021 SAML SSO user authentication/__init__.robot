*** Settings ***
Documentation    initialization for sub feature SAML only
Resource    ../user_resource.robot
Suite Setup    Setup SAML Testing Environment
Suite teardown    clear SAML test data

*** Variables ***

*** Keywords ***
Setup SAML testing environment
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}021_saml_setup_cli_fgta.txt
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}021_saml_setup_cli_fgtb.txt
    ...    ${TERMINAL_SERVER_IP_B}    ${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    ${FGTB_CLI_PROMPT}
    ...    ${FGTB_CLI_USERNAME}    ${FGTB_CLI_PASSWORD}    ${FGTB_CLI_TELNET_CONNECTION_TIMEOUT}    ${FGTB_CLI_NEWLINE}    

clear SAML test data
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}021_saml_teardown_cli_fgtb.txt
    ...    ${TERMINAL_SERVER_IP_B}    ${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    ${FGTB_CLI_PROMPT}
    ...    ${FGTB_CLI_USERNAME}    ${FGTB_CLI_PASSWORD}    ${FGTB_CLI_TELNET_CONNECTION_TIMEOUT}    ${FGTB_CLI_NEWLINE}    
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}021_saml_teardown_cli_fgta.txt
*** Settings ***
Documentation  using to debug program  
Resource  ../system_resource.robot

*** Variables ***
*** Test Cases ***
multi_vdom
    [Tags]  multivdom
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    [teardown]    
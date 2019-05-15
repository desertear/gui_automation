*** Settings ***
Documentation    Verify that source ip address from TACACS GUI is used in connectivity tests from GUI
Resource    ../user_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${tacacs_name}    ${USER_TACPLUS_NAME}
${tacacs_server}    ${USER_TACPLUS_SERVER}
${tacacs_secret}    ${USER_TACPLUS_KEY}
${tacacs_correct_source_ip}    ${FGT_VLAN30_IP}
${tacacs_wrong_source_ip}    ${FGT_VLAN20_IP}
@{correct_cli_cmd}    config user tacacs+    edit "${tacacs_name}"    set source-ip "${tacacs_correct_source_ip}"    end
@{wrong_cli_cmd}    config user tacacs+    edit "${tacacs_name}"    set source-ip "${tacacs_wrong_source_ip}"    end
*** Test Cases ***
814163
    [Tags]    v6.2    chrome    814163    high
    [setup]    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login FortiGate
    #keep source ip to empty
    Edit Tacacs Server    ${tacacs_name}    Test    OK
    #change source ip to correct one
    Execute CLI commands on FortiGate Via Terminal Server    commands=${correct_cli_cmd}
    Edit Tacacs Server    ${tacacs_name}    Test    OK
    #change source ip to wrong one
    Execute CLI commands on FortiGate Via Terminal Server    commands=${wrong_cli_cmd}
    Edit Tacacs Server    ${tacacs_name}    Test    Server unreachable
    Logout FortiGate
    Close Browser
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File on Terminal Server    ${USER_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
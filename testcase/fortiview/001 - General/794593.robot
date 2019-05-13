*** Settings ***
Documentation    Verify logs move from now to 5 mins
Resource    ../fortiview_resource.robot
#Suite Teardown    clean up on fortigate GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot

@{telnet_cmd}    exe log delete-all    y    diagnose sys session clear


*** Test Cases ***
794593
    [Tags]    v6.0    firefox    chrome   794593    critical    win10,64bit
    #[setup]    Run Cli commands in File    ${FORTIVIEW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt

    #delete all logs, make sure no sessions going through
    Execute CLI commands on FortiGate Via Direct Telnet    commands=${telnet_cmd}
    
    #generate a session
    #verify kill session
    #wait 3 minutes
    #check 5 mins
    Login FortiGate    username=fortiviewadmin    password=123456
    Go to Fortiview
    Check all elements on basic fortiview menu
    #Logout FortiGate    FGT_GUI_USERNAME=fortiviewadmin

    Execute CLI commands on FortiGate Via Direct Telnet    commands=${telnet_cmd}

    Login FortiGate    username=fortiviewadmin    password=123456
    #Go to Fortiview
    ${status}=    run keyword and return status    Go to Fortiview
    #${status}=    run keyword and return status    Check all elements on basic fortiview menu
    #Check all elements on basic fortiview menu
    should be equal    "${status}"    "False"
    Run Cli commands in File    ${FORTIVIEW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    #Logout FortiGate    FGT_GUI_USERNAME=fortiviewadmin
    [Teardown]    write test result to file    ${CURDIR}


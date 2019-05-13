*** Settings ***
Documentation    Verify user can drill down by double click and right click menu.
Resource    ../fortiview_resource.robot
#Suite Teardown    clean up on fortigate GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot

@{telnet_cmd}    config system accprofile    edit fortiview_access_profile    set ftviewgrp none    next    end


*** Test Cases ***
806454
    [Tags]    v6.0    firefox    chrome   806454    high    win10,64bit
    [setup]    Run Cli commands in File    ${FORTIVIEW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt

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
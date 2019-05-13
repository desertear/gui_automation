*** Settings ***
Documentation    Verify user can drill down by double click and right click menu.
Resource    ../fortiview_resource.robot
#Suite Teardown    clean up on fortigate GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${ssh_server}    ${PC1_SSH_EXT_IP}
${ssh_username}    ${PC1_USERNAME}
${ssh_password}    ${PC1_PASSWORD}
${ssh_port}    ${PC1_SSH_EXT_PORT}
@{ssh_cmd}    ping 172.16.200.44
@{ssh_cmd2}    killall ping


*** Test Cases ***
794592
    [Tags]    v6.0    firefox    chrome   794592    critical    win10,64bit
    [setup]    Run Cli commands in File    ${FORTIVIEW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Execute commands on PC via SSH connection with write    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd}    port=${ssh_port}

#Verify no sessions are currently running
#Do a ping
#Check 
    Login FortiGate
    Go to Fortiview
    #realtime drilldown
    Go to LANDMZSources
    ##double click
    Doubleclick drill down first entry
    Check elements for summary of table
    Check elements on 1st level tabs
    Check elements on 1st level column headers realtime
    Click back
    ##right click
    Right click drill down first entry
    Check elements for summary of table
    Check elements on 1st level tabs
    Check elements on 1st level column headers realtime
    #Check sessions
    Drill down 1st to 2nd level
    sleep    10
    Check elements for summary of table
    Check elements on 1st level tabs
    Check elements on 1st level column headers realtime sessions

    #historical drilldown
    Go to LANDMZSources
    Switch to 5 minutes
    ##double click
    Doubleclick drill down first entry
    Check elements for summary of table
    Check elements on 1st level tabs
    Check elements on 1st level column headers historical
    Click back
    ##right click
    Right click drill down first entry
    Check elements for summary of table
    Check elements on 1st level tabs
    Check elements on 1st level column headers historical
    #Check sessions
    Drill down 1st to 2nd level
    sleep    10
    Check elements for summary of table
    Check elements on 1st level tabs
    Check elements on 1st level column headers historical sessions

    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd2}    port=${ssh_port}

    Logout FortiGate

    [Teardown]    Run Cli commands in File    ${FORTIVIEW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt    write test result to file    ${CURDIR}    


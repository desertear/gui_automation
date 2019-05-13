*** Settings ***
Documentation    Verify personal bookmark can be saved as fgt configuration.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${bookmark}    735371_bookmark
${url}    tmp.735371_bookmark.com
${desc}    temporary bookmark for case 735371
${ftp_server}    ${PC5_VLAN30_IP}
${ftp_username}    ${PC5_USERNAME}
${ftp_password}    ${PC5_PASSWORD}
@{backup_cli_cmd}    execute backup config ftp 735371.config ${ftp_server} ${ftp_username} ${ftp_password}
${ssh_server}    ${PC5_VLAN10_IP}
${ssh_username}    ${PC5_USERNAME}
${ssh_password}    ${PC5_PASSWORD}
${ssh_port}    ${PC5_SSH_PORT}
@{ssh_cmd}    cat 735371.config|grep ${bookmark}
@{cli_cmd}    sh vpn ssl web user-bookmark ${SSLVPN_GUI_USERNAME}\#${FGT_USER_GROUP_NAME}
*** Test Cases ***
735371
    [Tags]    v6.0    firefox    chrome    edge    safari    735371    critical    win10,64bit
    Login SSLVPN Portal
    #create a bookmark
    create bookmark for http or https    ${bookmark}   ${url}     ${desc}
    #close browser
    Logout SSLVPN Portal
    close browser
    #backup config to FGT server
    @{responses}=    Execute CLI commands on FortiGate Via Direct Telnet    commands=${backup_cli_cmd}
    ${response}=    set variable    @{responses}[-1]
    should match regexp    ${response}    Send config file to ftp server OK.
    #check if config contains newly created bookmark
    ${responses_ssh}=    Execute commands on PC via SSH connection    ${ssh_server}    ${ssh_username}   ${ssh_password}    ${ssh_cmd}    port=${ssh_port}
    should contain    @{responses_ssh}[-1]    ${bookmark}
    #reboot FGT and wait until it's accessible again
    reboot or reset FGT using CLI    reboot
    wait until fgt begin to reboot   ${FGT_IP_ADDRESS} 
    wait until fgt come to be accessible    ${FGT_IP_ADDRESS}
    #check if the bookmark retains via CLI
    @{response_telnet}=    Execute CLI commands on FortiGate Via Direct Telnet    commands=${cli_cmd}
    should contain    @{response_telnet}[-1]    ${bookmark}
    #delete bookmark
    Login SSLVPN Portal
    run keyword and ignore error    delete bookmark by name if it exists    ${bookmark}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    write test result to file    ${CURDIR}
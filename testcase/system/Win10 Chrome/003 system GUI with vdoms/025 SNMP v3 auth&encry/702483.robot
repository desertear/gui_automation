*** Settings ***
Documentation    Verify SNMP V3 user can be created on GUI and works fine in TP mode
Resource    ../../../system_resource.robot

*** Variables ***
${username}   702483
${hostip}    ${PC5_VLAN30_IP}
${password_auth}    12345678
${password_aef}     12345678
@{ssh_cmd}   snmpwalk -v3 -u ${username} -l authPriv -a SHA -A 12345678 -x AES -X 12345678 -m /usr/share/snmp/mibs/FORTINET-FORTIGATE-MIB.mib 172.16.200.1 1.3.6.1.2.1.47.1.1.1.1.11.1
${host_info}   ${FGT_SN}
*** Test Cases ***
702483
    [Documentation]    
    [Tags]    v6.0    chrome   702483    High    win10,64bit    runable
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_vm_setup_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    
    #runable
    Login FortiGate  url=${FGT_URL_VLAN30}
    Go to system
    Go to system_SNMP
    sleep   3
    wait and click   ${SYSTEM_SNMPV3_CREATE_NEW_BUTTON}
    sleep   2
    wait until Element Is Visible   ${SYSTEM_SNMPV3_CREATE_NEW_USERNAME_LABEL}
    clear element text    ${SYSTEM_SNMPV3_CREATE_NEW_USERNAME}
    input text            ${SYSTEM_SNMPV3_CREATE_NEW_USERNAME}    ${username}
    wait and click        ${SYSTEM_SNMPV3_CREATE_NEW_AUTHEN_LABEL}
    wait and click        ${SYSTEM_SNMPV3_CREATE_NEW_AUTH_PSSWD_CHG_BUTTON}
    clear element text    ${SYSTEM_SNMPV3_CREATE_NEW_AUTH_PSSWD_CHG_INPUT}
    input text            ${SYSTEM_SNMPV3_CREATE_NEW_AUTH_PSSWD_CHG_INPUT}   ${password_auth}
    wait and click        ${SYSTEM_SNMPV3_CREATE_NEW_PRIVATE_LABEL}
    wait and click        ${SYSTEM_SNMPV3_CREATE_NEW_AES_PSSWD_CHG_BUTTON}
    clear element text    ${SYSTEM_SNMPV3_CREATE_NEW_AES_PSSWD_CHG_INPUT}
    input text            ${SYSTEM_SNMPV3_CREATE_NEW_AES_PSSWD_CHG_INPUT}   ${password_aef}
    ${new_locator}=       REPLACE PLACEHOLDER IN LOCATOR WITH VALUE   ${SYSTEM_SNMPV3_CREATE_NEW_HOST_IP}   1
    clear element text    ${new_locator}
    input text            ${new_locator}   ${hostip} 
    wait and click        ${SUBMIT_OK_BUTTON}
    wait and click        ${SYSTEM_SNMPV3_APPLY_BUTTON}
    @{response_ssh}=      Execute commands on PC via SSH connection    ${SSH_SERVER}    ${SSH_USERNAME}   ${SSH_PASSWORD}    ${ssh_cmd}    port=${SSH_PORT}  
    ${response}=    set variable    @{response_ssh}[-1]
    should match regexp    ${response}   ${host_info}
    [teardown]    case teardown

*** Keywords ***
case Teardown
    Logout FortiGate
    Close All Browsers
    ${vm}=    run keyword and return status   should contain    ${FGT_HW_TYPE}   VM
    Run Keyword If     "${vm}"=="True"    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_vm_cli.txt
    ...   ELSE   Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}factoryreset_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}purge_cli.txt
    Run Cli commands in File on Terminal Server   ${SYSTEM_CLI_FILE_DIR}${/}multivdom_setup_cli.txt
    write test result to file    ${CURDIR}

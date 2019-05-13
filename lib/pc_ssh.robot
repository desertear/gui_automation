*** Settings ***
Documentation     This file contains command operation on Windows/Linux PC/Server Via SSH

*** Keywords ***
Execute commands on PC via SSH connection
    [Arguments]    ${host}    ${username}    ${password}    ${cmds}    ${timeout}=${PC_LINUX_SSH_TIMEOUT}
    ...    ${prompt}=REGEXP:${PC_LINUX_SSH_PROMPT}    ${port}=${PC_LINUX_SSH_PORT}    ${newline}=${PC_LINUX_SSH_NEWLINE}    ${loglevel}=${PC_LINUX_SSH_LOG_LEVEL}
    ...    ${path_separator}=${PC_LINUX_SSH_PATH_SEPARATOR}    ${encoding}=${PC_LINUX_SSH_ENCODING}    ${term_type}=${PC_LINUX_SSH_TERM_TYPE}    ${width}=${PC_LINUX_SSH_TERM_WIDTH}    ${height}=${PC_LINUX_SSH_TERM_HEIGHT}
    ...    ${logfile}=${PC_LINUX_SSH_LOG_FILE}
    #connect to PC
    SSHLibrary.open connection    host=${host}    port=${port}    timeout=${timeout}    newline=${newline}
    ...    prompt=${prompt}    term_type=${term_type}    width=${width}    height=${height}    path_separator=${path_separator}    encoding=${encoding}
    SSHLibrary.login    ${username}    ${password}
    ${configuration}=    SSHLibrary.Get Connections
    Run keyword if    "${loglevel}"!="NONE"    SSHLibrary.Enable Ssh Logging    ${logfile}
    ${len}=    get length    ${cmds}
    ${responses}=    create list
    :FOR    ${index}    IN RANGE    ${len}
    \    SSHLibrary.Write Bare    @{cmds}[${index}]${newline}
    \    ${res}=    SSHLibrary.Read Until Prompt    ${loglevel}
    \    Append To List    ${responses}    ${res}
    log    ${responses}
    [Return]    ${responses}
    [Teardown]    SSHLibrary.Close Connection

Execute commands on PC via SSH connection and return details
    [Documentation]     This keyword can return a triple of standard output, standard error and return code. 
    ...    You can use "Execute commands on PC via SSH connection" instead, which is a light weight keyword of SSH operation.
    [Arguments]    ${host}    ${username}    ${password}    ${cmds}    ${timeout}=${PC_LINUX_SSH_TIMEOUT}
    ...    ${prompt}=REGEXP:${PC_LINUX_SSH_PROMPT}    ${port}=${PC_LINUX_SSH_PORT}    ${newline}=${PC_LINUX_SSH_NEWLINE}    ${loglevel}=${PC_LINUX_SSH_LOG_LEVEL}
    ...    ${path_separator}=${PC_LINUX_SSH_PATH_SEPARATOR}    ${encoding}=${PC_LINUX_SSH_ENCODING}    ${term_type}=${PC_LINUX_SSH_TERM_TYPE}    ${width}=${PC_LINUX_SSH_TERM_WIDTH}    ${height}=${PC_LINUX_SSH_TERM_HEIGHT}
    ...    ${return_stdout}=${True}    ${return_stderr}=${False}    ${return_rc}=${False}
    ...    ${sudo}=${False}    ${sudo_password}=${None}    ${logfile}=${PC_LINUX_SSH_LOG_FILE}
    #connect to PC
    SSHLibrary.open connection    host=${host}    port=${port}    timeout=${timeout}    newline=${newline}
    ...    prompt=${prompt}    term_type=${term_type}    width=${width}    height=${height}    path_separator=${path_separator}    encoding=${encoding}
    SSHLibrary.login    ${username}    ${password}
    ${configuration}=    SSHLibrary.Get Connections
    Run keyword if    "${loglevel}"!="NONE"    SSHLibrary.Enable Ssh Logging    ${logfile}
    ${len}=    get length    ${cmds}
    ${responses}=    create list
    :FOR    ${index}    IN RANGE    ${len}
    \    ${res}=    SSHLibrary.EXECUTE command    @{cmds}[${index}]    ${return_stdout}    ${return_stderr}    ${return_rc}    ${sudo}    ${sudo_password}    ${timeout}    
    \    Append To List    ${responses}    ${res}
    log    ${responses}
    [Return]    ${responses}
    [Teardown]    SSHLibrary.Close Connection

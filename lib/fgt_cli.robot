*** Settings ***
Documentation     Test Library provides useful keywords for CLI execution on FortiGate
...    == Table of contents ==
...    - `Global Variables`
...    - `Connections`
...    - `Logging`
...    - `Password`
...    - `Variable`
...    - `Advanced Features`
...    - `Examples`
...
...    = Global Variables =
...    All global variables used by fgt_cli libray are placed in env.robot. Their usages are explained below:
...    | =Variable Name= | =Usage= |
...    | FGT_CLI_USERNAME | Username of FortiGate for Telnet connection. |
...    | FGT_CLI_PASSWORD | Password of FortiGate for Telnet connection. |
...    | FGT_CLI_PROMPT | Prompts of FortiGate CLI. Please don't update them unless you understand them totally. |
...    | FGT_CLI_NEWLINE | Character that represents new line for Telnet connection. It varies depending on different Operating Systems. |
...    | FGT_CLI_FILE_DIR | Directory of files that are used to store CLI commands. Some keywords can use it to specify directory of CLI files. i.e. `Run Cli commands in File` |
...    | TFTP_IMAGE_SERVER_IP | IP address of TFTP server which is used to get FortiGate image. |
...    | FGT_CLI_LOG_DIR | Directory of logs that records all CLI running. See `Logging` for details. |
...    | TERMINAL_SERVER_IP | IP address of Terminal Server. |
...    | TERMINAL_SERVER_PORT | Port of terminal server. Please know it's not the mapped port on Terminal which is used to connect to Console port of FortiGate. It's 23 by default. |
...    | FGT_TELNET_PORT_ON_TERMINAL_SERVER | Mapped port of Terminal Server, which is used to connect to console port of FortiGate. The format must be like 20xx. |
...    | TERMINAL_SERVER_USER_PASSWORD | Password of terminal server which is used to login terminal server. If your terminal doesn't have login password, you can ignore it. |
...    | TERMINAL_SERVER_ADMIN_PASSWORD | Password of terminal server which is used to enable administration. If your terminal doesn't have administrative password, you can ignore it. |
...    | TERMINAL_SERVER_PROMPT | Prompts of terminal server. Please don't update them unless you understand them totally. |
...    | TERMINAL_SERVER_NEWLINE | Character that represents new line for Telnet connection. It varies depending on different Operating Systems. |
...    | FGT_CLI_FGT_TELNET_CONNECTION_IP | IP address of FortiGate's interface, which can be accessed via Telnet connection. |
...    | FGT_CLI_TELNET_PORT | Port that FortiGate uses to be accecced via Telnet connection. It's 23 by default. |
...    | FGT_CLI_TELNET_CONNECTION_TIMEOUT | Maximum time Telnet connection takes to wait for outputs. The format can be 10, 20s, or 10 min defined by Robot Framework.  |
...    | FGT_CLI_SSH_HOST | IP address of FortiGate's interface, which can be accessed via SSH connection. |
...    | FGT_CLI_SSH_PORT | Port that FortiGate uses to be accecced via SSH connection. It's 22 by default. |
...    | FGT_CLI_SSH_CONNECTION_TIMEOUT | Maximum time SSH connection takes to wait for outputs. The format can be 10, 20s, or 10 min defined by Robot Framework.  |
...    | FGT_MAX_STARTUP_TIME | Maximum time Telnet/SSH connection takes to wait until FortiGates starts up again. It's used by rebooting, upgrading, resetting, restoring, image burning, and enabling FIPS of FortiGate. |
...    | FGT_MAX_RUNNING_TIME | Maximum time running of all testcases takes. If FGT_MAX_RUNNING_TIME execeeds, but `FGT_MAX_STARTUP_TIME` has not reached, telnet connection would be terminated. | 
...    | FGT_KEYWORD_MAX_RUNNING_TIME | Maximum time running of each keyword takes. If FGT_KEYWORD_MAX_RUNNING_TIME execeeds, but `FGT_MAX_STARTUP_TIME` has not reached, telnet connection would be terminated. | 
...
...    = Connections =
...    There are 3 types of connection, which we can use to execute CLI commands on FortiGate.
...    - Direct Telnet Connection: Connect to FortiGate's port via telnet connection.
...
...    - Terminal Server: Connect to FortiGate via terminal Server, which maps a virual telnet port to FortiGate's physical Console port.
...
...    - Vitual Machine Console: Connect to ForitGate depoloyed on a VM, and VM provides console connection for user to operate on FortiGate.
...
...    = Logging =
...    To make the CLI commands running clearly, all running process will be recorded. Log files will be created at $HOME/log directory with name like cli_logs_20181205101010.txt.
...    \nBecause some cases require to run many commands, running logs are separated by detail bars to make debugging easier like:
...    \n"=== Connection Details: ==="
...    \n"== Device: FortiGate, Connection Type: Telnet, IP Address: 172.16.106.64, Port: 2015, Time: 2018-12-05 10:26:31 ==""
...
...    = Password =
...    User can change password using CLI. Because ``FGT_CLI`` library try its best to make it user-friendly, library always tries to login FGT whenever you are kicked out
...    due to some reasons such as changing VDOM status, changing currently admin password, reseting or rebooting FGT. 
...    This feature is based on terminal server, but can not be supported on direct telnet connection.
...
...    In below scenarios, ``FGT_CLI`` library can login automatically without your intervention:
...    - Change admin password in same session.
...    - Reboot FGT.
...    - Reset FGT.
...    - Upgrade FGT.
...    - Burn image.
...    - Switch FGT operation mode.
...    - Restore config file which has same admin password.
...
...    However, ``FGT_CLI`` library can not login FGT automatically under certain circumstances as described below:
...    - Change admin password in another places, i.e. GUI or another Telnet/SSH session.
...    - Restore config file which has different admin password from current one.
...
...    = Variable =
...    User can use variables in CLI files to dynamically assign value to them. Make sure variables must be visible before
...    running CLI in files. Variables can be either global variables, test suite variables or test variables.
...
...    = Advanced Features =
...    Apart from regular commands execution, FGT_CLI library also supports a few advanced operations using CLI commands including:
...    - Purge settings: Users only need to run CLI command '``purge``', and don't need to run '``y``' to confirm it.
...
...    - Reboot FortiGate: Users only need to run CLI command '``execute reboot``' as regular commands, and library will automatically reboot FortiGate until it restarts up again. This feature is based on terminal server, but is not supported on telnet connection.
...
...    - Reset FortiGate: Users only need to run CLI command '``execute factoryreset``' as regular commands, and library will automatically factory reset FortiGate until it restarts up again. This feature is based on terminal server, but is not supported on telnet connection.
...
...    - Upgrade FortiGate: Users only need to run CLI command '``execute restore image tftp FGT_300D-v6-build0792-FORTINET.out 172.16.200.55``' as regular commands, and library will automatically upgrade/downgrade FortiGate until it restarts up again. Both upgrade and downgrade are supported. This feature is based on terminal server, but is not supported on telnet connection.
...
...    - Restore FortiGate: Users only need to run CLI command '``execute restore config tftp fgt.conf 172.16.200.55``' as regular commands, and library will automatically restore FortiGate with specified config file until it restarts up again. This feature is based on terminal server, but is not supported on telnet connection.
...
...    - Handle login banner: Keyword can handle pre login banner and post login banner automationcally. Users doen't need to handle them with CLI commands.
...
...    - Change FortiGate mode: Users can switch to fipscc mode using CLI commands easily. This feature is based on terminal server, but is not supported on telnet connection.
...
...    - Input password twice: Under certain circumstances, changing password requires inputting password secondly. Library can automatically input the password again without users' intervention.
...
...    - Burn image in BIOS: The library offers keywords for user to burn image in BIOS. Two versions of BIOS are supported both. This feature is based on terminal server, but is not supported on telnet connection.
...
...    - Change FortiGate License: Users can apply licenses of different types to FGT as using regular CLI commands. This feature is based on terminal server, but is not supported on telnet connection. Factory license, LENC license and Low Crypto license are supported.
...
...    - Get implication: Usually users run a commands ended with question mark(?) to get the implication of possible options. Library supports this function also. User can execute a command ended with ? to get the implication.
...
...    = Examples =
...    - Will add them if it's necessary.

*** Keywords ***
Execute CLI commands on FortiGate Via Telnet
    [Arguments]    ${commands}    ${ip_address}    ${telnet_port}    ${prompt}    ${username}    ${password}    ${connection_timeout}    ${newline}    ${alias}    ${keep_connection}    ${index_or_alias}
    @{responses}=    Create List
    ${index}=    open or switch connection    ${ip_address}    ${telnet_port}    ${prompt}    ${username}    ${alias}    ${index_or_alias}
    Telnet.Set Timeout    ${connection_timeout}
    ${res}=    login FGT in Telnet Connection    ${username}    ${password}    ${prompt}    ${newline}
    Append To List    ${responses}    @{res}
    #Pre-process cli commands(i.e enter vdom, set output...)
    # ${res}=    pre process CLI commands    ${prompt}    ${username}    ${password}    ${newline}
    # Append To List    ${responses}    @{res}
    # begin to process CLI commands
    ${res}=    run cli commands    ${username}    ${password}    ${prompt}    ${newline}    ${commands}
    Append To List    ${responses}    @{res}
    log    ${responses}
    [Return]    ${responses}
    [Teardown]    log CLI and Close Session    FortiGate    Telnet    ${ip_address}    ${telnet_port}    ${responses}    ${keep_connection}

open or switch connection
    [Arguments]    ${ip_address}    ${telnet_port}    ${prompt}    ${username}    ${alias}    ${index_or_alias}
    Run keyword if    "${index_or_alias}"=="${None}"    Clear Terminal Line    ${ip_address}    ${telnet_port}
    ${index}=    Run keyword if    "${index_or_alias}"=="${None}"    Telnet.open connection    ${ip_address}    alias=${alias}    port=${telnet_port}    prompt=${prompt}    prompt_is_regexp=True     default_log_level=TRACE    terminal_emulation=True
    ...    ELSE    Telnet.Switch Connection    ${index_or_alias}
    [Return]    ${index}

pre process CLI commands
    [Documentation]    pre process CLI running  such as setting vdom status, set output formats.
    [Arguments]    ${prompt}    ${username}    ${password}    ${newline}
    @{responses}=    Create List
    #judge if VDOM is enabled
    ${vdom_status}=    check vdom status    ${newline}
    #if vdom is enabled, below cmds are used to enter global configuration
    ${res}=    enter global configuration    ${vdom_status}    ${newline}
    Append To List    ${responses}    @{res}
    #set output format, in case full results cannot be shown
    @{pre_process_cmds}=    Create List    config system console    set output standard    end
    ${res}=    run cli commands    ${username}    ${password}    ${prompt}    ${newline}    ${pre_process_cmds}
    Append To List    ${responses}    @{res}
    #if vdom is enabled, below cmds are used to exit global configuration
    ${res}=    leave global configuration    ${vdom_status}    ${newline}
    Append To List    ${responses}    @{res}
    [Return]    ${responses}

log CLI and Close Session
    [Arguments]    ${device}    ${connection_type}    ${address}    ${port}    ${responses}    ${keep_connection}=${False}
    Log CLI To File        ${device}    ${connection_type}    ${address}    ${port}    ${responses}
    Run keyword if    not ${keep_connection}    Telnet.Close Connection

Check Errors from CLI running
    [Arguments]    ${response}
    Log    todo task 

Execute CLI commands on FortiGate Via Direct Telnet
    [Documentation]    Execute CLI commands via drirect Telnet connection.
    ...    \nIf you want to execute commands with terminal server connection please refer to another keyword `Execute CLI commands on FortiGate Via Terminal Server`.
    ...    \nTo make it's easier to use, most arguments use default variables from ``env.robot`` as explained in `Global Variables`. 
    ...    Users don't need to specify this arguments if they have already defined them in ``env.robot``.
    ...    \nArguments:
    ...    - ``commands`` is a list of all commands. All commands are executed line by line. 
    ...    - ``ip_address``, ``telnet_port``, ``prompt``, ``username``, ``password``, ``connection_timeout``, and ``newline`` are explained in `Global Variables`.
    ...    - ``alias`` is set as alias of current connection, and it can be used to recover the connection later by assigning the alias to variable ``index_or_alias`` described below. It's ${None} by default.
    ...    - ``keep_connection`` is a boolean value used to indicate if close current connection after finish running commands. It's ${False} by default, which means to close the established connection finally.
    ...    - ``index_or_alias`` is index or alias of active connection which user wants to switch to again. It's ${None} by default, which means to create a new connection rather than recover an old one.
    ...     
    ...    \nReturn:
    ...    - return a list of responses for all executed commands. You can also refer to `Logging` to get what are returned after running commands. 
    ...
    ...    \n\nExamples:
    ...    | ${cmds1} = | Create List | get system status | |
    ...    | ${rsp1} = | Execute CLI commands on FortiGate Via Direct Telnet | ${cmds1} | | |
    ...    | ${cmds2} = | Create List | config system console | set output standard | end |
    ...    | ${rsp2} = | Execute CLI commands on FortiGate Via Direct Telnet | ${cmds2} | connection_timeout=10 | newline=\\n |
    [Arguments]    ${commands}    ${ip_address}=${FGT_CLI_FGT_TELNET_CONNECTION_IP}    ${telnet_port}=${FGT_CLI_TELNET_PORT}    ${prompt}=${FGT_CLI_PROMPT}
    ...    ${username}=${FGT_CLI_USERNAME}    ${password}=${FGT_CLI_PASSWORD}    ${connection_timeout}=${FGT_CLI_TELNET_CONNECTION_TIMEOUT}    ${newline}=${FGT_CLI_NEWLINE}    ${alias}=${None}    ${keep_connection}=${False}    ${index_or_alias}=${None}
    ${responses}=    Execute CLI commands on FortiGate Via Telnet    ${commands}    ${ip_address}    ${telnet_port}    ${prompt}
    ...    ${username}    ${password}    ${connection_timeout}    ${newline}    ${alias}    ${keep_connection}    ${index_or_alias}
    [Return]    ${responses}

Execute CLI commands on FortiGate Via Terminal Server
    [Documentation]    Execute CLI commands via terminal server by default.
    ...    \nIf you want to execute commands with terminal server connection please refer to another keyword `Execute CLI commands on FortiGate Via Direct Telnet`.
    ...    \nTo make it's easier to use, most arguments use default variables from ``env.robot`` as explained in `Global Variables`. 
    ...    Users don't need to specify this arguments if they have already defined them in ``env.robot``.
    ...    \nArguments:
    ...    - ``commands`` is a list of all commands. All commands are executed line by line. 
    ...    - ``ip_address``, ``telnet_port``, ``prompt``, ``username``, ``password``, ``connection_timeout``, and ``newline`` are explained in `Global Variables`.
    ...    - ``alias`` is set as alias of current connection, and it can be used to recover the connection later by assigning the alias to variable ``index_or_alias`` described below. It's ${None} by default.
    ...    - ``keep_connection`` is a boolean value used to indicate if close current connection after finish running commands. It's ${False} by default, which means to close the established connection finally.
    ...    - ``index_or_alias`` is index or alias of active connection which user wants to switch to again. It's ${EMPTY} by default, which means to create a new connection rather than recover an old one.
    ...
    ...    \nReturn:
    ...    - return a list of responses for all executed commands. You can also refer to `Logging` to get what are returned after running commands. 
    ...
    ...    \n\nExamples:
    ...    | ${cmds1} = | Create List | execute factoryreset | |
    ...    | ${rsp1} = | Execute CLI commands on FortiGate Via Terminal Server | ${cmds1} | | |
    ...    | ${cmds2} = | Create List | config router static | purge | end |
    ...    | ${rsp2} = | Execute CLI commands on FortiGate Via Terminal Server | ${cmds2} | ip_address=172.16.181.30 | username=admin1 |
    ...    | ${cmds3} = | Create List | config system global | set vdom-mode multi-vdom | end |
    ...    | ${rsp3} = | Execute CLI commands on FortiGate Via Terminal Server | ${cmds3} | ip_address=172.16.181.30 | username=admin1 |
    ...    | ${cmds4} = | Create List | execute restore image tftp FGT_300D-v6-build0792-FORTINET.out 172.16.200.55 | | |
    ...    | ${rsp4} = | Execute CLI commands on FortiGate Via Terminal Server | ${cmds4} | telnet_port=1023 | password=Qa@12345 |
    [Arguments]    ${commands}    ${ip_address}=${TERMINAL_SERVER_IP}    ${telnet_port}=${FGT_TELNET_PORT_ON_TERMINAL_SERVER}    ${prompt}=${FGT_CLI_PROMPT}
    ...    ${username}=${FGT_CLI_USERNAME}    ${password}=${FGT_CLI_PASSWORD}    ${connection_timeout}=${FGT_CLI_TELNET_CONNECTION_TIMEOUT}    ${newline}=${FGT_CLI_NEWLINE}    ${alias}=${None}    ${keep_connection}=${False}    ${index_or_alias}=${None}
    ${responses}=    Execute CLI commands on FortiGate Via Telnet    ${commands}    ${ip_address}    ${telnet_port}    ${prompt}
    ...    ${username}    ${password}    ${connection_timeout}    ${newline}    ${alias}    ${keep_connection}    ${index_or_alias}
    [Return]    ${responses}

clear Terminal Line
    [Arguments]    ${ip_address}    ${fgt_access_port}    ${password}=${TERMINAL_SERVER_USER_PASSWORD}    ${admin_password}=${TERMINAL_SERVER_ADMIN_PASSWORD}    ${prompt}=${TERMINAL_SERVER_PROMPT}    ${newline}=${TERMINAL_SERVER_NEWLINE}
    @{responses}=    Create List
    ${if_needed}=    if need clearing line    ${fgt_access_port} 
    Return From Keyword If    "${if_needed}"!="${True}"    Don't need to clear line, because the host is either FGT or VM FGT themself.
    ${line_id}=    evaluate    ${fgt_access_port}-2000
    ${cmd}=    set variable    clear line ${line_id}
    Telnet.open connection    ${ip_address}    port=${TERMINAL_SERVER_PORT}    prompt=${prompt}    prompt_is_regexp=True     default_log_level=TRACE
    Telnet.write bare    ${newline}
    ${res}=    Telnet.Read until prompt
    Append To List    ${responses}    ${res}
    ${if_need_password}=    Run keyword and return status    Should Match Regexp    ${res}    Password:
    ##input user password if it requires
    ${res}=    Run Keyword If    "${if_need_password}"=="${True}"    login terminal server    ${password}    ${newline}
    ...    ELSE    set variable    ${res}
    Run Keyword If    "${if_need_password}"=="${True}"    Append To List    ${responses}    ${res}
    ${if_need_enable_admin}=    Run keyword and return status    Should Match Regexp    ${res}    .*\\s\#
    ##input admin password if prompt is not #
    ${res}=    Run Keyword If    "${if_need_enable_admin}"!="${True}"    enable administration terminal server    ${admin_password}    ${newline}
    ...    ELSE    Create List
    Run Keyword If    "${if_need_enable_admin}"!="${True}"    Append To List    ${responses}    @{res}
    ##clear line
    ${res}=    clear line    ${cmd}    ${newline}
    Append To List    ${responses}    @{res}
    log    ${responses}
    [Return]    ${responses}
    [Teardown]    Run keyword if    ${if_needed}    log CLI and Close Session    Terminal Server    Telnet    ${ip_address}    ${TERMINAL_SERVER_PORT}    ${responses}

if need clearing line
    [Documentation]    There are 3 types of Telnet Connection: Direct Connection, By Terminal Server and VM Console emulator.
    [Arguments]    ${fgt_access_port}
    ${telnet_port}=    Convert To String    ${fgt_access_port}
    #Judgement is based on connection port
    ${if_needed}=    Run keyword and return status    Should Match Regexp    ${telnet_port}    20\\d{2}
    [Return]    ${if_needed}

login terminal server
    [Arguments]    ${password}    ${newline}
    Telnet.write bare    ${password}${newline}
    ${res}=    Telnet.Read until Regexp    .*\>|.*\#
    log    ${res}
    [Return]    ${res}

enable administration terminal server
    [Arguments]    ${admin_password}    ${newline}
    @{responses}=    Create List    
    Telnet.write bare    enable${newline}
    ${res}=    Telnet.Read until Regexp    Password:|\#
    Append To List    ${responses}    ${res}
    ${if_enabled}=    Run keyword and Return status    Should Match Regexp    ${res}    \#
    Return from Keyword if    ${if_enabled}    ${responses}
    ${res}=    input admin password to terminal server    ${admin_password}    ${newline}
    Append To List    ${responses}    ${res}
    log    ${responses}
    [Return]    ${responses}

input admin password to terminal server
    [Arguments]    ${admin_password}    ${newline}
    Telnet.write bare    ${admin_password}${newline}
    ${res}=    Telnet.Read until Regexp    \#
    log    ${res}
    [Return]    ${res}

clear line
    [Arguments]    ${cmd}    ${newline}
    @{responses}=    Create List      
    Telnet.write bare    ${cmd}${newline}
    ${res}=    Telnet.Read until    [confirm]
    Append To List    ${responses}    ${res}
    Telnet.write bare    y
    ${res}=    Telnet.Read until    \#
    Append To List    ${responses}    ${res}
    log    ${responses}
    [Return]    ${responses}

login FGT in Telnet Connection
    [Documentation]    when user firstly logins FortiGate in Telnet connection or is kicked out by FGT(reason can be changing Vdom status or changing user's password),
    ...    this keyword can be used to login FGT.
    [Arguments]    ${username}    ${password}    ${prompt}    ${newline}
    @{responses}=    Create List    
    ${res}=    Return to login prompt in CLI    ${prompt}    ${newline}
    Append To List    ${responses}    @{res}    
    #input username
    Telnet.write bare    ${username}${newline}
    ${res}=    Telnet.Read until     Password:
    Append To List    ${responses}    ${res}
    #input password
    Telnet.write bare    ${password}${newline}
    ${res}=    Telnet.Read Until Prompt
    Append To List    ${responses}    ${res}
    #handle POST Warning
    ${if_warning_banner}=    Run keyword and return status    Should Contain    ${res}    (Press 'a' to accept):
    ${res}=    Run keyword If    "${if_warning_banner}"=="${True}"    handle login post banner
    ...    ELSE    Create List
    Append To List    ${responses}    @{res}
    log    ${responses}
    [Return]    ${responses}

return to login prompt in CLI
    [Arguments]    ${prompt}    ${newline}
    @{responses}=    Create List
    ${res}=    Wait Until Prompt Is Displayed    ${prompt}    ${newline}
    Append To List    ${responses}    @{res}
    Telnet.write bare    ${newline}
    ${res}=    Telnet.Read Until prompt
    ${if_login_level}=    Run keyword and return status    Should Contain    ${res}    login:
    ${if_warning_banner}=    Run keyword and return status    Should Contain    ${res}    (Press 'a' to accept):
    ${res}=    Run keyword If    "${if_warning_banner}"=="${True}"    handle login pre banner
    ...    ELSE    Create List
    Append To List    ${responses}    @{res}    
    Return From Keyword If    "${if_login_level}"=="${True}" or "${if_warning_banner}"=="${True}"    ${responses}
    :FOR    ${index}    IN RANGE    10
    \    Telnet.Write Bare    \x04
    \    ${res}=    Telnet.Read Until prompt
    \    Append To List    ${responses}    ${res}
    \    ${if_login_level}=    Run keyword and return status    Should Contain    ${res}    login:
    \    ${if_warning_banner}=    Run keyword and return status    Should Contain    ${res}    (Press 'a' to accept):
    \    ${res}=    Run keyword If    "${if_warning_banner}"=="${True}"    handle login pre banner
    \    ...    ELSE    Create List
    \    Run keyword If    "${if_warning_banner}"=="${True}"    Append To List    ${responses}    @{res}
    \    Exit For Loop If    ${if_login_level} or ${if_warning_banner}
    log    ${responses}
    [Return]    ${responses}

handle login pre banner
    @{responses}=    Create List
    Telnet.Write Bare    a
    ${res}=    Telnet.Read Until Regexp    login:  
    Append To List    ${responses}    ${res}  
    log    ${responses}
    [Return]    ${responses}

handle login post banner
    @{responses}=    Create List
    Telnet.Write Bare    a
    ${res}=    Telnet.Read Until Regexp    \\s\#
    Append To List    ${responses}    ${res}  
    log    ${responses}
    [Return]    ${responses}

wait Until Prompt Is Displayed
    [Arguments]    ${prompt}    ${newline}
    @{responses}=    Create List
    :FOR    ${index}    IN RANGE    10
    \    Telnet.write bare    ${newline}
    \    ${status}=    Run keyword and return status    telnet.Read Until prompt
    # \    Append To List    ${responses}    ${res}
    # \    ${status}=    Run keyword and return status    should match regexp    ${res}    ${prompt}
    \    Exit For Loop If    ${status}
    log    ${responses}
    [Return]    ${responses}

check vdom status
    [Documentation]    This keyword is a local keyword which is used by Telnet Keyword only. Please don't use it in other places.
    [Arguments]    ${newline}
    @{responses}=    Create List
    Telnet.write bare    get system status | grep "Virtual domain configuration"${newline}
    ${res}=    Telnet.Read Until Prompt
    Append To List    ${responses}    ${res}
    ${vdom_status_list}=    get regexp matches    ${res}    Virtual domain configuration: (multiple|split-task|disable|enable)    1
    ${vdom_status}=    set variable    @{vdom_status_list}[0]
    log    ${responses}
    [Return]    ${vdom_status}    

enter global configuration
    [Documentation]    This keyword is a local keyword which is used by Telnet Keyword only. Please don't use it in other places.
    [Arguments]    ${vdom_status}    ${newline}
    @{responses}=    Create List
    Return From Keyword If    "${vdom_status}"=="disable"    ${responses}  
    Telnet.write bare    config global${newline}
    ${res}=    Telnet.Read Until Prompt
    Append To List    ${responses}    ${res}
    log    ${responses}
    [Return]    ${responses}      

leave global configuration
    [Documentation]    This keyword is a local keyword which is used by Telnet Keyword only. Please don't use it in other places.
    [Arguments]    ${vdom_status}    ${newline}
    @{responses}=    Create List
    Return From Keyword If    "${vdom_status}"=="disable"    ${responses}  
    Telnet.write bare    end${newline}
    ${res}=    Telnet.Read Until Prompt
    Append To List    ${responses}    ${res}
    log    ${responses}
    [Return]    ${responses}   

run cli commands
    [Documentation]    This keyword is a local keyword which is used by Telnet Keyword only. Please don't use it in other places.
    [Arguments]    ${username}    ${password}    ${prompt}    ${newline}    ${commands}
    @{responses}=    Create List
    ${length}=    Get length    ${commands}
    :FOR    ${index}    IN RANGE    0    ${length}
    \    ${command}=    set variable    @{commands}[${index}]
    \    record password changed by CLI    ${command}
    \    ${if_end_with_question_mark}=    run keyword and return status    Should End With    ${command}    ?
    \    ${res}=    Run keyword if    ${if_end_with_question_mark}    run cli command ended with question mark    ${command}
    \    ...    ELSE    run cli command and return response    ${command}    ${newline}
    \    Append To List    ${responses}    ${res}
    \    ${prompt_type}=    get prompt type    ${newline}    ${res}
    \    Continue For Loop If    "${prompt_type}"=="normal"
    \    ${res}=    handle special prompts    ${prompt_type}    ${username}    ${password}    ${prompt}    ${newline}
    \    Append To List    ${responses}    @{res}
    log    ${responses}
    [Return]    ${responses}

run cli command and return response
    [Arguments]    ${command}    ${newline}
    ${updated_command}=    handle special characters    ${command}
    Telnet.write bare    ${updated_command}${newline}
    ${res}=    Telnet.Read until prompt
    log    ${res}
    [Return]    ${res}

run cli command ended with question mark
    [Documentation]    When question mark is last char of a line, it means user want to get auto completion tips.
    [Arguments]    ${cmd}
    ${updated_command}=    handle special characters    ${cmd}
    Telnet.write bare    ${updated_command}
    ${res1}=    Telnet.Read until prompt
    #input Ctrl+C to clear unfinished command
    Telnet.write bare    \x03
    ${res2}=    Telnet.Read until prompt
    log    ${res1}${res2}
    [Return]    ${res1}${res2}

handle special characters
    [Arguments]    ${command}
    ${last_char}=    Get Substring    ${command}    -1
    ${new_command}=    Get Substring    ${command}    \    -1
    ${new_command}=    Replace String    ${new_command}    ?    \x16?
    [Return]    ${new_command}${last_char}

get prompt type
    [Documentation]    Judge prompt type according to last return message. based on prompot regular expression 
    ...    "${FGT_CLI_NEWLINE}.*\\s\#|\\(y/n\\)|${FGT_CLI_NEWLINE}>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:",
    ...    returns:  normal, yes_no, login, password
    [Arguments]    ${newline}    ${response}
    ${if_normal}=    run keyword and return status    should match regexp    ${response}    .*\\s\#
    ${if_more}=    run keyword and return status    should match regexp    ${response}    --More--
    ${if_gt}=    run keyword and return status    should match regexp    ${response}    ${newline}\>
    ${if_yes_no}=    run keyword and return status    should match regexp     ${response}    \(y\/n\)
    ${if_login}=    run keyword and return status    should match regexp     ${response}    login:
    ${if_password}=    run keyword and return status    should match regexp     ${response}    Password:
    ${if_enabling_fipscc}=    run keyword and return status    should match regexp     ${response}    Please enter admin administrator password:
    ${if_password_again}=    run keyword and return status    should match regexp     ${response}    again:
    ${if_reboot}=    run keyword and return status    should match regexp     ${response}    This operation will reboot the system
    ${if_reset}=    run keyword and return status    should match regexp     ${response}    This operation will reset the system to (the )?factory default
    ${if_upgrade}=    run keyword and return status    should match regexp     ${response}    This operation will replace the current firmware version
    ${if_restore_config}=    run keyword and return status    should match regexp     ${response}    This operation will overwrite the current setting and could possibly reboot the system
    ##Return different type according to prompts it returns
    Return from Keyword if    ${if_normal} or ${if_gt}    normal
    Return from Keyword if    ${if_more}    more
    Return from Keyword if    ${if_login}    login
    Return from Keyword if    ${if_password}    password
    Return from Keyword if    ${if_enabling_fipscc}    fipscc
    Return from Keyword if    ${if_password_again}    twice_password
    Return from Keyword if    ${if_reboot} and ${if_yes_no}    reboot
    Return from Keyword if    ${if_reset} and ${if_yes_no}    reset    
    Return from Keyword if    ${if_upgrade} and ${if_yes_no}    upgrade
    Return from Keyword if    ${if_restore_config} and ${if_yes_no}    restore 
    Return from Keyword if    ${if_yes_no}    yes_no
    [Return]    unknown

handle special prompts
    [Documentation]    Based on prompt type input different commands accordingly.
    ...    Args:  normal, more, yes_no, login, password, fipscc, twice_password, reboot, reset, upgrade, and restore
    [Arguments]    ${prompt_type}    ${username}    ${password}    ${prompt}    ${newline}
    @{responses}=    Create List
    run keyword if    "${prompt_type}"=="yes_no"    Telnet.write bare    y
    ...    ELSE IF    "${prompt_type}"=="more"    Telnet.write bare    q
    ...    ELSE IF    "${prompt_type}"=="login"    Telnet.write bare    ${username}${newline}
    ...    ELSE IF    "${prompt_type}"=="password"    Telnet.write bare    ${password}${newline}
    ...    ELSE IF    "${prompt_type}"=="fipscc"    Log    Do nothing
    ...    ELSE IF    "${prompt_type}"=="twice_password"    Log    Do nothing
    ...    ELSE IF    "${prompt_type}"=="reboot"    Log    Do nothing
    ...    ELSE IF    "${prompt_type}"=="reset"    Log    Do nothing
    ...    ELSE IF    "${prompt_type}"=="upgrade"    Log    Do nothing
    ...    ELSE IF    "${prompt_type}"=="restore"    Log    Unfinished
    ...    ELSE    Fail    unknown prompt type
    #for some "execute" commands "SN #" is not returned, that why I use # as prompt on below line
    ${res}=    run keyword if    "${prompt_type}"=="yes_no"    Telnet.Read until Regexp    \\s\#|login:
    ...    ELSE IF    "${prompt_type}"=="more"    Telnet.Read until Prompt
    ...    ELSE IF    "${prompt_type}"=="login"    Telnet.Read until    Password:
    ...    ELSE IF    "${prompt_type}"=="password"    Telnet.Read until    \\s\#
    ...    ELSE IF    "${prompt_type}"=="fipscc"    enable FIPS mode with CLI    ${FGT_FIPS_CC_PASSWORD}    ${newline}
    ...    ELSE IF    "${prompt_type}"=="twice_password"    input password again with CLI    ${newline}
    ...    ELSE IF    "${prompt_type}"=="reboot"    ${prompt_type} fortigate with CLI
    ...    ELSE IF    "${prompt_type}"=="reset"    ${prompt_type} fortigate with CLI
    ...    ELSE IF    "${prompt_type}"=="upgrade"    upgrade fortigate with CLI
    ...    ELSE IF    "${prompt_type}"=="restore"    ${prompt_type} fortigate with CLI
    ...    ELSE    Create List
    Append To List    ${responses}    ${res}
    #judge if admin's password has been changed to a new one before
    ${if_exist}=    Run keyword and return status    Variable Should Exist    ${ADMIN_PASSWORD_UPDATED}
    ${if_is_true_and_existed}=    Run keyword if    ${if_exist}    Run keyword and return status    Should be True    ${ADMIN_PASSWORD_UPDATED}
    ...    ELSE    set variable    ${False}
    #some operations may change password(i.e. reboot, reset, or switch running mode)
    ${new_password}=    run keyword if    "${prompt_type}"=="fipscc"    set variable    ${FGT_FIPS_CC_PASSWORD}
    ...    ELSE IF    "${prompt_type}"=="reset"    set variable    ${EMPTY}
    ...    ELSE IF    "${prompt_type}"=="login" and ${if_is_true_and_existed}    set variable    ${RECORDED_PASSWORD1}
    ...    ELSE    set variable    ${password}
    #Usually reset ${ADMIN_PASSWORD_UPDATED} to ${False}
    Set Suite Variable    ${ADMIN_PASSWORD_UPDATED}    ${False}
    #Judge if current operation is to admin changes its own password
    ${if_change_admin_own_password}=    Run keyword and return status    Should Be true    "${prompt_type}"=="twice_password" and "${RECORDED_PASSWORD2}"!="${None}"
    run keyword if    ${if_change_admin_own_password}    Set Suite Variable    ${ADMIN_PASSWORD_UPDATED}    ${True}
    #make sure it comes to logged status again
    ${new_prompt_type}=    get prompt type    ${newline}    ${res}
    ${res}=    run keyword if    "${new_prompt_type}"=="login"    login FGT in Telnet Connection    ${username}    ${new_password}    ${prompt}    ${newline}
    ...    ELSE IF    "${new_prompt_type}"=="password"    login FGT in Telnet Connection    ${username}    ${new_password}    ${prompt}    ${newline}
    ...    ELSE IF    "${prompt_type}"=="fipscc"    login FGT in Telnet Connection    ${username}    ${new_password}    ${prompt}    ${newline}
    ...    ELSE IF    "${prompt_type}"=="reboot"    login FGT in Telnet Connection    ${username}    ${new_password}    ${prompt}    ${newline}
    ...    ELSE IF    "${prompt_type}"=="reset"    login FGT in Telnet Connection    ${username}    ${new_password}    ${prompt}    ${newline}
    ...    ELSE IF    "${prompt_type}"=="upgrade"    login FGT in Telnet Connection    ${username}    ${new_password}    ${prompt}    ${newline}
    ...    ELSE IF    "${prompt_type}"=="restore"    login FGT in Telnet Connection    ${username}    ${new_password}    ${prompt}    ${newline}
    ...    ELSE    Create List
    Append To List    ${responses}    @{res}
    log    ${responses}
    [Return]    ${responses}


enable FIPS mode with CLI
    [Arguments]    ${password}    ${newline}
    @{responses}=    Create List
    Telnet.write bare    ${password}${newline}
    ${res}=    Telnet.Read until    Please re-enter admin administrator password:
    Append To List    ${responses}    ${res}
    Telnet.write bare    ${password}${newline}
    ${res}=    Telnet.Read until    (y/n)
    Append To List    ${responses}    ${res}
    Telnet.write bare    y${newline}
    Telnet.Set Timeout    ${FGT_MAX_STARTUP_TIME}
    ${res}=    Telnet.Read until    login:
    Append To List    ${responses}    ${res}
    log    ${responses}
    ${str_responses}=    Convert List to String    ${responses}
    Telnet.Set Timeout    ${FGT_CLI_TELNET_CONNECTION_TIMEOUT}
    [Return]    ${str_responses}

input password again with CLI
    [Arguments]    ${newline}
    @{responses}=    Create List
    Telnet.write bare    ${RECORDED_PASSWORD1}${newline}
    ${res}=    Telnet.Read Until prompt
    Append To List    ${responses}    ${res}
    ${if_need_orginal_password}=    Run Keyword and Return status    should match Regexp    ${res}    Please enter password again:
    ${res}=    Run keyword if    ${if_need_orginal_password}    input original password with CLI    ${newline}
    ...    ELSE    Set variable    ${EMPTY}
    Append To List    ${responses}    ${res}
    log    ${responses}
    ${str_responses}=    Convert List to String    ${responses}
    [Return]    ${str_responses}

input original password with CLI
    [Arguments]    ${newline}
    Telnet.write bare    ${RECORDED_PASSWORD2}${newline}
    ${res}=    Telnet.Read Until prompt
    [Return]    ${res}

${operation_type} fortigate with CLI
    [Documentation]   Currently this keyword supports 3 types of operation: reset, reboot, and restore
    log    ${operation_type}ing FortiGate
    @{responses}=    Create List
    Telnet.write bare    y
    Telnet.Set Timeout    ${FGT_MAX_STARTUP_TIME}
    ${res}=    Telnet.Read until regexp    Please stand by while rebooting the system.
    Append To List    ${responses}    ${res}
    ${res}=    Telnet.Read until prompt
    Append To List    ${responses}    ${res}
    log    ${responses}
    ${str_responses}=    Convert List to String    ${responses}
    Telnet.Set Timeout    ${FGT_CLI_TELNET_CONNECTION_TIMEOUT}
    [Return]    ${str_responses}

upgrade fortigate with CLI
    [Documentation]    Upgrade or downgrade Fortigate with CLI
    @{responses}=    Create List
    Telnet.write bare    y
    Telnet.Set Timeout    ${FGT_MAX_STARTUP_TIME}
    ${res}=    Telnet.Read until Regexp    Get image from (?:ftp|tftp|flash|usb) server OK\\.
    Append To List    ${responses}    ${res}
    ${res}=    Telnet.read until Regexp    (?:This operation will downgrade the current firmware version\\.|Please wait for system to restart\\.)
    Append To List    ${responses}    ${res}
    ${if_downgrade}=    run keyword and return status    Should contain    ${res}    This operation will downgrade the current firmware version
    ${res}=    Run keyword if    "${if_downgrade}"=="True"    confirm downgrade with CLI
    ...    ELSE    set variable    ${EMPTY}
    Append To List    ${responses}    ${res}
    ${res}=    Telnet.Read until prompt
    Append To List    ${responses}    ${res}
    log    ${responses}
    ${str_responses}=    Convert List to String    ${responses}
    Telnet.Set Timeout    ${FGT_CLI_TELNET_CONNECTION_TIMEOUT}
    [Return]    ${str_responses}

confirm downgrade with CLI
    [Documentation]    When downgrade FGT, it requires confirmation
    @{responses}=    Create List
    ${res}=    Telnet.Read until prompt    
    Append To List    ${responses}    ${res}
    Telnet.write bare    y
    log    ${responses}
    ${str_responses}=    Convert List to String    ${responses}
    [Return]    ${str_responses}


record password changed by CLI
    [Documentation]    Record password changed by CLI, use set them as test cases variable.
    [Arguments]    ${cmd}
    ${if_password_change_cmd}=    Run keyword and return status    Should Match Regexp    ${cmd}    set (?:password|passwd|psksecret|key) (.*)
    Return From Keyword If    not ${if_password_change_cmd}    Not a Password Changing Command
    ${matched_list}=    Get Regexp Matches    ${cmd}     set (?:password|passwd|psksecret|key) (.*)    1
    ${matched_str}=    set variable    @{matched_list}[0]
    ${if_contains_two_passwords}=    Run keyword and return status    Should Match Regexp    ${matched_str}    \\S+\\s\\S+
    ${matched_list_first_password}=    Run keyword if    ${if_contains_two_passwords}    Get Regexp Matches    ${matched_str}     (\\S+)\\s\\S+    1
    ${matched_list_second_password}=    Run keyword if    ${if_contains_two_passwords}    Get Regexp Matches    ${matched_str}     \\S+\\s(\\S+)    1
    Run keyword if    ${if_contains_two_passwords}    record two passwords    @{matched_list_first_password}[0]   @{matched_list_second_password}[0]
    ...    ELSE    record one password    ${matched_str}

record two passwords
    [Arguments]    ${password1}    ${password2}
    Set Suite Variable   ${RECORDED_PASSWORD1}    ${password1}
    Set Suite Variable    ${RECORDED_PASSWORD2}    ${password2}

record one password
    [Arguments]    ${password1}
    Set Suite Variable   ${RECORDED_PASSWORD1}    ${password1}
    Set Suite Variable    ${RECORDED_PASSWORD2}    ${None}

Burn Image on BIOS 
    [Documentation]    Burn image for FortiGate on it's BIOS
    ...    \nTwo versions of BIOS are supported, and keyword can check the BIOS version automatically. Before use this keyword, the tftp server and image file on tftp server must be well prepared.
    ...    \nTo make it's easier to use, most arguments use default variables from ``env.robot`` as explained in `Global Variables`. 
    ...    As a result, users don't need to specify this arguments if they have already defined them in ``env.robot``.
    ...    \nArguments:
    ...    - ``tftp_server_ip`` is IP address of TFTP server where image file is placed. 
    ...    
    ...    - ``fgt_local_ip`` is IP address of FGT itself which is used to connect to TFTP server. 
    ...    
    ...    - ``image_name`` is name of image file which is placed on TFTP Server. 
    ...
    ...    - ``ip_address``, ``telnet_port``, ``prompt``, ``username``, ``password``, ``connection_timeout``, and ``newline`` are explained in `Global Variables`.
    ...
    ...    \nReturn:
    ...    - return a list of responses for all executed commands. You can also refer to `Logging` to get what are returned after running commands. 
    ...
    ...    \n\nExamples:
    ...    | ${response1} = | Burn Image on BIOS  | 10.6.30.55 | 10.6.30.1 | FGT_300D-v6-build0792-FORTINET.out | |
    ...    | ${response2} = | Burn Image on BIOS  | 10.6.30.55 | 10.6.30.1 | FGT_301E-v6-build0221-FORTINET.out | password=Qa@12345 |
    [Arguments]    ${tftp_server_ip}    ${fgt_local_ip}    ${image_name}
    ...    ${ip_address}=${TERMINAL_SERVER_IP}    ${telnet_port}=${FGT_TELNET_PORT_ON_TERMINAL_SERVER}    ${prompt}=${FGT_CLI_PROMPT}
    ...    ${username}=${FGT_CLI_USERNAME}    ${password}=${FGT_CLI_PASSWORD}    ${connection_timeout}=${FGT_CLI_TELNET_CONNECTION_TIMEOUT}    ${newline}=${FGT_CLI_NEWLINE}
    @{responses}=    Create List
    Clear Terminal Line    ${ip_address}    ${telnet_port}
    Telnet.open connection    ${ip_address}    port=${telnet_port}    prompt=${prompt}    prompt_is_regexp=True     default_log_level=TRACE
    Telnet.Set Timeout    ${connection_timeout}
    ${res}=    login FGT in Telnet Connection    ${username}    ${password}    ${prompt}    ${newline}
    Append To List    ${responses}    @{res}
    #judge if VDOM is enabled
    ${vdom_status}=    check vdom status    ${newline}
    #if vdom is enabled, below cmds are used to enter global configuration
    ${res}=    enter global configuration    ${vdom_status}    ${newline}
    Append To List    ${responses}    @{res}
    #reboot FGT to go to BIOS
    Telnet.Set Timeout    ${FGT_MAX_STARTUP_TIME}
    Telnet.write bare    execute reboot${newline}
    ${res}=    Telnet.Read until prompt
    Append To List    ${responses}    ${res}
    Telnet.write bare    y
    #begin operation on BIOS
    ${res}=    Telnet.Read until Regexp   [pP]ress any key to display configuration menu
    Append To List    ${responses}    ${res}
    Telnet.write bare    ${newline}${newline}
    #there are three versions of BIOS
    ${res}=    Telnet.Read until Regexp   (?:Enter C,R,T,F,B,I,Q,or H:|Enter G,F,B,(I,)?Q,or H:|Enter C,R,T,F,I,B,Q,or H:)
    Append To List    ${responses}    ${res}
    ${if_old_bios}=    run keyword and return status    Should match regexp    ${res}    Enter G,F,B,(?:I,)?Q,or H:
    ${res}=    Run keyword if    not ${if_old_bios}         burn Image on BIOS of new version    ${tftp_server_ip}    ${fgt_local_ip}    ${image_name}    ${newline}
    ...    ELSE    burn Image on BIOS of old version    ${tftp_server_ip}    ${fgt_local_ip}    ${image_name}    ${newline}
    #wait until it restarts up again.
    Append To List    ${responses}    @{res}
    ${res}=    Telnet.Read until prompt
    Append To List    ${responses}    ${res}
    Telnet.Set Timeout    ${FGT_CLI_TELNET_CONNECTION_TIMEOUT}
    log    ${responses}
    [Return]    ${responses}
    [Teardown]    log CLI and Close Session    FortiGate    Telnet    ${ip_address}    ${telnet_port}    ${responses}

burn Image on BIOS of new version
    [Arguments]    ${tftp_server_ip}    ${fgt_local_ip}    ${image_name}    ${newline}
    @{responses}=    Create List
    #[C]:  Configure TFTP parameters.
    Telnet.write bare    C
    ${res}=    Telnet.Read until Regexp   Enter P,D,I,S,G,V,T,F,E,R,N,Q[, ]or H:
    Append To List    ${responses}    ${res}
    #[I]:  Set local IP address.
    Telnet.write bare    I
    ${res}=    Telnet.Read until Regexp   Enter local IP address .*:
    Append To List    ${responses}    ${res}
    #Enter local IP address [10.6.30.1]:
    Telnet.write bare    ${fgt_local_ip}${newline}
    ${res}=    Telnet.Read until Regexp   Enter P,D,I,S,G,V,T,F,E,R,N,Q[, ]or H:
    Append To List    ${responses}    ${res}
    #[T]:  Set remote TFTP server IP address.
    Telnet.write bare    T
    ${res}=    Telnet.Read until Regexp   Enter remote TFTP server IP address .*:
    Append To List    ${responses}    ${res}
    #Enter remote TFTP server IP address [10.6.30.55]:
    Telnet.write bare    ${tftp_server_ip}${newline}
    ${res}=    Telnet.Read until Regexp   Enter P,D,I,S,G,V,T,F,E,R,N,Q[, ]or H:
    Append To List    ${responses}    ${res}
    #[F]:  Set firmware image file name.
    Telnet.write bare    F
    ${res}=    Telnet.Read until Regexp   Enter firmware file name .*:
    Append To List    ${responses}    ${res}
    #Enter firmware file name [FGT_301E-v6-build0221-FORTINET.out]:
    Telnet.write bare    ${image_name}${newline}
    ${res}=    Telnet.Read until Regexp   Enter P,D,I,S,G,V,T,F,E,R,N,Q[, ]or H:
    Append To List    ${responses}    ${res}
    #[Q]:  Quit this menu.
    Telnet.write bare    Q
    ${res}=    Telnet.Read until Regexp   (?:Enter C,R,T,F,B,I,Q,or H:|Enter C,R,T,F,I,B,Q,or H:)
    Append To List    ${responses}    ${res}
    #[R]:  Review TFTP parameters.
    Telnet.write bare    R
    ${res}=    Telnet.Read until Regexp   (?:Enter C,R,T,F,B,I,Q,or H:|Enter C,R,T,F,I,B,Q,or H:)
    Append To List    ${responses}    ${res}
    #[T]:  Initiate TFTP firmware transfer.
    Telnet.write bare    T
    ${res}=    Telnet.Read until Regexp   Please connect TFTP server to Ethernet port
    Append To List    ${responses}    ${res}
    #wait until the download has finished
    ${res}=    Telnet.Read until Regexp   Save as Default firmware/Backup firmware/Run image without saving:\\[D/B/R\\]\\?
    Append To List    ${responses}    ${res}
    #Save as Default firmware/Backup firmware/Run image without saving:[D/B/R]?
    Telnet.write bare    D
    ${res}=    Telnet.Read until Regexp   Programming the boot device now.
    Append To List    ${responses}    ${res}
    log    ${responses}
    [Return]    ${responses}


burn Image on BIOS of old version
    [Arguments]    ${tftp_server_ip}    ${fgt_local_ip}    ${image_name}    ${newline}
    @{responses}=    Create List
    #[G]:  Get firmware image from TFTP server.
    Telnet.write bare    G
    ${res}=    Telnet.Read until Regexp   Enter TFTP server address .*:
    Append To List    ${responses}    ${res}
    #Enter TFTP server address [192.168.1.168]:
    Telnet.write bare    ${tftp_server_ip}${newline}
    ${res}=    Telnet.Read until Regexp   Enter local address .*:
    Append To List    ${responses}    ${res}
    #Enter local address [192.168.1.188]:
    Telnet.write bare    ${fgt_local_ip}${newline}
    ${res}=    Telnet.Read until Regexp   Enter firmware image file name .*:
    Append To List    ${responses}    ${res}
    #Enter firmware image file name [image.out]:
    Telnet.write bare    ${image_name}${newline}
    ${res}=    Telnet.Read until Regexp   Verifying the integrity of the firmware image.
    Append To List    ${responses}    ${res}
    #wait until the download has finished
    ${res}=    Telnet.Read until Regexp   Save as Default firmware/Backup firmware/Run image without saving:\\[D/B/R\\]\\?
    Append To List    ${responses}    ${res}
    #Save as Default firmware/Backup firmware/Run image without saving:[D/B/R]?
    Telnet.write bare    D
    ${res}=    Telnet.Read until Regexp   Programming the boot device now.
    Append To List    ${responses}    ${res}
    log    ${responses}
    [Return]    ${responses}

cli error handler
    &{error_code}=    create dictionary
    ...    -61=command parse error
    ...    -204=value parse error
    ...    -1=object set operator error
    ...    0=Unknown action
    ...    1=Login incorrect
    &{warning_code}=    create dictionary
    ...    -61=command parse error
    ...    -1=Entries don't match.  
    ...    -1=Warning: You are using one of the factory default certificates.

Execute CLI commands on FortiGate Via Direct SSH
    [Arguments]    ${commands}    ${ip_address}=${FGT_CLI_SSH_HOST}    ${ssh_port}=${FGT_CLI_SSH_PORT}
    ...    ${username}=${FGT_CLI_USERNAME}    ${password}=${FGT_CLI_PASSWORD}    ${connection_timeout}=${FGT_CLI_SSH_TIMEOUT}
    @{responses}=    Create List
    ${newline}=    run Keyword if    "${OS_TYPE}"=="Windows"    set variable    CRLF
    ...    ELSE IF    "${OS_TYPE}"=="Linux"    set variable    LF
    ...    ELSE    set variable    CRLF
    run keyword and ignore error    SSHLibrary.Enable Ssh Logging    C:\\sslvpn_automation\\script\\web\\ssh.txt
    SSHLibrary.open connection    ${ip_address}    port=${ssh_port}    newline=${newline}    prompt=REGEXP:${FGT_CLI_PROMPT}
    #login with username and password,
    SSHLibrary.login    ${username}    ${password}
    #judge if VDOM is enabled
    ${res}=    SSHLibrary.execute command    get system status | grep "Virtual domain configuration"
    Append To List    ${responses}    ${res}
    ${vdom_status_list}=    get regexp matches    ${res}    Virtual domain configuration: (multiple|split-task|disable|enable)    1
    ${vdom_status}=    set variable    @{vdom_status_list}[0]
    #if vdom is enabled, below cmds are used to enter global configuration
    run keyword if     "${vdom_status}"!="disable"    SSHLibrary.write bare    config global${FGT_CLI_NEWLINE}
    ${res}=    run keyword if     "${vdom_status}"!="disable"    SSHLibrary.Read Until Prompt
    run keyword if     "${vdom_status}"!="disable"    Append To List    ${responses}    ${res}
    #set output format, in case full results cannot be shown
    SSHLibrary.write    config system console
    ${res}=    SSHLibrary.Read
    Append To List    ${responses}    ${res}
    SSHLibrary.write    set output standard
    ${res}=    SSHLibrary.Read
    Append To List    ${responses}    ${res}
    SSHLibrary.write    end
    ${res}=    SSHLibrary.Read
    Append To List    ${responses}    ${res}
    #if vdom is enabled, below cmds are used to exit global configuration
    run keyword if     "${vdom_status}"!="disable"    SSHLibrary.write bare    end${FGT_CLI_NEWLINE}
    ${res}=    run keyword if     "${vdom_status}"!="disable"    SSHLibrary.Read Until Prompt
    run keyword if     "${vdom_status}"!="disable"    Append To List    ${responses}    ${res}
    # begin to process CLI commands
    ${length}=    Get length    ${commands}
    :FOR    ${index}    IN RANGE    0    ${length}
    \    ${res}=    SSHLibrary.execute command    @{commands}[${index}]${FGT_CLI_NEWLINE}
    \    Append To List    ${responses}    ${res}
    \    ${if_yes_no_cmd}=    run keyword and return status    Should contain    ${res}    (y/n
    \    run keyword if    "${if_yes_no_cmd}"=="True"    SSHLibrary.write bare    y
    #for some "execute" commands "SN #" is not returned, that why I use # as prompt on below line
    \    ${res}=    run keyword if    "${if_yes_no_cmd}"=="True"    SSHLibrary.Read until    \#
    \    run keyword if    "${if_yes_no_cmd}"=="True"    Append To List    ${responses}    ${res}
    SSHLibrary.Close Connection
    log    ${responses}
    [Return]    ${responses}

Run Cli commands in File
    [Documentation]    Run CLI commands in File via Direct Telnet Connection.
    ...    \nThis keyword is used to extract cli commands from file and run these commands on Direct Telnet Connection.
    ...    \nIf you want to execute commands in file with terminal server connection, please refer to another keyword `Run Cli commands in File on Terminal Server`.
    ...    \nArguments:
    ...    - ``file_path`` is absolute path of file which stores all commands users want to execute. 
    ...    
    ...    - ``dic`` is dictionary of variables which will be used to replace variables with values in file. 
    ...
    ...    \nReturn:
    ...    - return a list of responses for all executed commands. You can also refer to `Logging` to get what are returned after running commands. 
    ...   
    ...    Due to compatibility reason, some arguments are invisible here. They can be configured in env.robot as described in `Global Variables`. 
    ...    \n\nExamples:
    ...    | ${var} = | Create Dictionary | vlan20_ip=10.1.100.1 |
    ...    | ${rsp1} = | Run Cli commands in File | ${CLI_FILE_DIR}${/}setup_cli.txt | &{var} |
    [Arguments]    ${file_path}    &{dic}
    ${file_formatted}=    format cli commands file    ${file_path}    &{dic}
    @{responses}=    Execute CLI commands on FortiGate Via Direct Telnet    commands=${file_formatted}
    [Return]    ${responses}

Run Cli commands in File on Terminal Server
    [Documentation]    Run CLI commands in File via Terminal Server.
    ...    \nThis keyword is used to extract cli commands from file and run these commands on terminal server.
    ...    \nIf you want to execute commands in file with direct telnet connection, please refer to another keyword `Run Cli commands in File`.
    ...    \nTo make it's easier to use, most arguments use default variables from ``env.robot`` as explained in `Global Variables`. 
    ...    Users don't need to specify this arguments if they have already defined them in ``env.robot``.
    ...    \nArguments:
    ...    - ``file_path`` is absolute path of file which stores all commands users want to execute. 
    ...    
    ...    - ``dic`` is dictionary of variables which will be used to replace variables with values in file. 
    ...    
    ...    - Other arguments such as ``ip_address``, ``telnet_port``, ``prompt``, ``username``, ``password``, ``connection_timeout``, and ``newline`` are same as arguments defined in `Execute CLI commands on FortiGate Via Direct Telnet`.
    ...
    ...    \nReturn:
    ...    - return a list of responses for all executed commands. You can also refer to `Logging` to get what are returned after running commands. 
    ...    
    ...    \nExamples:
    ...    | ${var1} = | Create Dictionary | vlan20_ip=10.1.100.1 | |
    ...    | ${rsp1} = | Run Cli commands in File on Terminal Server | ${CLI_FILE_DIR}${/}setup_cli.txt | &{var1} | |
    ...    | ${var2} = | Create Dictionary | vlan20_ip=10.1.100.1 | vlan30_ip=172.16.200.1 | |
    ...    | ${rsp2} = | Run Cli commands in File on Terminal Server | ${CLI_FILE_DIR}${/}setup_cli.txt | ip_address=172.16.181.30 | &{var2} |
    ...    | ${rsp3} = | Run Cli commands in File on Terminal Server | ${CLI_FILE_DIR}${/}setup_cli.txt | telnet_port=2023 |  |

    [Arguments]    ${file_path}    ${ip_address}=${TERMINAL_SERVER_IP}    ${telnet_port}=${FGT_TELNET_PORT_ON_TERMINAL_SERVER}    ${prompt}=${FGT_CLI_PROMPT}
    ...    ${username}=${FGT_CLI_USERNAME}    ${password}=${FGT_CLI_PASSWORD}    ${connection_timeout}=${FGT_CLI_TELNET_CONNECTION_TIMEOUT}    ${newline}=${FGT_CLI_NEWLINE}    &{dic}
    ${file_formatted}=    format cli commands file    ${file_path}    &{dic}
    @{responses}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${file_formatted}    ip_address=${ip_address}    telnet_port=${telnet_port}    prompt=${prompt}
    ...    username=${username}    password=${password}    connection_timeout=${connection_timeout}    newline=${newline}
    [Return]    ${responses}

format cli commands file
    [Arguments]    ${file_path}    &{variable_dic}
    OperatingSystem.File Should Exist    ${file_path}
    ${file_content}=    OperatingSystem.Get file    ${file_path}
    @{file_by_lines}=    split string    ${file_content}    \n
    #remove empty lines
    remove values from list    ${file_by_lines}    ${EMPTY}
    #remove meaningless whitespaces and keep only one space from two or more consecutive  spaces .
    ${length}=    get length    ${file_by_lines}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${tmp}=    Strip String    @{file_by_lines}[${index}]
    \    ${tmp}=    Replace String Using Regexp    ${tmp}    \\s{2,}    \ \
    # \    ${tmp}=    Remove String    ${tmp}    \"
    \    Set List Value    ${file_by_lines}    ${index}    ${tmp}
    #remove commented lines which begin with char #
    ${file_formatted}=    copy list    ${file_by_lines}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${if_comment_line}=    run keyword and return status    should match Regexp    @{file_by_lines}[${index}]    ^#
    \    run keyword if   "${if_comment_line}"=="True"    Remove Values From List    ${file_formatted}    @{file_by_lines}[${index}]
    ${file_formatted}=    replace variable reference in list with variable value    @{file_formatted}    &{variable_dic}
    #replace global variables with values
    ${length}=    get length    ${file_formatted}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${tmp}=    Replace Variables    @{file_formatted}[${index}]
    \    Set List Value    ${file_formatted}    ${index}    ${tmp}
    log    ${file_formatted}
    [return]    ${file_formatted}

replace variable reference in list with variable value
    [Arguments]    @{file_list}    &{variable_dic}
    ${length}=    get length    ${file_list}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${if_contains_variable}=    Run keyword and return status    Should Contain    @{file_list}[${index}]    \${
    \    Continue For Loop If    "${if_contains_variable}"!="True"
    \    ${replaced_line}=    replace variable in string with variable value    @{file_list}[${index}]    &{variable_dic}
    \    Set List Value    ${file_list}    ${index}    ${replaced_line}
    [return]    ${file_list}

replace variable in string with variable value
    [Arguments]    ${str}    &{variable_dic}
    ${dic_keys}=    Get Dictionary Keys    ${variable_dic}
    :FOR    ${dic_key}    IN    @{dic_keys}
    \    ${str}=    Replace String    ${str}    \${${dic_key}}    &{variable_dic}[${dic_key}]
    [return]    ${str}

reboot or reset FGT using CLI
    [Arguments]    ${reboot_type}    ${ip_address}=${FGT_CLI_FGT_TELNET_CONNECTION_IP}    ${telnet_port}=${FGT_CLI_TELNET_PORT}
    ...    ${username}=${FGT_CLI_USERNAME}    ${password}=${FGT_CLI_PASSWORD}    ${connection_timeout}=${FGT_CLI_TELNET_CONNECTION_TIMEOUT}
    [Documentation]    reboot_type can be "reboot" or "reset"
    ${reboot_reset_cmd}=    run keyword if    "${reboot_type}"=="reboot"    set variable    execute reboot
    ...    ELSE IF    "${reboot_type}"=="reset"    set variable    execute factoryreset
    ...    ELSE    Fail    unknown reboot type ${reboot_type}
    @{responses}=    Create List
    Telnet.open connection    ${FGT_CLI_FGT_TELNET_CONNECTION_IP}    port=${FGT_CLI_TELNET_PORT}    prompt=${FGT_CLI_PROMPT}    prompt_is_regexp=True     default_log_level=TRACE
    Telnet.Set Timeout    ${connection_timeout}
    #input username
    Telnet.write bare    ${username}${FGT_CLI_NEWLINE}
    ${res}=    Telnet.Read until     Password:
    Append To List    ${responses}    ${res}
    #input password
    Telnet.write bare    ${password}${FGT_CLI_NEWLINE}
    ${res}=    Telnet.Read Until Prompt
    Append To List    ${responses}    ${res}
    #judge if VDOM is enabled
    Telnet.write bare    get system status | grep "Virtual domain configuration"${FGT_CLI_NEWLINE}
    ${res}=    Telnet.Read Until Prompt
    Append To List    ${responses}    ${res}
    ${vdom_status_list}=    get regexp matches    ${res}    Virtual domain configuration: (multiple|split-task|disable|enable)    1
    ${vdom_status}=    set variable    @{vdom_status_list}[0]
    #if vdom is enabled, below cmds are used to enter global configuration
    run keyword if     "${vdom_status}"!="disable"    Telnet.write bare    config global${FGT_CLI_NEWLINE}
    ${res}=    run keyword if     "${vdom_status}"!="disable"    Telnet.Read Until Prompt
    run keyword if     "${vdom_status}"!="disable"    Append To List    ${responses}    ${res}
    #begin to reboot/reset
    Telnet.write bare    ${reboot_reset_cmd}${FGT_CLI_NEWLINE}
    ${res}=    Telnet.Read until prompt
    Append To List    ${responses}    ${res}
    Telnet.write bare    y
    run keyword and ignore error    Telnet.Close Connection
    log    ${responses}
    [Return]    ${responses}

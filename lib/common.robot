*** Settings ***
Documentation     This file contains keywords that are used to deal with works that don't involve either FGT GUI or SSLVPN Portal.

*** Keywords ***
REPLACE PLACEHOLDER IN LOCATOR WITH VALUE
    [arguments]    ${locator}    ${value}
    [Documentation]    This keyword replace placeholders in Locator with real value
    ...    placeholder in Locator must be ${PLACEHOLDER}
    ...    ${locator}: locator; ${value}: value that is to be replaced
    ${PLACEHOLDER}=    set variable    ${value}
    ${locator_replaced_with_real_value}=    Replace Variables    ${locator}
    [Return]    ${locator_replaced_with_real_value}

#Similiar to REPLACE PLACEHOLDER IN LOCATOR WITH VALUE, this is used for locator that has multiple variables to be replaced
REPLACE PLACEHOLDERS IN LOCATOR WITH VALUE
    [arguments]    ${locator}    ${value_list}
    [Documentation]    This keyword replace placeholders in Locator with real value
    ...    placeholder in Locator must be ${PLACEHOLDER1} ${PLACEHOLDER2} ${PLACEHOLDER3}.....
    ...    ${locator}: locator that has variables to be replaced
    ...    ${value_list}: list of real values to be used
    ${index}    Evaluate    1
    :FOR    ${value}    IN    @{value_list}
    \    Set Test Variable    ${PLACEHOLDER${index}}    ${value}
    \    ${index}    Evaluate    ${index}+1
    ${locator_replaced_with_real_value}=    Replace Variables    ${locator}
    [Return]    ${locator_replaced_with_real_value}    

#Remove extra character of the return text
Remove Extra Character in Text
    [arguments]    ${input}
    ${output}=    Set Variable    ${input.replace("\n", "")}
    ${output}=    Strip String    ${output}
    [Return]    ${output}

Get FGT system information
    [arguments]    ${host}    ${port}    ${username}    ${password}
    log    do nothing

write test result to file
    [arguments]    ${case_dir}    ${mark}=${EMPTY}
    Define Running Time as global variable
    ${test_pass_result}=    set variable    ${TEST NAME}${SPACE * 4}${case_dir}${/}${TEST NAME}.robot${SPACE * 4}Pass\r
    Run Keyword If Test Passed    Append to file    ${REPORT_FILE_TXT_PATH}${/}test_report_${RUNNING_TIME}.txt    ${test_pass_result}
    ${test_fail_result}=    set variable    ${TEST NAME}${SPACE * 4}${case_dir}${/}${TEST NAME}.robot${SPACE * 4}Fail\r
    Run Keyword If Test Failed    Append to file    ${REPORT_FILE_TXT_PATH}${/}test_report_${RUNNING_TIME}.txt    ${test_fail_result}
    Run Keyword If Test Passed    write test result to json file    1    ${TEST NAME}    ${mark}
    Run Keyword If Test Passed    write passed test result to json file    ${TEST NAME}    ${mark}
    Run Keyword If Test Failed    write test result to json file    2    ${TEST NAME}    ${mark}
    Run Keyword If Test Failed    write failed test result to json file    ${TEST NAME}    ${mark}

write test result to json file
    [arguments]    ${test_result}    ${test_id}    ${mark}=${EMPTY}
    Define Running Time as global variable
    ${object_to_add}=    Run keyword if   ${test_result}==1    create dictionary    result=${test_result}    testcase_id=${test_id}    mark=${mark}
    ...    ELSE    create dictionary    result=${test_result}    testcase_id=${test_id}    mark=${mark}    bug_id=1
    ${json_obj}=    Load Json from file    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}.json
    ${total_old}=    Get Value From Json    ${json_obj}    $..total
    ${total_new}=    evaluate    @{total_old}[0]+1
    ${json_obj_result_added}=    Add Object To Json    ${json_obj}    $..results    ${object_to_add}
    ${json_obj_number_updated}=     Update Value To Json    ${json_obj_result_added}    $..total    ${total_new}
    write_json_to_file    ${json_obj_number_updated}    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}.json

write passed test result to json file
    [arguments]    ${test_id}    ${mark}=${EMPTY}
    Define Running Time as global variable
    ${object_to_add}=    create dictionary    result=1    testcase_id=${test_id}    mark=${mark}
    ${json_obj}=    Load Json from file    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}_PASS.json
    ${total_old}=    Get Value From Json    ${json_obj}    $..total
    ${total_new}=    evaluate    @{total_old}[0]+1
    ${json_obj_result_added}=    Add Object To Json    ${json_obj}    $..results    ${object_to_add}
    ${json_obj_number_updated}=     Update Value To Json    ${json_obj_result_added}    $..total    ${total_new}
    write_json_to_file    ${json_obj_number_updated}    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}_PASS.json

write failed test result to json file
    [arguments]    ${test_id}    ${mark}=${EMPTY}
    Define Running Time as global variable
    ${object_to_add}=    create dictionary    result=2    testcase_id=${test_id}    mark=${mark}    bug_id=1
    ${json_obj}=    Load Json from file    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}_FAIL.json
    ${total_old}=    Get Value From Json    ${json_obj}    $..total
    ${total_new}=    evaluate    @{total_old}[0]+1
    ${json_obj_result_added}=    Add Object To Json    ${json_obj}    $..results    ${object_to_add}
    ${json_obj_number_updated}=     Update Value To Json    ${json_obj_result_added}    $..total    ${total_new}
    write_json_to_file    ${json_obj_number_updated}    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}_FAIL.json

Get FortiGate hardware and software info
    @{cmd_output}=    create list    config system console    set output standard    end
    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_output}
    ${fgt_hw}    ${fgt_sw_version}    ${fgt_bios_version}    ${fgt_serial_number}    ${fgt_fips_status}    ${fgt_build_number}    ${vdom_status}    ${hard_disk}=    Get FortiGate System info
    ${fgt_av_def}    ${fgt_av_eng}    ${fgt_ips_def}    ${fgt_ips_eng}=    Get FortiGate Security profiles info
    ${asic_version}=    Get FortiGate Hardware status
    #set FGT info as global variables which overide those variables stored in env.robot
    ${fgt_hw_serial_full}=    Replace String    ${fgt_hw}    -    \ \    1
    ${fgt_hw_type}=    Fetch From Left    ${fgt_hw}    -
    &{fullname_and_abbrname_mapping}=    create dictionary    FortiGate=FGT    FortiWiFi=FWF    FortiGateRugged=FGR
    ${fgt_hw_type_abbr}=    Replace String    ${fgt_hw}    -    _
    ${fgt_hw_type_abbr}=    Replace String    ${fgt_hw_type_abbr}    ${fgt_hw_type}    &{fullname_and_abbrname_mapping}[${fgt_hw_type}]
    Set Global Variable    ${FGT_HW_TYPE}    ${fgt_hw_serial_full}
    Set Global Variable    ${FGT_SN}    ${fgt_serial_number}
    Set Global Variable    ${FGT_AV_DEF}    ${fgt_av_def}
    Set Global Variable    ${FGT_VERSION}    ${fgt_sw_version}
    Set Global Variable    ${FGT_AV_ENG}    ${fgt_av_eng}
    Set Global Variable    ${FGT_BIOS}    ${fgt_bios_version}
    Set Global Variable    ${FGT_BUILD}    ${fgt_build_number}
    Set Global Variable    ${FGT_IPS_DEF}    ${fgt_ips_def}
    Set Global Variable    ${FGT_IPS_ENG}    ${fgt_ips_eng}
    Set Global Variable    ${FGT_TYPE}    ${fgt_hw_type_abbr}
    Set Global Variable    ${FGT_HARD_DISK}    ${hard_disk}
    Set Global Variable    ${FGT_ASIC_VERSION}    ${asic_version}
    @{cmd_output}=    create list    config system console    unset output    end
    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd_output}

Get FortiGate System info
    [Documentation]    return is list of Hardware type, software version, BIOS version, Serial Number, FIPSCC stauts and build number.
    @{cmd}=    create list    get system status
    @{response}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd}
    ${hw}=    Get Regexp matches    @{response}[-1]    Version: (Forti.*?)\\sv.*${FGT_CLI_NEWLINE}    1
    ${ver}=    Get Regexp matches    @{response}[-1]    Version:.*(v\\d.\\d.\\d),build\\d{4},.*${FGT_CLI_NEWLINE}    1
    ${bios}=    Get Regexp matches    @{response}[-1]    .*BIOS version: (\\S*).*${FGT_CLI_NEWLINE}    1
    ${sn}=    Get Regexp matches    @{response}[-1]    .*Serial-Number: (\\S*).*${FGT_CLI_NEWLINE}    1
    ${fipscc_status}=    Get Regexp matches    @{response}[-1]    .*FIPS-CC mode: (enable|disable)(.*)${FGT_CLI_NEWLINE}    1
    ${build}=    Get Regexp matches    @{response}[-1]    Version:.*,build(\\d{4,}),.*${FGT_CLI_NEWLINE}    1
    ${vdom_status}=    Get Regexp matches    @{response}[-1]    .*Virtual domain configuration: (multiple|split-task|disable|enable)(.*)${FGT_CLI_NEWLINE}    1
    Set Global Variable    ${FGT_VDOM_STATUS}    @{vdom_status}[0]
    ${hard_disk}=    Get Regexp matches    @{response}[-1]    .*Log hard disk: (Not available|Available)(.*)${FGT_CLI_NEWLINE}    1
    #for FortiGate VM, there is no BIOS version since v6.2 b0818.
    ${len}=    get length    ${bios}
    ${bios_version}=    Run keyword if    ${len}==${0}    set variable    00000000
    ...    ELSE    set variable    @{bios}[0]
    [return]    @{hw}[0]    @{ver}[0]    ${bios_version}    @{sn}[0]    @{fipscc_status}[0]    @{build}[0]    @{vdom_status}[0]    @{hard_disk}[0]

Get FortiGate Security profiles info
    [Documentation]    return is list of AV definition version, AV engine version, IPS definition version and IPS engine version
    @{cmd}=    run keyword if    "${FGT_VDOM_STATUS}"!="disable"    create list    config global    diag autoupdate version    end
    ...    ELSE    create list    diag autoupdate version
    #if vdom is enabled, the last second item of list is Security information
    ${utm_index_of_list}=    run keyword if    "${FGT_VDOM_STATUS}"!="disable"    set variable    ${-2}
    ...    ELSE        set variable    ${-1}
    @{response}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd}
    @{lines}=    Split String    @{response}[${utm_index_of_list}]    \r\n
    ${index}=    Get Index From List    ${lines}    AV Engine
    ${av_engine_version}=    Get Regexp matches    @{lines}[${index+2}]    Version: (\\d+\\.\\d+)    1
    ${index}=    Get Index From List    ${lines}    Virus Definitions
    ${av_definition_version}=    Get Regexp matches    @{lines}[${index+2}]    Version: (\\d+\\.\\d+)    1
    ${index}=    Get Index From List    ${lines}    Attack Definitions
    ${ips_definition_version}=    Get Regexp matches    @{lines}[${index+2}]    Version: (\\d+\\.\\d+)    1
    ${index}=    Get Index From List    ${lines}    IPS Attack Engine
    ${ips_engine_version}=    Get Regexp matches    @{lines}[${index+2}]    Version: (\\d+\\.\\d+)    1
    [return]    @{av_definition_version}[0]    @{av_engine_version}[0]    @{ips_definition_version}[0]    @{ips_engine_version}[0]

Get FortiGate Hardware status
    [Documentation]    return is list of hardware status
    @{cmd}=    run keyword if    "${FGT_VDOM_STATUS}"!="disable"    create list    config global    get hardware status    end
    ...    ELSE    create list    get hardware status
    #if vdom is enabled, the last second item of list is Security information
    ${index_of_list}=    run keyword if    "${FGT_VDOM_STATUS}"!="disable"    set variable    ${-2}
    ...    ELSE        set variable    ${-1}
    @{response}=    Execute CLI commands on FortiGate Via Terminal Server    commands=${cmd}
    ${asic_version}=    Get Regexp matches    @{response}[${index_of_list}]    ASIC version: (\\S*).*${FGT_CLI_NEWLINE}    1
    [return]    @{asic_version}[0]

init json file
    Define Running Time as global variable
    Define Running Time FOR JSON FILE as global variable
    ${fgt_basic_dic}=    create dictionary    SN=${FGT_SN}    avdef=${FGT_AV_DEF}    aveng=${FGT_AV_ENG}    bios=${FGT_BIOS}
    ...    build=${FGT_BUILD}    branch_name=${BRANCH_NAME}    ipsdef=${FGT_IPS_DEF}    ipseng=${FGT_IPS_ENG}    platform_id=${FGT_TYPE}    pltgen=${FGT_GENERATION}
    ...    total=${0}    time=${RUNNING_TIME_JSON}    jenkins_id=${JENKINS_ID}    jenkins_url=${JENKINS_URL}    results=@{EMPTY}
    write_json_to_file    ${fgt_basic_dic}    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}.json
    write_json_to_file    ${fgt_basic_dic}    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}_PASS.json
    write_json_to_file    ${fgt_basic_dic}    ${REPORT_FILE_JSON_PATH}${/}test_report_${RUNNING_TIME}_FAIL.json


convert time to seconds
    [Arguments]    ${timestamp}
    # ${length}=    get length    ${timestamp}
    # ${time}=    Strip String    @{timestamp}[0]
    # ${am_pm}=    run keyword if    "${length}"=="2"    Strip String    @{timestamp}[1]
    Should Match Regexp    ${timestamp}    \\d{1,2}:\\d{1,2}:\\d{1,2}
    ${tmp_list_of_tuple}=    get Regexp matches    ${timestamp}    (\\d{1,2}):(\\d{1,2}):(\\d{1,2})    1    2    3
    ${tmp_list}=    set variable    @{tmp_list_of_tuple}[0]
    ${hour}=    Convert To Integer    @{tmp_list}[0]
    ${minute}=    Convert To Integer    @{tmp_list}[1]
    ${second}=    Convert To Integer    @{tmp_list}[2]
    ${time_in_seconds}=    evaluate    ${hour}*3600+${minute}*60+${second}
    [return]    ${time_in_seconds}

wait until fgt begin to reboot
    [Arguments]    ${access_ip}
    wait until keyword succeeds    18x    10s    FGT should not be pingable    ${access_ip}

wait until fgt come to be accessible
    [Arguments]    ${access_ip}
    wait until keyword succeeds    30x    10s    FGT should be pingable    ${access_ip}

ping ip address and return loss rate
    [Arguments]    ${access_ip}    ${times}=3
    #set ping cmd format according to OS type
    ${ping_cmd}=    run Keyword if    "${OS_TYPE}"=="Windows"    set variable    ping ${access_ip} -n ${times}
    ...    ELSE IF    "${OS_TYPE}"=="Linux"    set variable    ping ${access_ip} -c ${times}
    ...    ELSE IF    "${OS_TYPE}"=="Darwin"    set variable    ping ${access_ip} -c ${times}
    ...    ELSE    set variable    ping ${access_ip} -n ${times}    
    #set regular expression of ping reponse  according to OS type
    ${str_response_unreachable}    set variable    unreachable
    ${re_response_of_ping}=    run Keyword if    "${OS_TYPE}"=="Windows"    set variable    \\((\\d{1,3})% loss\\)
    ...    ELSE IF    "${OS_TYPE}"=="Linux"    set variable    received, (\\d{1,3})% packet loss
    ...    ELSE IF    "${OS_TYPE}"=="Darwin"    set variable    received, (\\d{1,3}.\\d)% packet loss
    ...    ELSE    set variable    \\((\\d{1,3})% loss\\)  
    ${rc}    ${output}=    run and return rc and output    ${ping_cmd}
    ${if_unreachable}=    run keyword and return status    should contain    ${output}    ${str_response_unreachable}
    ${tmp_list}=    get Regexp matches    ${output}    ${re_response_of_ping}    1
    Return From Keyword if    "${if_unreachable}"=="True"    ${-1}    @{tmp_list}[0]
    [return]    ${rc}    @{tmp_list}[0]

FGT should be pingable
    [Arguments]    ${access_ip}
    ${rc}    ${loss_rate}=    ping ip address and return loss rate    ${access_ip}
    should be equal as Numbers    ${rc}    ${0}
    should be equal as Numbers    ${loss_rate}    ${0}

FGT should not be pingable
    [Arguments]    ${access_ip}
    ${rc}    ${loss_rate}=    ping ip address and return loss rate    ${access_ip}
    should not be equal as Numbers    ${rc}    ${0}
    should not be equal as Numbers    ${loss_rate}    ${0}

get all selenium config
    ${timeout}=    Get Selenium Timeout
    ${wait}=     Get Selenium Implicit Wait
    ${speed}=     Get Selenium Speed
    [Return]    ${timeout}    ${wait}    ${speed}


Wait Until FortiAnalyzer is connected
    Wait Until Keyword Succeeds    3x    5s    FortiAnalyzer should be connected

FortiAnalyzer should be connected
    @{cmd}=    create list    execute log fortianalyzer test-connectivity
    @{responses}=    Execute CLI commands on FortiGate Via Direct Telnet    commands=${cmd}
    ${response}=    set variable    @{responses}[-1]
    should match regexp    ${response}    (?m)Registration: registered\\r\\nConnection: allow

Wait Until FortiGuard is connected
    Wait Until Keyword Succeeds    3x    5s    FortiGuard should be connected

FortiGuard should be connected
    @{cmd}=    create list    execute log fortiguard test-connectivity
    @{responses}=    Execute CLI commands on FortiGate Via Direct Telnet    commands=${cmd}
    ${response}=    set variable    @{responses}[-1]
    should match regexp    ${response}    FortiGuard Contract Expiry Date

Current Operating System type
    ##Return can be "Linux", "Windows"
    ${os}=    evaluate    platform.system()    platform
    set global variable    ${OS_TYPE}    ${os}
    [Return]    ${os}

If Text Is Locator
    [Arguments]    ${text}
    ${pattern}=    set variable    ^(?:id|name|identifier|class|tag|xpath|css|dom|link|partial link|sizzle|jquery|default)\\s?[:=]\\s?.*$
    ${status}=    run keyword and return status    should match regexp    ${text}    ${pattern}
    [Return]    ${status}


wait Until page contains element regardless of iframe
    [Arguments]    ${element}
    ${locator_iframe}=    set variable    xpath://iframe
    ${num_locator}=    Get Element Count    ${locator_iframe}
    ${if_contains}=    run keyword and return status    wait Until page contains element    ${element}
    Return From Keyword If    "${if_contains}"=="${True}"    PASS
    :FOR    ${index}    IN RANGE    1    ${num_locator}+1
    \    ${locator_cur_iframe}=    set variable    ${locator_iframe}\[${index}]
    \    select frame    ${locator_cur_iframe}
    \    ${if_contains}=    run keyword and return status    wait Until page contains element    ${element}
    \    Return From Keyword If    "${if_contains}"=="${True}"    PASS
    \    unselect frame
    Fail    page doesn't contain element including all iFrames
    [teardown]    run keyword if    "${num_locator}"!="${0}"    unselect frame

Wait Until Element Is Visible regardless of iframe
    [Arguments]    ${element}
    ${locator_iframe}=    set variable    xpath://iframe
    ${num_locator}=    Get Element Count    ${locator_iframe}
    ${if_contains}=    run keyword and return status    Wait Until Element Is Visible    ${element}
    Return From Keyword If    "${if_contains}"=="${True}"    PASS
    :FOR    ${index}    IN RANGE    1    ${num_locator}+1
    \    ${locator_cur_iframe}=    set variable    ${locator_iframe}\[${index}]
    \    select frame    ${locator_cur_iframe}
    \    ${if_contains}=    run keyword and return status    Wait Until Element Is Visible    ${element}
    \    Return From Keyword If    "${if_contains}"=="${True}"    PASS
    \    unselect frame
    Fail    element isn't visible on page including all iFrames
    [teardown]    run keyword if    "${num_locator}"!="${0}"    unselect frame

Wait Until Page Contains regardless of iframe
    [Arguments]    ${text}
    ${locator_iframe}=    set variable    xpath://iframe
    ${num_locator}=    Get Element Count    ${locator_iframe}
    ${if_contains}=    run keyword and return status    Wait Until Page Contains    ${text}
    Return From Keyword If    "${if_contains}"=="${True}"    PASS
    :FOR    ${index}    IN RANGE    1    ${num_locator}+1
    \    ${locator_cur_iframe}=    set variable    ${locator_iframe}\[${index}]
    \    select frame    ${locator_cur_iframe}
    \    ${if_contains}=    run keyword and return status    Wait Until Page Contains    ${text}
    \    Return From Keyword If    "${if_contains}"=="${True}"    PASS
    \    unselect frame
    Fail    page doesn't contain text including all iFrames
    [teardown]    run keyword if    "${num_locator}"!="${0}"    unselect frame

Open url in new Tab
    [Arguments]    ${url}
    ${excludes}=    Get Window Handles
    Execute Javascript    window.open()
    ${old_handle}=    Wait Until Keyword Succeeds    1min    3 sec    Select Window    ${excludes}
    Go to    ${url}
    Get Window Handles
    [Return]    ${old_handle}

clean up on fortigate GUI
    run keyword and ignore error    Logout FortiGate
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close all browsers

clean up on SSLVPN GUI
    run keyword and ignore error    Logout SSLVPN Portal
    run keyword and ignore error    Delete All Cookies
    run keyword and ignore error    close all browsers


${operation} regardless of iframe: ${element}
    # [Arguments]    ${element}
    [Documentation]    support all "wait until keywords"
    ${locator_iframe}=    set variable    xpath://iframe
    ${num_locator}=    Get Element Count    ${locator_iframe}
    ${if_contains}=    run keyword and return status    ${operation}    ${element}
    Return From Keyword If    "${if_contains}"=="${True}"    PASS
    :FOR    ${index}    IN RANGE    1    ${num_locator}+1
    \    ${locator_cur_iframe}=    set variable    ${locator_iframe}\[${index}]
    \    select frame    ${locator_cur_iframe}
    \    ${if_contains}=    run keyword and return status    ${operation}    ${element}
    \    Return From Keyword If    "${if_contains}"=="${True}"    PASS
    \    unselect frame
    Fail    fail to ${operation} including all iFrames
    [teardown]    run keyword if    "${num_locator}"!="${0}"    unselect frame


Align FortiGates
    [Documentation]  This Keyword is to remove hardware specified configuration i.e. default interfaces, default routes
    ...    These configuration is created by default after factory reset, which varies among different FortiGates.
    ...    To keep all setting setups aligned among different Fortigate Hardwares, this keyword is used to remove these 
    ...    specific setings. The Hardware type is from global variable ${FGT_TYPE}. Use don't need to specify hardward
    ...    in this keyword. This keyword uses CLI files to remove default settings. 
    ...    CLI files are created under folder ${HOME}/config/cli with Hardware types in file names. i.e. FGT_300D_cli.txt
    ${if_cli_file_exist}=    run keyword and return status    OperatingSystem.File Should Exist    ${FGT_CLI_FILE_DIR}${/}${FGT_TYPE}_cli.txt
    Run keyword If    not ${if_cli_file_exist}    Log    No Hardware Specific CLI files, therefore it's uncessary to remove default settings.
    ...    ELSE    Run Cli commands in File on Terminal Server    ${FGT_CLI_FILE_DIR}${/}${FGT_TYPE}_cli.txt


Convert List to String
    [Documentation]    Turn Items of List into a String with specified separator. Example: [1,2,'a']->'12a'
    [Arguments]    ${list}    ${separator}=${EMPTY}
    ${length}=    Get Length    ${list}
    ${string}=    Set Variable    ${EMPTY}
    :FOR    ${index}    IN RANGE    ${length}
    \    ${string}=    set variable    ${string}${separator}@{list}[${index}]
    Log    ${string}
    [Return]    ${string}


Log CLI To File
    [Documentation]    Log CLI execution details to file
    [Arguments]    ${device}    ${connection_type}    ${address}    ${port}    ${responses}   ${newline}=\r\n
    #judge if global variable ${RUNNING_TIME} has been defined. If not, define it globally.
    Define Running Time as global variable
    #write log to file
    ${cur_time}=    Get Time
    ${cli_details}=    Set variable    ${newline}${newline}=== Connection Details: ===${newline}== Device: ${device}, Connection Type: ${connection_type}, IP Address: ${address}, Port: ${port}, Time: ${cur_time} ==${newline}${newline}
    ${cli_log}=    Convert List to String    ${responses}
    ${log}=    set variable    ${cli_details}${cli_log}
    Append to file     ${FGT_CLI_LOG_DIR}${/}cli_log_${RUNNING_TIME}.txt    ${log}

Define Running Time as global variable
    #judge if global variable ${RUNNING_TIME} has been defined. If not, define it globally.
    ${if_exist}=    Run keyword and return status    Variable Should Exist    ${RUNNING_TIME}
    @{runing_time}=    Get Time    yearmonthdayhourminsec
    Run keyword if    not ${if_exist}    Set Global Variable    ${RUNNING_TIME}     @{runing_time}[0]@{runing_time}[1]@{runing_time}[2]@{runing_time}[3]@{runing_time}[4]@{runing_time}[5]

Define Running Time FOR JSON FILE as global variable
    #judge if global variable ${RUNNING_TIME} has been defined. If not, define it globally.
    ${if_exist}=    Run keyword and return status    Variable Should Exist    ${RUNNING_TIME_JSON}
    ${runing_time_json}=    Get Time
    Run keyword if    not ${if_exist}    Set Global Variable    ${RUNNING_TIME_JSON}     ${runing_time_json}

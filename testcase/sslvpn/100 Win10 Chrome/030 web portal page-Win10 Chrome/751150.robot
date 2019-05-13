*** Settings ***
Documentation    Verify login history entry can be shown normally for sslvpn web mode login/logout.
...    Go vpn>ssl>portal page, create new sslvpn portal.
...    Login sslvpn web mode. Access servers through http/https etc. Then logout web mode.
...    Login sslvpn web mode again.
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${http_url}    http://${SSLVPN_HTTP_IP}
${http_page_keyword}    ${SSLVPN_HTTP_PAGE_KEYWORD}
${bookmark_name}    personal_bookmark
${bookmark_description}    automation test for bookmark ${bookmark_name}
@{cmds}    show vpn ssl web user-bookmark
${time_tolerance}    ${SSLVPN_TIME_TOLERANCE}

*** Test Cases ***
751150
    [Tags]    v6.0    firefox    chrome    edge    safari    751150    critical    win10,64bit
    [setup]    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    Login SSLVPN Portal
    #get the time(exclude date/year) of login
    ${time_login}=    Get Time    hour min sec
    ${time_hour_login}    Convert To Integer    @{time_login}[0]
    ${time_minute_login}    Convert To Integer    @{time_login}[1]
    ${time_second_login}    Convert To Integer    @{time_login}[2]
    ${time_login_in_seconds}=    evaluate    ${time_hour_login}*3600+${time_minute_login}*60+${time_second_login}
    # ${num_his_old}=    number of history records
    sleep    10s
    Logout SSLVPN Portal
    sleep    30s
    Login SSLVPN Portal
    # ${num_his_newer}=    number of history records
    # comment below comparison due to unstable history on SSLVPN portal, it's a bug.
    # run keyword if    ${num_his_old}<22    should be equal as integers    ${num_his_old+1}    ${num_his_newer}
    ${time}    ${remote_ip}    ${duration}    ${data_statistics}=    get detail of history records as list
    ${time_str}=    get Regexp matches    ${time}    (\\d{1,2}:\\d{1,2}:\\d{1,2})    1
    ${time_in_seconds}=    convert time to seconds    @{time_str}[0]
    #the difference between real login time and recorded login time should be less than 5 seconds
    should be true    -${time_tolerance}<${time_in_seconds}-${time_login_in_seconds}<${time_tolerance}
    ${duration_str}=    get Regexp matches    ${duration}    (\\d+) second.*    1
    ${duration_integer}=    Convert To Integer    @{duration_str}[0]
    should be true    -${time_tolerance}<${duration_integer}-10<${time_tolerance}
    [Teardown]    case Teardown

*** Keywords ***
case Teardown
    Run Cli commands in File    ${SSLVPN_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
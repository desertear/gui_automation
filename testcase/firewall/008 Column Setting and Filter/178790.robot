*** Settings ***
Documentation    Verify Column setting is working on Section view
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI
Test Timeout    15 min

*** Variables ***
@{columns1}    Log    Comments    Name    Schedule    Source Address    Users    Active Sessions    ID    nTurbo Packets    Software Bytes    SSL Inspection
# 546953
#@{columns2}    Bytes    Destination    Groups    NAT    Security Profiles    SPU Bytes    VPN Tunnel    Application Control    DNS Filter    IPS    Packets    Software Packets    Status
@{columns2}    Bytes    Destination    Groups    NAT    Security Profiles    SPU Bytes    VPN Tunnel    Application Control    IPS    Packets    Software Packets    Status
#@{columns3}    Action    Destination Address    Hit Count    nTurbo Bytes    Service    SPU Packets    Web Filter    AV    First Used    Last Used    Profile Group    Source
@{columns3}    Action    Destination Address    Hit Count    nTurbo Bytes    Service    SPU Packets    Web Filter    AV    First Used    Last Used    Source
#@{full_columns}    Action    Active Sessions    Application Control    AV    Bytes    Comments    Destination
#    ...    Destination Address    DNS Filter    First Used    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Log    Name
#    ...    NAT    nTurbo Bytes    nTurbo Packets    Packets    Profile Group    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
#    ...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel    Web Filter
@{full_columns}    Action    Active Sessions    Application Control    AV    Bytes    Comments    Destination
    ...    Destination Address    First Used    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Log    Name
    ...    NAT    nTurbo Bytes    nTurbo Packets    Packets    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    ...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    Users    VPN Tunnel    Web Filter

*** Test Cases ***
178790
    [Documentation]    
    [Tags]    chrome    178790    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}
    Go to policy and objects

    #Step 1: Test ipv4 policy
    Log    ==================== Step 1: Test ipv4 policy ====================
    Go to IPv4 policy
    View By Interface Pair View
    Select Policy Table Columns    ${full_columns}    4    ${False}
    ${status}=    Check If Columns are Displayed in Policy Table    ${full_columns}
    Should be True    ${status}    
    Select Policy Table Columns    ${columns1}    4    ${False}
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns1}    4
    Should be True    ${status} 
    Select Policy Table Columns    ${columns2}    4    ${False}
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns2}    4
    Should be True    ${status} 
    Select Policy Table Columns    ${columns3}    4    ${False}
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns3}    4
    Should be True    ${status}
    Reset Policy Table Columns

    #Step 2: Test ipv6 policy
    Log    ==================== Step 2: Test ipv6 policy ====================
    Go to policy and objects
    Go to IPv6 policy
    View By Interface Pair View
    Select Policy Table Columns    ${full_columns}    6    ${False}
    ${status}=    Check If Columns are Displayed in Policy Table    ${full_columns}    6
    Select Policy Table Columns    ${columns1}    6    ${False}
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns1}    6
    Select Policy Table Columns    ${columns2}    6    ${False}
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns2}    6
    Select Policy Table Columns    ${columns3}    6    ${False}
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns3}    6
    Should be True    ${status}
    Reset Policy Table Columns
    Logout FortiGate
 
*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
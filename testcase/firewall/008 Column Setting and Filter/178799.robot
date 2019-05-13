*** Settings ***
Documentation    Verify column settings works for policies including at least one policy 
...    using profile-group, one using some utm profiles(not all), one is identity-based,
...    one is deny, one is ssl-vpn and one is ipsec policy
Resource    ../fw_resource.robot
Suite Teardown    clean up on fortigate GUI
Test Timeout    15 min

*** Variables ***
@{columns1}    Log    Comments    From    Name    Schedule    Source Address    Users    Active Sessions    ID    nTurbo Packets    Software Bytes    SSL Inspection
#546953
#@{columns2}    Bytes    Destination    Groups    NAT    Security Profiles    SPU Bytes    VPN Tunnel    Application Control    DNS Filter    IPS    Packets    Software Packets    Status
@{columns2}    Bytes    Destination    Groups    NAT    Security Profiles    SPU Bytes    VPN Tunnel    Application Control    IPS    Packets    Software Packets    Status
#@{columns3}    Action    Destination Address    Hit Count    nTurbo Bytes    Service    SPU Packets    Web Filter    AV    First Used    Last Used    Profile Group    Source    To
@{columns3}    Action    Destination Address    Hit Count    nTurbo Bytes    Service    SPU Packets    Web Filter    AV    First Used    Last Used    Source    To
#@{full_columns}    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments    Destination
#    ...    Destination Address    DNS Filter    First Used    From    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
#    ...    NAT    nTurbo Bytes    nTurbo Packets    Packets    Profile Group    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
#    ...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    To    Users    VPN Tunnel
#    ...    Web Filter
@{full_columns}    Log    Bytes    Action    Active Sessions    Application Control    AV    Comments    Destination
    ...    Destination Address    First Used    From    Groups    Hit Count    ID    Inspection Mode    IPS    Last Used    Name
    ...    NAT    nTurbo Bytes    nTurbo Packets    Packets    Protocol Options    Schedule    Security Profiles    Service    Software Bytes
    ...    Software Packets    Source    Source Address    SPU Bytes    SPU Packets    SSL Inspection    Status    To    Users    VPN Tunnel
    ...    Web Filter    

*** Test Cases ***
178799
    [Documentation]    
    [Tags]    chrome    178799    high
    [setup]    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_setup_cli.txt
    [Teardown]    case Teardown
    Login FortiGate
    Go to VDOM    ${FW_TEST_VDOM_NAME_1}

    #Step 1: Test ipv4 policy
    Log    ==================== Step 1: Test ipv4 policy ====================
    Go to policy and objects
    Go to IPv4 policy
    View By Sequence
    Select Policy Table Columns    ${full_columns}    4
    ${status}=    Check If Columns are Displayed in Policy Table    ${full_columns}
    Should be True    ${status}    
    Select Policy Table Columns    ${columns1}    4
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns1}    4
    Should be True    ${status} 
    Select Policy Table Columns    ${columns2}    4
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns2}    4
    Should be True    ${status} 
    Select Policy Table Columns    ${columns3}    4
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns3}    4
    Should be True    ${status}
    Reset Policy Table Columns

    #Step 2: Test ipv6 policy
    Log    ==================== Step 2: Test ipv6 policy ====================
    Go to policy and objects
    Go to IPv6 policy
    View By Sequence
    Select Policy Table Columns    ${full_columns}    6
    ${status}=    Check If Columns are Displayed in Policy Table    ${full_columns}    6
    Select Policy Table Columns    ${columns1}    6
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns1}    6
    Select Policy Table Columns    ${columns2}    6
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns2}    6
    Select Policy Table Columns    ${columns3}    6
    ${status}=    Check If Columns are Displayed in Policy Table    ${columns3}    6
    Should be True    ${status}
    Reset Policy Table Columns
    Logout FortiGate
 
*** Keywords ***
case Teardown
    Run Cli commands in File    ${FW_CLI_FILE_DIR}${/}${TEST NAME}_teardown_cli.txt
    write test result to file    ${CURDIR}
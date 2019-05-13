*** Settings ***
Documentation    Verify that the embedded console top buttons can work
Resource    ../../../system_resource.robot

*** Variables ***
${system_main_gui}
*** Test Cases ***
180638
    [Documentation]    
    [Tags]    v6.0    chrome   180638   critical    win10,64bit    browsers   norun   keyboard
    ##only judge if the embeded console can be connected by different browser, if it does, current case must pass.
    Login FortiGate     browser=ff
    popup embed console
        
    #test the clear console button can clear the embeded cli screen 
    test clear_button

    #fullscreen of embeded console
    ${system_main_gui_local}=    Select Window    Current
    test detach_button
    
    Select Window     ${system_main_gui_local}
    [teardown]    case teardown

*** Keywords ***
case teardown    
    Logout FortiGate
    Close All Browsers
    write test result to file    ${CURDIR}

test clear_button   
   unselect frame
   Wait Until Element Is Visible     ${system_embed_clear_button}   
   click Element    ${system_embed_clear_button}    
   go to embed console
   sleep    5
   Wait Until Element Is Visible   ${system_embed_cursor}
   Unselect Frame

test detach_button
    
    Wait Until Element Is Visible     ${system_embed_detach_button}
    click Element   ${system_embed_detach_button}
    sleep   2
    Select Window   NEW
    sleep    5
    Select Frame    ${system_embed_console_frame}  
    Wait Until Element Is Visible     ${system_embeded_console_connected}
    go_to_global_prompt
    typewrite    ${system_command_get_sys_status}\n
    sleep   2
    

    
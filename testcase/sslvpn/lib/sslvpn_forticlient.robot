*** Settings ***
Documentation     This file contains FortiGate GUI main page operation
# based on forticlient 6.0.3 GA B0155

*** Keywords ***

open forticlient and select profile
    [Arguments]    ${profile}
    SikuliLibrary.Click    icon_forticlient.png
    wait Until Screen Contain    header_forticlient.png    10
    exists    remote_access_forticlient.png    5
    SikuliLibrary.Click    remote_access_forticlient.png

    ${is_exists}=    exists    ${profile}.png    5
    Run keyword if   "${is_exists}"=="False"    select profile    ${profile}

select profile
    [Arguments]    ${profile}
    SikuliLibrary.Click    select_button_forticlient.png
    exists    select_list_forticlient.png    5
    SikuliLibrary.Click    ${profile}.png

fill in username and password
    [Arguments]    ${username}    ${password}
    SikuliLibrary.Click     username_and_input.png
    SikuliLibrary.Input Text    username_and_input.png    ${username}
    SikuliLibrary.Click    password_and_input.png
    SikuliLibrary.Input Text    password_and_input.png    ${password}

connect sslvpn on forticlient
    SikuliLibrary.Click    connect_button.png
    wait Until Screen Contain    successful_connection.png    60

connect sslvpn with limit user login
    SikuliLibrary.Click    connect_button.png
    wait Until Screen Contain    forticlient_multiple_connection_warning.png    60
    SikuliLibrary.Click    forticlient_multiple_connection_process_yes.png
    wait Until Screen Contain    successful_connection.png    60

check client option
    [Arguments]    ${option}
    exists    ${option}.png    10
    SikuliLibrary.Click    ${option}.png

uncheck client option
    [Arguments]    ${option}
    exists    checked_save_password.png    5
    SikuliLibrary.Click    checked_save_password.png
    ${is_checked}=    exists    checked_${option}.png
    Run Keyword If    "${is_checked}"=="True"    SikuliLibrary.Click    checked_${option}.png

connection deny by host check
    [Arguments]    ${hostcheck-error}
    SikuliLibrary.Click    connect_button.png
    # get host check deny warning windows
    wait Until Screen Contain     ${hostcheck-error}    60
    #close warnning windows
    SikuliLibrary.Click in     ${hostcheck-error}    forticlient_host_check_deny_ok.png
    #close forticlient
    SikuliLibrary.Click in     full_header_forticlient.png    close_forticlient.png

logout sslvpn on forticlient
    SikuliLibrary.Click    icon_forticlient.png
    wait Until Screen Contain    header_forticlient.png    10
    exists    remote_access_forticlient.png    5
    SikuliLibrary.Click    remote_access_forticlient.png
    ${if_connected}=    exists    disconnect_button.png    5
    run keyword if    ${if_connected}   SikuliLibrary.Click    disconnect_button.png
    wait Until Screen Contain    connection_down.png    30
    wait Until Screen Contain    header_forticlient.png    10
    Mouse Move    header_forticlient.png
    SikuliLibrary.Click in     full_header_forticlient.png    close_forticlient.png

close forticlient
    SikuliLibrary.Click    icon_forticlient.png
    wait Until Screen Contain    header_forticlient.png    10
    Mouse Move    header_forticlient.png
    SikuliLibrary.Click in     full_header_forticlient.png    close_forticlient.png

reset forticlient profile
    SikuliLibrary.Click    forticlient_connection_setting.png
    wait Until Screen Contain    forticlient_connection_setting_menu.png    5
    SikuliLibrary.Click    forticlient_edit_selected_connection.png
    wait Until Screen Contain    check_server_certificate.png    10
    wait Until Screen Contain    forticlient_edit_save.png    10
    SikuliLibrary.Click    forticlient_edit_save.png
    Mouse Move    header_forticlient.png
    SikuliLibrary.Click in     full_header_forticlient.png    close_forticlient.png

set forticlient dtls
    SikuliLibrary.Click    icon_forticlient.png
    wait Until Screen Contain    unlock_settings.png    10
    SikuliLibrary.Click    unlock_settings.png
    SikuliLibrary.Click    settings.png
    wait Until Screen Contain    prefer_dtls.png    10
    SikuliLibrary.Click    prefer_dtls.png
    SikuliLibrary.Click    remote_access_forticlient.png
    SikuliLibrary.Click in     full_header_forticlient.png    close_forticlient.png

check address is assigned to local pc
    OperatingSystem.run    ipconfig/all>log/sslvpn_address
    ${sslvpn_address}=    OperatingSystem.grep    log/sslvpn_address    10.212.134.200
    [return]    ${sslvpn_address}

check route is added on local pc
    OperatingSystem.run    route print >log/sslvpn_route
    @{new_route}=    OperatingSystem.grep    log/sslvpn_route    10.212.134.200
    [return]    @{new_route}

check ping on local pc
    [Arguments]    ${dst}
    ${status}=    OperatingSystem.run    ping ${dst}
    [return]    ${status}
check http on local pc
    [Arguments]    ${url}    ${keyword}
    open browser    ${url}    browser=Chrome
    wait Until page contains    ${keyword}
    close browser

check fortinet bar on local pc
    [Arguments]    ${url}    ${keyword}    ${image_dir}
    Add Image Path    ${image_dir}
    open browser    ${url}    browser=Chrome
    Run Keyword And Continue On Failure    Maximize Browser Window
    Run Keyword And Continue On Failure    get all selenium config
    wait Until Screen Contain    fortinet_bar.png    10
    close browser

open rdp on local pc
    [Arguments]    ${rdp_server}    ${image_dir}
    Add Image Path    ${image_dir}
    SikuliLibrary.Click    rdp_icon.png
    wait Until Screen Contain    rdp_header.png    10
    SikuliLibrary.Input Text    rdp_computer.png    ${rdp_server}
    exists    rdp_connect_button.png    10
    SikuliLibrary.Click    rdp_connect_button.png
    #exists    select_button_forticlient.png    5
    #SikuliLibrary.Click    rdp_more_choice.png
    #exists    select_button_forticlient.png    5
    #SikuliLibrary.Click    rdp_use_different_account.png
    #SikuliLibrary.Input Text    rdp_username_input.png    ${rdp_username}
    #SikuliLibrary.Click    rdp_password_field.png
    #SikuliLibrary.Input Text    rdp_password_input.png    ${rdp_password}
    #SikuliLibrary.Click    rdp_ok_button.png
    wait Until Screen Contain    rdp_continue.png    10
    SikuliLibrary.Click    rdp_yes_button.png

check rdp on local pc
    [Arguments]    ${image_dir}
    Add Image Path    ${image_dir}
    wait Until Screen Contain    textpad.png    60
    #SikuliLibrary.double Click    textpad.png
    #wait Until Screen Contain    textpad_header.png    5
    #exists    sentence_in_opened_textpad.png    5
    #SikuliLibrary.Click in    left_top_notepad.png    close_notepad.png
    #wait Until Screen not Contain    textpad_header.png    5

    [teardown]    close rdp connection for local pc

close rdp connection for local pc

    SikuliLibrary.Click in    rdp_connection_header.png    rdp_close.png
    ${if_ask_confirm}=    exists    rdp_disconnected_warning.png    10
    run keyword if    "${if_ask_confirm}"=="True"    SikuliLibrary.Click    rdp_disconnect_ok_button.png

winscp download file
    [Arguments]    ${file_image}
    SikuliLibrary.set timeout    600
    SikuliLibrary.Click    winscp_icon.png
    wait Until Screen Contain    winscp_login.png    10
    SikuliLibrary.Click    winscp_login.png
    wait Until Screen Contain     ${file_image}    60
    SikuliLibrary.Click    ${file_image}
    SikuliLibrary.Click    winscp_download.png
    Get Match Score    winscp_complate.png
    wait Until Screen Contain     winscp_complate.png    600
    wait Until Screen Contain     winscp_header.png    5
    SikuliLibrary.Click    winscp_left_top.png
    wait Until Screen Contain     winscp_close.png    5
    SikuliLibrary.Click     winscp_close.png
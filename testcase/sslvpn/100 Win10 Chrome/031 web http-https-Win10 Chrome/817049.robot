*** Settings ***
Documentation    verify through sslvpn web mode visit other public web site has no problem
Resource    ../../sslvpn_resource.robot
Suite Teardown    clean up on SSLVPN GUI

*** Variables ***
##Please only put case level variables here, while global variables should be set in env.robot
${website_url1}    https://www.amazon.ca/
${website_url2}    https://www.canada.ca/en.html
${website_url3}    http://www.cbc.ca/
*** Test Cases ***
817049
    [Tags]    v6.0    chrome    firefox    edge    safari    817049    medium    win10,64bit
    Login SSLVPN Portal
    quick connection of http or https    ${website_url1}    Amazon.ca
    quick connection of http or https    ${website_url2}    Government of Canada
    quick connection of http or https    ${website_url3}    CBC
    [Teardown]    write test result to file    ${CURDIR}

*** Keywords ***


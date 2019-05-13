*** Settings ***
Documentation    Run LENC cases using low crypto license
Resource    ../lenc_resource.robot
Suite Setup    Setup Low Crypto Testing Environment
Suite teardown    clear Low Crypto test data
Test Timeout    5 min
Force Tags    low crypto
*** Variables ***
${original_http_url}    ${FGT_URL}

*** Keywords ***
Setup Low Crypto Testing Environment
    #check if FGT is using LENC license
    @{cmds_check_license}=    create list    get system status | grep "License Status"
    @{responses}=    Execute CLI commands on FortiGate Via Terminal Server    ${cmds_check_license}
    ${responses_str}=    Convert List to String  ${responses}
    should contain    ${responses_str}    Low-Encryption(LENC)
    #apply Low crypto license to it.
    @{cmds_change_license}=    create list    execute crypto-license ${FGT_LOW_CRYPTO_LICENSE}
    Execute CLI commands on FortiGate Via Terminal Server    ${cmds_change_license}    
    set global variable    ${FGT_URL}    https://${FGT_IP_ADDRESS}


clear Low Crypto test data
    #check if FGT is using Low Crypto license
    @{cmds_check_license}=    create list    fnsysctl ls /etc/
    @{responses}=    Execute CLI commands on FortiGate Via Terminal Server    ${cmds_check_license}
    ${responses_str}=    Convert List to String  ${responses}
    ${if_crypto_license}=    Run keyword and return status    should contain    ${responses_str}    low_crypto.key
    #if FGT is using LENC license, apply Factory license to it.
    Run keyword if    ${if_crypto_license}    Burn Image on BIOS    ${LENC_IMAGE_TFTP_SERVER}    ${FGT_VLAN10_IP}    ${LENC_IMAGE_NAME}
    set global variable    ${FGT_URL}    ${original_http_url}
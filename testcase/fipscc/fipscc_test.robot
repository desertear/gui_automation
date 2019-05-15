*** Settings ***
Documentation    FIPSCC testing file
Resource    ./fipscc_resource.robot
Suite Teardown    clean up on fortigate GUI

*** Variables ***
${file1}    C:${/}\Automation${/}tmp${/}fipscc_1024bits.cert.p12
${file2}    C:${/}\Automation${/}tmp${/}fipscc_usb_2048bits.cert.der
${file3}    C:${/}\Automation${/}tmp${/}fipscc_usb_2048bits.key.pem
${file4}    C:${/}\Automation${/}tmp${/}intermediate.cert.pem
${file5}    C:${/}\Automation${/}tmp${/}fipscc_to_revoke.crl.pem
&{crl_dic}    type=HTTP    url=http://172.16.106.38/fipscc1.crl
*** Test Cases ***
fipscc_test
    [Documentation]    
    [Tags]    fipscc_test    #norun
    Login FortiGate
    Go to VDOM  vdom1
    Go to system
    Go to Certificates
    # Import Local Certificate    PKCS #12 Certificate    path_certificate_p12_file=${file1}   password=123456 
    # Check if certificate exists    fipscc_1024bits.cert
    # Import Local Certificate    Certificate    path_certificate_file=${file2}    path_certificate_key_file=${file3}   password=123456 
    # Check if certificate exists    fipscc_usb_2048bits.cert
    # Import CA Certificate    File    ${file4}
    # Check if certificate exists    G_CA_Cert_2
    # Import CA Certificate    Online SCEP    scep_server=http://172.16.106.39/cert/scep
    # Certificate Should Exist    CA_Cert_1
    # Import Remote Certificate    ${file4}
    # Certificate Should Exist    REMOTE_Cert_1
    Import CRL    File Based    ${file5}
    Certificate Should Exist    CRL_1
    Import CRL    Online Updating    ${None}    &{crl_dic}
    Certificate Should Exist    CRL_2
    Certificate Status Should Be    CRL_2    N/A
    Logout FortiGate
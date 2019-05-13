*** Settings ***
Documentation     This file contains common environment variables
Resource    ./env.robot
*** Variables ***

#your LDAP account to login Oriole, you need to change it once you change your ldap password
#If it's called by Jenkins, the Account should be empty
${ORIOLE_ACCOUNT}    maryzhang
#this one can be get from "user profile" after you login Oriole
${ORIOLE_ENCODED_PASSWORD}    Vm1kTlJFTnNTbGxXVVhSS1FtZE5TRlZTTVZGQ1VVRkhVMVl4Vmxoc1pFcFZiRTVTUVVaU1ZsZG5UbEpXYkZKaw==

${TERMINAL_SERVER_IP}    10.1.100.1
${TERMINAL_SERVER_PORT}    23
${FGT_TELNET_PORT_ON_TERMINAL_SERVER}    23
${GLOBAL_REPORT_TO_ORIOLE}    True

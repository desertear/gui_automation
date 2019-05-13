*** Settings ***
Documentation     This file only contains variables related to FGT900D
Resource    ./env.firewall.robot

*** Variables ***
#your LDAP account to login Oriole, you need to change it once you change your ldap password
#If it's called by Jenkins, the Account should be empty
${ORIOLE_ACCOUNT}    ivenlin
#this one can be got from "user profile" after you login Oriole
${ORIOLE_ENCODED_PASSWORD}    Vm1kTlJFTm5jMHhCUmtaS1FtZE5TRlZTTVZGQ1VVRkhVMVl4Vmxoc1pFcFZiRTVTUVVaU1ZsZG5UbEpXYkZKaw==

#FGT Terminal Server configuration
${TERMINAL_SERVER_IP}    172.16.106.179
${TERMINAL_SERVER_PORT}    23
${FGT_TELNET_PORT_ON_TERMINAL_SERVER}    2016

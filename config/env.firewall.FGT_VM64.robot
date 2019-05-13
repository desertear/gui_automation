*** Settings ***
Documentation     This file only contains variables related to FGT VM64
Resource    ./env.firewall.robot

*** Variables ***
#your LDAP account to login Oriole, you need to change it once you change your ldap password
#If it's called by Jenkins, the Account should be empty
${ORIOLE_ACCOUNT}    ivenlin
#this one can be got from "user profile" after you login Oriole
${ORIOLE_ENCODED_PASSWORD}    Vm1kTlJFTm5jMHhCUmtaS1FtZE5TRlZTTVZGQ1VVRkhVMVl4Vmxoc1pFcFZiRTVTUVVaU1ZsZG5UbEpXYkZKaw==
${FGT_CLI_NEWLINE}    \n 
${TERMINAL_SERVER_NEWLINE}    \n
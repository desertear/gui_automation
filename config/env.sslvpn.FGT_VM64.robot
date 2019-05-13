*** Settings ***
Documentation     This file contains common environment variables
Resource    ./env.robot

*** Variables ***

#your LDAP account to login Oriole, you need to change it once you change your ldap password
${ORIOLE_ACCOUNT}    maryzhang
#this one can be get from "user profile" after you login Oriole
${ORIOLE_ENCODED_PASSWORD}    Vm1kTlJFTnNTbGxXVVhSS1FtZE5TRlZTTVZGQ1VVRkhVMVl4Vmxoc1pFcFZiRTVTUVVaU1ZsZG5UbEpXYkZKaw==

${FGT_SN}      FGVM32TM18000022
${FGT_HOSTNAME}    FGVM32TM18000022
${FGT_GENERATION}    Gen1
${FGT_TEST_VERSION}    6.2.0
${FGT_VLAN20_INTERFACE}    port2
${FGT_VLAN30_INTERFACE}    port1
${GENERAL_SERVER}    172.16.200.55
${FGT_CLI_TELNET_CONNECTION_TIMEOUT}   20
${FGT_CLI_NEWLINE}    \n
${TERMINAL_SERVER_NEWLINE}    \n
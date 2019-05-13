*** Settings ***
Documentation     This file contains common environment variables
Resource    ./env.system.robot
*** Variables ***
#below value should be set manually.
${FGT_SN}      FGVM32TM18000022
${FGT_HOSTNAME}    FGVM32TM18000022
${FGT_GENERATION}    Gen1
${FGT_TEST_VERSION}    6.2.0
${FGT_VLAN20_INTERFACE}    port2
${FGT_VLAN30_INTERFACE}    port1
${GENERAL_SERVER}    172.16.200.55
${FGT_CLI_TELNET_CONNECTION_TIMEOUT}   20
#your LDAP account to login Oriole, you need to change it once you change your ldap password
#If it's called by Jenkins, the Account should be empty
${ORIOLE_ACCOUNT}    ali02
#this one can be get from "user profile" after you login Oriole
${ORIOLE_ENCODED_PASSWORD}    VlVGa1UxY3hWVTlXVmtKS1ZWWlZRMEZTTVZGQ1VVRktVMUZhVkVGV1RrcFZiRTVTUVVaU1ZsZG5UbEpXYkZKaw==
${FGT_CLI_NEWLINE}    \n 
${TERMINAL_SERVER_NEWLINE}    \n
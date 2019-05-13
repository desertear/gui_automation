*** Settings ***
Documentation     This file contains environment variables for SYSTEM
Resource    ./system_env.robot
*** Variables ***
### COMON SETTINGS ####
${FGTB_HOSTNAME}    FGVM32TM18000023
${FGT_PORT3_INTERFACE}      port3
${FGT_PORT4_INTERFACE}      port4
${FGTB_PORT3_INTERFACE}     port3
${FGTB_PORT4_INTERFACE}     port4
${FGTB_TERMINAL_SERVER_IP}      10.6.30.222
${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}  23
${SYSTEM_FILE_DOWNLOAD_DIR_PATH}    C:${/}Users${/}devops${/}Downloads
*** Settings ***
Documentation    FIPSCC testing file
Resource    ./fipscc_resource.robot

*** Variables ***
${build_version}    0795
#################Testbed1##################
${TFTP1_SERVER}    10.6.30.55
##FGTA
${FGTA1_HOSTNAME}    FGT3HD3915800800
${FGTA1_TERMINAL_SERVER_IP}    172.16.106.64
${FGTA1_TELNET_PORT_ON_TERMINAL_SERVER}    2015
${FGTA1_FGT_CLI_PROMPT}    ${FGTA1_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTA1_IMAGE_NAME}    FGT_300D-v6-build${build_version}-FORTINET.out
##FGTB
${FGTB1_HOSTNAME}    FGT3HD3916802291
${FGTB1_TERMINAL_SERVER_IP}    172.16.106.64
${FGTB1_TELNET_PORT_ON_TERMINAL_SERVER}    2016
${FGTB1_FGT_CLI_PROMPT}    ${FGTB1_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTB1_IMAGE_NAME}    FGT_300D-v6-build${build_version}-FORTINET.out
##FGTC
${FGTC1_HOSTNAME}    FG080D3914002207
${FGTC1_TERMINAL_SERVER_IP}    172.16.106.64
${FGTC1_TELNET_PORT_ON_TERMINAL_SERVER}    2012
${FGTC1_FGT_CLI_PROMPT}    ${FGTC1_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTC1_IMAGE_NAME}    FGT_80D-v6-build${build_version}-FORTINET.out
##FGTD
${FGTD1_HOSTNAME}    FG140D3G13800889
${FGTD1_TERMINAL_SERVER_IP}    172.16.106.64
${FGTD1_TELNET_PORT_ON_TERMINAL_SERVER}    2009
${FGTD1_FGT_CLI_PROMPT}    ${FGTD1_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTD1_IMAGE_NAME}    FGT_140D-v6-build${build_version}-FORTINET.out
##FGTE--LENC
${FGTE1_HOSTNAME}    FG100D3G15818525
${FGTE1_TERMINAL_SERVER_IP}    172.16.106.64
${FGTE1_TELNET_PORT_ON_TERMINAL_SERVER}    2014
${FGTE1_FGT_CLI_PROMPT}    ${FGTE1_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTE1_IMAGE_NAME}    FGT_100D-v6-build${build_version}-FORTINET.out
##FGTF--LENC
${FGTF1_HOSTNAME}    FG100D3G13827425
${FGTF1_TERMINAL_SERVER_IP}    172.16.106.64
${FGTF1_TELNET_PORT_ON_TERMINAL_SERVER}    2007
${FGTF1_FGT_CLI_PROMPT}    ${FGTF1_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTF1_IMAGE_NAME}    FGT_100D-v6-build${build_version}-FORTINET.out

#################Testbed2##################
${TFTP_SERVER}    10.6.30.55
##FGTA
${FGTA_HOSTNAME}    FG3H1E3917900088
${FGTA_TERMINAL_SERVER_IP}    172.16.106.69
${FGTA_TELNET_PORT_ON_TERMINAL_SERVER}    2003
${FGTA_FGT_CLI_PROMPT}    ${FGTA_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTA_IMAGE_NAME}    FGT_301E-v6-build${build_version}-FORTINET.out
##FGTB
${FGTB_HOSTNAME}    FG3H1E3917900090
${FGTB_TERMINAL_SERVER_IP}    172.16.106.69
${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}    2004
${FGTB_FGT_CLI_PROMPT}    ${FGTB_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTB_IMAGE_NAME}    FGT_301E-v6-build${build_version}-FORTINET.out
##FGTC
${FGTC_HOSTNAME}    FGT80E4Q17002328
${FGTC_TERMINAL_SERVER_IP}    172.16.106.69
${FGTC_TELNET_PORT_ON_TERMINAL_SERVER}    2005
${FGTC_FGT_CLI_PROMPT}    ${FGTC_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTC_IMAGE_NAME}    FGT_80E-v6-build${build_version}-FORTINET.out
##FGTD
${FGTD_HOSTNAME}    FGT80E4Q17001695
${FGTD_TERMINAL_SERVER_IP}    172.16.106.69
${FGTD_TELNET_PORT_ON_TERMINAL_SERVER}    2006
${FGTD_FGT_CLI_PROMPT}    ${FGTD_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTD_IMAGE_NAME}    FGT_80E-v6-build${build_version}-FORTINET.out
##FGTE--LENC
${FGTE_HOSTNAME}    FG140E4Q16000010
${FGTE_TERMINAL_SERVER_IP}    172.16.106.69
${FGTE_TELNET_PORT_ON_TERMINAL_SERVER}    2007
${FGTE_FGT_CLI_PROMPT}    ${FGTE_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTE_IMAGE_NAME}    FGT_140E-v6-build${build_version}-FORTINET.out
##FGTF--LENC
${FGTF_HOSTNAME}    FG140E4Q17000101
${FGTF_TERMINAL_SERVER_IP}    172.16.106.69
${FGTF_TELNET_PORT_ON_TERMINAL_SERVER}    2008
${FGTF_FGT_CLI_PROMPT}    ${FGTF_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTF_IMAGE_NAME}    FGT_140E-v6-build${build_version}-FORTINET.out

#################Testbed1 Rugged##################
${TFTP3_SERVER}    10.6.30.55
##FGTA
${FGTA3_HOSTNAME}    FGR30D3X15000006
${FGTA3_TERMINAL_SERVER_IP}    172.16.106.64
${FGTA3_TELNET_PORT_ON_TERMINAL_SERVER}    2001
${FGTA3_FGT_CLI_PROMPT}    ${FGTA3_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTA3_IMAGE_NAME}    FGR_30D-v6-build${build_version}-FORTINET.out
##FGTB
${FGTB3_HOSTNAME}    FGR35D3X16000002
${FGTB3_TERMINAL_SERVER_IP}    172.16.106.64
${FGTB3_TELNET_PORT_ON_TERMINAL_SERVER}    2006
${FGTB3_FGT_CLI_PROMPT}    ${FGTB3_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTB3_IMAGE_NAME}    FGR_35D-v6-build${build_version}-FORTINET.out
##FGTC
${FGTC3_HOSTNAME}    FGR60D4614000014
${FGTC3_TERMINAL_SERVER_IP}    172.16.106.64
${FGTC3_TELNET_PORT_ON_TERMINAL_SERVER}    2008
${FGTC3_FGT_CLI_PROMPT}    ${FGTC3_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTC3_IMAGE_NAME}    FGR_60D-v6-build${build_version}-FORTINET.out
##FGTD
${FGTD3_HOSTNAME}    FGR90D3114000003
${FGTD3_TERMINAL_SERVER_IP}    172.16.106.64
${FGTD3_TELNET_PORT_ON_TERMINAL_SERVER}    2011
${FGTD3_FGT_CLI_PROMPT}    ${FGTD3_HOSTNAME}.*\\s\#|\\(y/n\\)|\r\n\>|login:|Password:|.*\\(Press 'a' to accept\\):|password:|--More--|again:
${FGTD3_IMAGE_NAME}    FGR_90D-v6-build${build_version}-FORTINET.out

*** Test Cases ***
fipscc_upgrade1
    [Documentation]    
    [Tags]    upgrade_testbed1    norun
    Log to Console    Begin to burn Image On TestBed1\n    
    Log to Console    Begin to burn Image to FGTA\n
    Burn Image on BIOS   ${TFTP1_SERVER}  10.6.30.1  ${FGTA1_IMAGE_NAME}  ${FGTA1_TERMINAL_SERVER_IP}  ${FGTA1_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTA1_FGT_CLI_PROMPT}
    # Log to Console    Begin to burn Image to FGTB\n
    # Burn Image on BIOS   ${TFTP1_SERVER}  10.6.30.2  ${FGTB1_IMAGE_NAME}  ${FGTB1_TERMINAL_SERVER_IP}  ${FGTB1_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTB1_FGT_CLI_PROMPT}
    # Log to Console    Begin to burn Image to FGTC\n
    # Burn Image on BIOS   ${TFTP1_SERVER}  10.6.30.3  ${FGTC1_IMAGE_NAME}  ${FGTC1_TERMINAL_SERVER_IP}  ${FGTC1_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTC1_FGT_CLI_PROMPT}
    # Log to Console    Begin to burn Image to FGTD\n
    # Burn Image on BIOS   ${TFTP1_SERVER}  10.6.30.4  ${FGTD1_IMAGE_NAME}  ${FGTD1_TERMINAL_SERVER_IP}  ${FGTD1_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTD1_FGT_CLI_PROMPT}
    # Log to Console    Begin to burn Image to FGTE\n
    # Burn Image on BIOS   ${TFTP1_SERVER}  10.6.30.5  ${FGTE1_IMAGE_NAME}  ${FGTE1_TERMINAL_SERVER_IP}  ${FGTE1_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTE1_FGT_CLI_PROMPT}
    # Log to Console    Begin to burn Image to FGTF\n
    # Burn Image on BIOS   ${TFTP1_SERVER}  10.6.30.6  ${FGTF1_IMAGE_NAME}  ${FGTF1_TERMINAL_SERVER_IP}  ${FGTF1_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTF1_FGT_CLI_PROMPT}

fipscc_upgrade2
    [Documentation]    
    [Tags]    upgrade_testbed2    norun
    Log to Console    Begin to burn Image On TestBed2\n    
    Log to Console    Begin to burn Image to FGTA\n
    Burn Image on BIOS   ${TFTP_SERVER}  10.6.30.1  ${FGTA_IMAGE_NAME}  ${FGTA_TERMINAL_SERVER_IP}  ${FGTA_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTA_FGT_CLI_PROMPT}
    Log to Console    Begin to burn Image to FGTB\n
    Burn Image on BIOS   ${TFTP_SERVER}  10.6.30.2  ${FGTB_IMAGE_NAME}  ${FGTB_TERMINAL_SERVER_IP}  ${FGTB_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTB_FGT_CLI_PROMPT}
    Log to Console    Begin to burn Image to FGTC\n
    Burn Image on BIOS   ${TFTP_SERVER}  10.6.30.3  ${FGTC_IMAGE_NAME}  ${FGTC_TERMINAL_SERVER_IP}  ${FGTC_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTC_FGT_CLI_PROMPT}
    Log to Console    Begin to burn Image to FGTD\n
    Burn Image on BIOS   ${TFTP_SERVER}  10.6.30.4  ${FGTD_IMAGE_NAME}  ${FGTD_TERMINAL_SERVER_IP}  ${FGTD_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTD_FGT_CLI_PROMPT}
    Log to Console    Begin to burn Image to FGTE\n
    Burn Image on BIOS   ${TFTP_SERVER}  10.6.30.5  ${FGTE_IMAGE_NAME}  ${FGTE_TERMINAL_SERVER_IP}  ${FGTE_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTE_FGT_CLI_PROMPT}
    Log to Console    Begin to burn Image to FGTF\n
    Burn Image on BIOS   ${TFTP_SERVER}  10.6.30.6  ${FGTF_IMAGE_NAME}  ${FGTF_TERMINAL_SERVER_IP}  ${FGTF_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTF_FGT_CLI_PROMPT}


fipscc_upgrade_rugged
    [Documentation]    
    [Tags]    upgrade_testbed1_rugged    norun
    Log to Console    Begin to burn Image On Rugged FGTs TestBed1\n    
    Log to Console    Begin to burn Image to FGTA\n
    Burn Image on BIOS   ${TFTP3_SERVER}  10.6.30.101  ${FGTA3_IMAGE_NAME}  ${FGTA3_TERMINAL_SERVER_IP}  ${FGTA3_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTA3_FGT_CLI_PROMPT}
    Log to Console    Begin to burn Image to FGTB\n
    Burn Image on BIOS   ${TFTP3_SERVER}  10.6.30.103  ${FGTB3_IMAGE_NAME}  ${FGTB3_TERMINAL_SERVER_IP}  ${FGTB3_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTB3_FGT_CLI_PROMPT}
    Log to Console    Begin to burn Image to FGTC\n
    Burn Image on BIOS   ${TFTP3_SERVER}  10.6.30.104  ${FGTC3_IMAGE_NAME}  ${FGTC3_TERMINAL_SERVER_IP}  ${FGTC3_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTC3_FGT_CLI_PROMPT}
    # Log to Console    Begin to burn Image to FGTD\n
    # Burn Image on BIOS   ${TFTP3_SERVER}  10.6.30.105  ${FGTD3_IMAGE_NAME}  ${FGTD3_TERMINAL_SERVER_IP}  ${FGTD3_TELNET_PORT_ON_TERMINAL_SERVER}  ${FGTD3_FGT_CLI_PROMPT}

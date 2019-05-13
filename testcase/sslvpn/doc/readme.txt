preconditions:
1. FTP cases: a directory named "sslvpn_automation" and a file "sslvpn_automation.txt" in FTP root directory
2. RDP cases: a file named "sslvpn_automation.txt" in desktop
3. VNC cases: a file named "sslvpn_automation.txt" in desktop
4. directory in SMB server should be configured. root directory should be as same as defined in ${SSLVPN_SMB_MOST_UPPER_DIR}, and a sub directory "sslvpn_automation" exists under directory "sambashare"
5. some chrome policies(i.e AutoSelectCertificateForUrls) should be set in OS. Install the all registry files(i.e. AutoSelectCertificateForUrls.reg) in folder testcase\sslvpn\config\6.0\testdata.

For how to run and other instructions, please refer to $ROOT_DIR/doc/readme.txt
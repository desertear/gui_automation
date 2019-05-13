preconditions:
0. Please make sure drivers(chromedriver, geckodriver, and MicrosoftWebDriver) are compatiable with browsers(Chrome, Firefox, and Edge). And folders of drivers should be set in system PATH.
1. no port forwarding applies on FortiGate, which means FortiGate's IP address should be uniquely used by this FortiGate. The IP address cannot be shared with other devices.
2. Because Edge cannot support self-signed certificate. Certificate is privided in \config\6.0\certificate which supports typical Vlan10, Vlan20 and Vlan30 IPv4 and IPV6 addresses.
3. Tested Fortigates should be authenticated on FMG and FAZ in advance, if they are used in cases.

How to run scripts:
	cmd to run scripts:
		python -m robot --timestampoutputs --loglevel TRACE:TRACE -v FGT_ENV:env.robot -v SSLVPN_ENV:sslvpn_env.robot -l ./log/log.html -r ./report/report.html -o ./output/output.xml -e norun ./
	where variable VERSION, FGT_ENV, SSLVPN_ENV are mandatory. 
	VERSION means FGT's version, it can either be 6.0 or others versions.
	FGT_ENV and SSLVPN_ENV are env files of FGT and feature SSLVPN respectively.
	"./" must be releative/absolute path of scripts' root directory.
	option '-l', '-r' and '-o' are pathes of log, report, output files.

How to submit test results to Oriole manually:
	1. Get the latest jason file under folder ./result/
	2. Open file ./lib/OrioleOperation.py, find variables username, password, json_file and version.
	3. Set variables username, password, json_file and version to correct one.
	4. Open cmd/shell run the file using Python compiler:
		python .\OrioleOperation.py
	5. You should see "message': 'Success'" which means your results have been submitted to Oriole.

Folder Tree:
	./gui_automation/
	├── config                     		-->folder of configuration that can be used by all scripts of different features.
	│   └── locator                    	-->locator files of FortiGate when firmware version of it is v6.2.x.
	├── doc                        		-->folder for all documents
	├── lib                        		-->folder for all global(no-specified feature) libraries.
	├── log                        		-->folder of robot framework log files.
	├── output                     		-->folder of robot framework output files.
	├── report                     		-->folder of robot framework report files.
	├── result                     		-->folder of txt and json files that can be submitted to Oriole.
	├── run                        		-->folder of running relevant files. i.e. FortiGate config files, Selenium grid running scripts.
	│   ├── config_bakup           		-->folder of Selenium grid running scripts.
	│   └── grid                   		-->folder of Selenium grid running scripts.
	├── screenshot                 		-->folder that stores all screenshots(i.e. web page screenshots,)
	├── sikuli_captured                 -->folder that stores all Sikuli Library relevant files.
	└── testcase	                    -->folder of all testcases
	    ├── fw                      	-->folder of all firewall cases
	    │   ├── 100 FW GUI	
	    │   ├── config	
	    │   └── lib	
	    └── sslvpn                  	-->folder of all SSLVPN cases
	        ├── 100 Win10 Chrome    	-->folder of cases, the structure should be same as that on Oriole
	        ├── 110 win10 FF portal 	-->folder of cases, the structure should be same as that on Oriole
	        ├── config              	-->folder of configuration that only is used by SSLVPN scripts.
	        └── lib                 	-->folder of libraries that only is used by SSLVPN scripts.


tag explanation:
	norun: should not be run at present(i.e. unfinished cases, debug scripts)
	screen_alive: need to keep screen alive to match image desktop using Sikuli 
	preconfig: need to configure OS before running cases, i.e. install certificate, configure how browser select certificate.
	no_grid: it means this case cannot be run on Selenium Grid.
	v6.0: the version of FortiGate that is supported by current case.
	chrome: the browser can be used by current case. It can be chrome, firefox, safari, and edge.
	860899: the case id of current case. it should be defined in Oriole previously.
	high: the priority of current case, it should be same as case's in Oriole. It can be criticial, high, medium, and low.
	win10,64bit: the operating system that current case can be run on. It can be combination of OS: win10, win8, win7, linux or macos, and length of OS instruction set: 32bit or 64 bit.
	ios: Mobile OS that current case can be run on. It can be ios, and andriod.
	special_env: means special environment should be prepared before running case such as OA test account, special server, and special website.

OS compatibility:
	1. All cases are designed under Windows 10 64bit for chrome.

Public Libraries:
	1. Console/Telnet Opeation: http://172.16.106.54/trunk/doc/FGT_CLI.html
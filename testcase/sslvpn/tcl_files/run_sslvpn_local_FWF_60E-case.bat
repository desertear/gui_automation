::Below are debug running
rem python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v FGT_BROWSER:chrome -v SSLVPN_BROWSER:chrome -l ./log.html  -r NONE -o ./output.xml -e norun --suite "030 web portal page-Win10 Chrome" -e screen_aliveORno_grid -i 751150OR751154OR751155OR751156OR751157 ./
::python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v FGT_DESIRED_CAPABILITIES:None -v SSLVPN_DESIRED_CAPABILITIES:None -l ./log.html  -r NONE -o ./output.xml -e norun --suite "050 win10 firefox portal" ./
rem python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v FGT_BROWSER:chrome -v SSLVPN_BROWSER:chrome -l ./log.html  -r NONE -o ./output.xml -e norun --suite "032 web mode-ftp" ./
rem python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -l ./log.html  -r NONE -o ./output.xml -e norun --suite "033 web mode-SMB-CIFS"  ./
rem python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -l ./log.html  -r NONE -o ./output.xml -e norun --suite "034 webmode RDP" ./
rem python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -l ./log.html  -r NONE -o ./output.xml -e norun --suite "035 web mode-VNC" ./

::python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v SSLVPN_BROWSER:firefox -v SSLVPN_REMOTE_URL:http://10.6.30.143:4444/wd/hub -e norun -i 183055  ./
::python -m robot --loglevel TRACE:TRACE -v GLOBAL_REPORT_TO_ORIOLE:True -v VERSION:6.0 -v IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY:False -v IF_REMOVE_SSLVPN_ON_FGT_FINALLY:False -l ./log.html  -r ./report.html -o ./output.xml -e norunORscreen_aliveORno_gridOR797662OR802195OR849665 --suite "100 Win10 Chrome" -i demo ./
rem python -m robot --loglevel TRACE:TRACE -v GLOBAL_REPORT_TO_ORIOLE:False -v VERSION:6.0 -v IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY:CLI -v IF_REMOVE_SSLVPN_ON_FGT_FINALLY:CLI -l ./log.html  -r NONE -o ./output.xml -e norunORdemoORdemo1ORscreen_alive --suite "100 Win10 Chrome" -i 857458 --dryrun ./
rem python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v FGT_BROWSER:chrome -v SSLVPN_BROWSER:chrome -v GLOBAL_REPORT_TO_ORIOLE:True -l ./log.html  -r ./report.html -o ./output.xml -e norun -i 183055 ./
::python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v FGT_DESIRED_CAPABILITIES:None -v SSLVPN_DESIRED_CAPABILITIES:None -l ./log.html  -r NONE -o ./output.xml -e norun --suite "050 win10 firefox portal" ./
rem python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v FGT_BROWSER:firefox -v FGT_REMOTE_URL:http://10.6.30.143:4444/wd/hub -v FGT_RUNNING_PLATFORM:ANY -l ./log.html  -r NONE -o ./output.xml -e norun -i firefoxANDcritical ./
::python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v FGT_BROWSER:edge -v FGT_REMOTE_URL:http://10.6.30.143:4444/wd/hub -v FGT_RUNNING_PLATFORM:ANY -l ./log.html  -r NONE -o ./output.xml -e norun -i demo1 ./

::formal execution:
rem python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v FGT_BROWSER:firefox -v SSLVPN_BROWSER:firefox -v GLOBAL_IF_CONFIG_FGT_FIRSTLY:False -v GLOBAL_IF_REMOVE_FGT_FINALLY:False -l ./log_ff_only.html  -r NONE -o ./output_ff_only.xml -e norun --suite "039 win10 firefox portal" ./
rem python -m robot --loglevel TRACE:TRACE -v VERSION:6.0 -v FGT_DESIRED_CAPABILITIES:None -v SSLVPN_DESIRED_CAPABILITIES:None -v GLOBAL_IF_CONFIG_FGT_FIRSTLY:False -v GLOBAL_IF_REMOVE_FGT_FINALLY:GUI -l ./log.html  -r NONE -o ./output.xml -e norun -i chromeANDwin10,64bit --dryrun ./

rem python -m robot.rebot --merge ./output_ff_only.xml ./output.xml

rem @pause

python -m robot --timestampoutputs --loglevel TRACE:TRACE -v VERSION:6.2 -v FGT_ENV:env.sslvpn.local_FWF_60E.robot -v SSLVPN_ENV:sslvpn_env_local.robot -l ./log/log.html -r ./report/report.html -o ./output/output.xml -e norun -e disk -i 715961 --suite "100 Win10 Chrome" ./ 
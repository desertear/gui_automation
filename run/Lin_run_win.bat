::REM python -m robot  --timestampoutputs --loglevel TRACE:TRACE -v FGT_BROWSER:chrome -v SSLVPN_BROWSER:edge -v VERSION:6.0 -v IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY:GUI -v IF_REMOVE_SSLVPN_ON_FGT_FINALLY:GUI -l ./log/log.html  -r ./report/report.html -o ./output/output.xml -v FGT_ENV:env.robot -v SSLVPN_ENV:sslvpn.robot -e norun -i edge --dryrun C:\sslvpn_automation\script\v600\sslvpnweb:

::debug case:
::python -m robot --loglevel TRACE:TRACE -v FGT_BROWSER:chrome -v SSLVPN_BROWSER:edge -v VERSION:6.0 -v IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY:CLI -v IF_REMOVE_SSLVPN_ON_FGT_FINALLY:False  -v FGT_ENV:env_xyan.robot -v SSLVPN_ENV:sslvpn_xyan_env.robot -l ./log/log.html -r ./report/report.html -o ./output/output.xml -e norun -i 183055 C:\sslvpn_automation\script\v600\sslvpnweb:

::python -m robot --timestampoutputs --loglevel TRACE:TRACE -v FGT_ENV:env_Lin.robot -v APP_ENV:app_env.robot -l ./log/log.html -r ./report/report.html -o ./output/output.xml -i 206119 --dryrun ./
::python -m robot --timestampoutputs --loglevel TRACE:TRACE -v FGT_ENV:env_Lin.robot -v APP_ENV:app_env.robot -l ./log/log.html -r ./report/report.html -o ./output/output.xml -i application ./
python -m robot --timestampoutputs --loglevel TRACE:TRACE -v FGT_ENV:env_Lin.robot -v APP_ENV:app_env.robot -l ./log/log.html -r ./report/report.html -o ./output/output.xml -i 206119 ./
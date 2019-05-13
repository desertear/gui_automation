python3 -m robot  --timestampoutputs --loglevel TRACE:TRACE -v FGT_BROWSER:safari -v SSLVPN_BROWSER:safari -v IF_CONFIG_SSLVPN_ON_FGT_FIRSTLY:GUI -v IF_REMOVE_SSLVPN_ON_FGT_FINALLY:GUI -l ./log/log.html  -r ./report/report.html -o ./output/output.xml -v FGT_ENV:env.robot -v SSLVPN_ENV:sslvpn.robot -e norun -i safari ./

#debug case:
# python3 -m robot --loglevel TRACE:TRACE -v FGT_BROWSER:safari -v SSLVPN_BROWSER:safari -v FGT_ENV:env.robot -v SSLVPN_ENV:sslvpn_env.robot -l ./log/log.html -r ./report/report.html -o ./output/output.xml -e norun --dryrun ./
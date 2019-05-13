#! /bin/bash
cur_user=`whoami`
if [ "$cur_user" != "auto" ];then
    echo "Current user is \"$cur_user\", please use user \"auto\" to login instead!"
    exit -1
fi

export DISPLAY=:10.0
HOME_DIR="/home/auto/automation/script/trunk/gui_automation"
export PYTHONPATH=$HOME_DIR:$PYTHONPATH
echo "PYTHONPATH is: $PYTHONPATH"
PYTHON_BIN="/usr/bin/python3"
CURRENT_TIME=`date +%Y%m%d%H%M%S`
FEATURE_ENV="-v FGT_ENV:env.robot -v APP_ENV:app_env.robot -v DLP_ENV:dlp_env.robot -v FIPSCC_ENV:fipscc_env.robot -v FIREWALL_ENV:firewall_env_FGT_900D.robot -v FORTIVIEW_ENV:fortiview_env.robot -v IPS_ENV:ips_env.robot -v LENC_ENV:lenc_env.robot -v SSLVPN_ENV:sslvpn_env.robot -v SYSTEM_ENV:system_env.robot -v USER_ENV:user_env.robot -v WEBFILTER_ENV:webfilter_env.robot -v WANOPT_ENV:wanopt_env.robot -v VOIP_ENV:voip_env.robot"
LOG_OPT="--loglevel TRACE:TRACE -l $HOME_DIR/log/log.html -r $HOME_DIR/report/report.html -o $HOME_DIR/output/output.xml"
TAG="-e norun"
FEATURE_TAGS="ApplicationORDLPORFIPSCCORFIREWALLORFORTIVIEWORIPSORLENCORPERFORMANCEORSSLVPNORSYSTEMORUSERORWEBFILTERORWANOPTORVOIP"
OTHER_OPTS="--console dotted -M Time:$CURRENT_TIME --suitestatlevel 3 --tagstatinclude $FEATURE_TAGS"
CUR_REVISION=`svn info $HOME_DIR|grep "Last Changed Rev"|sed -e "s/Last Changed Rev: //"`
LATEST_REVISION=`svn info -r HEAD $HOME_DIR|grep "Last Changed Rev"|sed -e "s/Last Changed Rev: //"`
CMD="$PYTHON_BIN -m robot $LOG_OPT $FEATURE_ENV $TAG $OTHER_OPTS --dryrun $HOME_DIR"

if [ $CUR_REVISION -lt $LATEST_REVISION ];then
    echo -e "Updating scripts from SVN server:\n"
    svn update $HOME_DIR
    echo -e "Running scripts with command:\n $CMD"
    $CMD
else
    echo "There is no update from SVN server"
fi
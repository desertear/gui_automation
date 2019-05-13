#!/usr/bin/python3
# encoding: utf-8
'''
This module is for FortiGate related functions
'''
import json
import sys
from pprint import pprint
import requests
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
import logging
logger = logging.getLogger(__name__)
import telnetlib
from lib.terserver import TerminalServer
# from lib.myexception import *
# from utils.util import prt_fix_width, is_ipv4_addr
# from lib.settings import SOCK_MAX_TIMEOUT_TIMER as FGT_WAIT_TIMER
import re
import time
UNIVERSAL_REG = r'Password: $|login\: $| [>#\$:] $|\(y/n\)$|\(yes/no\)|\[Y/N\]\?|to accept\)\: $'
FGT_WAIT_TIMER = 3
FGT_EXP_LST = [r' #',                         # super admin login
               r'\.\.\. Open$',                  # terminal server need a CRLF to
               r'login\: $', r'Admin\:',       # admin login
               r'Password: $',                 # need to input password
               r'\(y/n\)$', r'\(yes/no\)', r'\[Y/N\]\?',     # need to input
               r'\[confirm\]',                # confirmation for down
               r'to accept\)\: ',               # disclaimer needs to be accepted
               r' \$ $', r'> $'                  # non-super admin login
               ]

FGT_EXP_PATTERN = [re.compile(exp.encode()) for exp in FGT_EXP_LST]
FGT_DEF_ADMIN = 'admin'
FGT_DEF_PWD = ''
DEF_CMD_DELAY = 0.02
FGT_WAIT_CPU_INFO_TIMER = 10
DIAG_EXE_CLI_SKIP = ['REBOOT', 'FACTORYRESET', 'SHUT']


class FortiGate(object):
    '''
    Script will start a session by login into the FGT
    All subsequent calls will use the session's cookies and CSRF token
    If there is an access_token, token will be always have high priority then regular admin login
    '''

    def __init__(self):
        '''
        initialize a FortiGate object, with an access IP, port and protocol
        '''
        tmp = "\n{} fortigate.FortiGate.__init__\n"
        logger.debug(tmp.format('In'))
        self.management_vdom = None
        self.management_ip = None
        self.management_int = None
        self.bios_version = '00000000'
        self.branch_point = '0000'
        self.fos_version = 'build0000'
        self.build = '0000'
        self.attr = {}
        self.var = []
        self.dvar = {}
        self.user = FGT_DEF_ADMIN
        self.password = FGT_DEF_PWD
        # self.build = None
        #self.version = None
        self.serial = 'FGXXXXXXXXXXXXX'
        self.antivirus = None
        self.antiv_eng = None
        self.ips_eng = None
        self.ips = None
        self.malicious_urls = None
        self.appctrl = None
        self.botnet_ip = None
        self.botnet_domain = None
        self.mobile_malware = None
        self.internet_service_db = None
        self.device_os_id = None
        self.web_filtering = None
        self.antispam = None
        self.industrial_db = None
        self.model_name = 'FortiGate-xxxxx'
        self.model_number = None
        self.host_name = None
        self.model = None
        self.vdom_enable = False
        self.console = None
        self.daemon_killed_info = ''
        self.daemon_crashed_log = ''
        self.conserve_log = ''
        self.crashlog = ''
        self.burn_ip = ''
        self.upd_ver = {}
        self.verbosity = True
        logger.debug(tmp.format('Out'))

    def __str__(self):
        '''
        for print FortiGate Object
        '''
        # msg = "VDOM: %s" % ('Enable' if self.vdom_enable else'Disable')
        tmp = '{}: {}\n'
        ver_info = ''
        for k, v in self.upd_ver.items():
            ver_info += tmp.format(k, v)
        if not ver_info:
            ver_info = 'NA'
        info = [self.model_name, self.fos_version, self.serial,
                self.bios_version, self.branch_point]  # , msg]
        ret = "{0}\n\n{1}\n{2}\n{1}\n\n".format(
            ', '.join(info), '-' * 40, ver_info)
        return ret

    def set_burnip(self, ipaddr):
        sname = "fortigate.FortiGate.set_burnip"
        logger.debug("\nIn {}, 'ipaddr':'{}'\n".format(sname, ipaddr))
        if is_ipv4_addr(ipaddr):
            self.burn_ip = ipaddr
        else:
            msg = "\nError, wrong IP address '%s' !!!\n" % ipaddr
            # print(msg)
            logger.error(msg)
        logger.debug("\nOut %s\n" % sname)

    def set_console(self, console):
        sname = "fortigate.FortiGate.set_console"
        msg = "\nIn {}, 'console':'{}'\n".format(sname, str(console))
        logger.debug(msg)
        self.console = console
        logger.debug("\nOut %s\n" % sname)

    def set_variables(self, variable_dict):
        '''
        change variable_dict to be a sorted by key length to a list,
        longer ones to shorter ones
        '''
        sname = "fortigate.FortiGate.set_variables"
        msg = "\nIn {}, 'variable_dict':'{}'\n".format(
            sname, str(variable_dict))
        logger.debug(msg)
        if isinstance(variable_dict, dict) is False:
            var_dict = dict(variable_dict)
        else:
            var_dict = variable_dict
        self.dvar = var_dict
        sorted_var = list(var_dict.keys())
        # print(sorted_var)
        sorted_var.sort(key=len, reverse=True)
        for key in sorted_var:
            # print(key, var_dict[key])
            self.var.append((key, var_dict[key]))
        # print(self.var)
        msg = "\nOut {}, return:'{}'\n".format(sname, str(self.var))
        logger.debug(msg)
        return self.var

    def add_var(self, var, value):
        '''
        add a variable to env, this is not same
        '''
        sname = "fortigate.FortiGate.add_var"
        tmp = "\nIn {}, 'var':'{}', 'value':'{}'\n"
        logger.debug(tmp.format(sname, var, str(value)))
        index = 0
        temp = "\nVariable replacement happened!" \
            + " previous variable '{}' vlaue changed from '{}' to '{}'\n"
        self.dvar[var] = value
        for key, val in self.var:
            if len(var) > len(key):
                # find the place to insert
                self.var.insert(index, (var, value))
                break
            else:
                if key == var:
                    # if variable existed, then replace the value
                    logger.info(temp.format(key, val, value))
                    self.var[index] = (key, value)
                    break
            index += 1
        if index >= len(self.var):
            # all the existed variable's lenght is longer then the new one
            msg = "\nNew varibale {} / {} is added to self.var dictionary!"
            self.var.append((var, value))
            logger.info(msg.format(var, value))
        logger.debug("\nOut %s\n" % sname)

    def set_admin(self, admin, pwd):
        '''
        set admin and username
        '''
        sname = "fortigate.FortiGate.set_admin"
        tmp = "\nIn {}, 'admin':'{}', 'pwd':'{}'\n"
        logger.debug(tmp.format(sname, admin, '****'))
        self.user = admin
        self.password = pwd
        logger.debug("\nOut %s\n" % sname)

    def dyn_var_repalce(self, req):
        '''
        replace variables in req with varibales in self.var
        '''
        sname = "fortigate.FortiGate.dyn_var_repalce"
        msg = "\nIn {}, 'req':'{}'\n".format(sname, str(req))
        logger.debug(msg)
        tpl = "'{}' is replaced by '{}'"
        if isinstance(req, str):
            result = req
            for (key, val) in self.var:
                if result.find(key) != -1:
                    result = result.replace(key, val)
                    logger.info(tpl.format(key, val))

        elif isinstance(req, dict):
            result = json.dumps(req)
            for (key, val) in self.var:
                result = result.replace(key, val)
            result = json.loads(result)
        else:
            msg = "\n#{}.{}, Error! expect the source data type to be a str or dict, but {} found!"
            logger.info(msg.format(self.__class__.__name__,
                                   self.dyn_var_repalce.__name__, type(req)))
            logger.info("\nWon't do any variable replacement!")
            result = req
        logger.debug("\nOut %s, return:'%s'\n" % (sname, result))
        return result

    def check_upd_ver(self):
        '''
        send 'diag autoupdate version' and then grab all
        the version information(in need_check list) for FGT
        return the version dict
        '''
        sname = "fortigate.FortiGate.check_upd_ver"
        logger.debug("\nIn %s\n" % sname)
        self.vd_ops_bef_cmd()
        self.console.mysend('diag autoupdate version')
        verinfo = self.console.rt_read_until()
        tp = verinfo.splitlines()
        self.vd_ops_aft_cmd()
        need_check = ['AV Engine', 'Virus Definitions', 'Extended set',
                      'Extreme set', 'IPS Attack Engine',
                      'Attack Definitions', 'Attack Extended Definitions',
                      'Application Definitions', 'IPS Malicious URL Database',
                      'Flow-based Virus Definitions', 'Botnet Definitions',
                      'Botnet Domain Database', 'URL White list']
        record_next_ver = False
        cur_db = ''
        self.upd_ver = {}
        for a in tp:
            if a in need_check:
                cur_db = a
                record_next_ver = True
            if record_next_ver and a.upper().find('VERSION:') != -1:
                self.upd_ver[cur_db] = a.upper().strip('VERSION: ')
                record_next_ver = False
                cur_db = ''
        logger.debug("\nOut %s, return:'%s'" % (sname, str(self.upd_ver)))
        return self.upd_ver

    def set_console_access_info(self, connction_info):
        '''
        get console server ip and console line information from 'connection_info'
        '''
        sname = "fortigate.FortiGate.set_console_access_info"
        logger.debug("\nIn %s, 'connction_info':'%s'\n" %
                     (sname, connction_info))
        self.terminal_server_ip = (connction_info.split(" "))[1]
        self.console_line_no = (connction_info.split(" "))[2]
        logger.debug("\nOut %s\n" % sname)

    def reset_crash_info(self):
        '''
        set daemon killed info, daemon crashed log, conserve log and crashlog to be empty
        '''
        tmp = "\n{} fortigate.FortiGate.set_console_access_info\n"
        logger.debug(tmp.format("In"))
        self.daemon_killed_info = ''
        self.daemon_crashed_log = ''
        self.conserve_log = ''
        self.crashlog = ''
        logger.debug(tmp.format("Out"))

    def retr_crash_log(self, clear_flag=False):
        '''
        get crash information and the parse it to get:
        1> how many daemon crash
        2> how many daemon kill
        3> any conserve mode
        '''
        sname = "fortigate.FortiGate.retr_crash_log"
        tmp = "\nIn {}, 'clear_flag':'{}'\n"
        logger.debug(tmp.format(sname, clear_flag))
        self.vd_ops_bef_cmd()
        self.console.mysend('diag debug crashlog read')
        self.crashlog = self.console.rt_read_until()
        self.daemon_killed_info, self.daemon_crashed_log, self.conserve_log = parse_crash_log(
            self.crashlog)
        tmp = '{0:-^70}\n{1}\n{0:-^70}\n'
        daemon_crashed_title = " DAEMON CRASHED LIST "
        conserve_mode_title = ' CONSERVE MODE HISTORY '
        dtmp = '"{}" Cashed "{}" Times '
        ktmp = '"{}" Killed "{}" Times'
        mysep = '\n' + '^' * 70 + '\n' * 2
        all_crash_log = ''
        if len(self.daemon_crashed_log) > 0:
            logger.info(tmp.format('', daemon_crashed_title.center(70, ' ')))
            for daemon_crashed in self.daemon_crashed_log:
                # print daemon_crashed
                if len(self.daemon_crashed_log[daemon_crashed]) > 0:
                    tp = dtmp.format(daemon_crashed, len(
                        self.daemon_crashed_log[daemon_crashed]))
                    all_crash_log = '\n' + tp.center(70) + '\n'
                    all_crash_log += (mysep).join(
                        self.daemon_crashed_log[daemon_crashed])

        daemon_killed_title = " DAEMON KILLED LIST "
        print_title_flag = False
        if len(self.daemon_killed_info) > 0:
            for daemon_killed in self.daemon_killed_info:
                if len(self.daemon_killed_info[daemon_killed]) > 2:
                    if not print_title_flag:
                        tt = tmp.format(
                            '', daemon_killed_title.center(70, ' '))
                        all_crash_log = all_crash_log + tt
                        print_title_flag = True
                    kt = ktmp.format(daemon_killed, len(
                        self.daemon_killed_info[daemon_killed]))
                    all_crash_log += '\n' + kt.center(70) + '\n'
                    all_crash_log += '\n'.join(
                        self.daemon_killed_info[daemon_killed])
        if len(self.conserve_log) > 0:
            ct = tmp.format(
                '', conserve_mode_title.center(70, ' '))
            all_crash_log += '\n' + ct
            all_crash_log += ('\n').join(self.conserve_log)
        if clear_flag:
            self.clear_crash_log()

        self.vd_ops_aft_cmd()
        ret = ''
        if all_crash_log:
            ret = '\n' + all_crash_log + '\n'
        logger.debug("\nOut %s, return:\n'%s'\n" % (sname, ret))
        return ret

    def clear_crash_log(self):
        '''
        clear crash log
        '''
        tmp = "\n{} fortigate.FortiGate.clear_crash_log\n"
        logger.debug(tmp.format("In"))
        self.console.mysend('diag debug crashlog clear')
        self.crashlog = self.console.rt_read_until()
        logger.debug(tmp.format("Out"))

    def check_cpu_idle(self):
        '''
        parse response from 'get system performance status' and then return:
        1> cpu usage
        2> memory usage
        3> original response from FGT
        #special case
        CPU31 states: 16% user 82% system 0% nice 2% idle
        Memory: Data Unavailable
        Average network usage: 196230 / 24182 kbps in 1 minute, 6473 / 6147 kbps in 10 minutes, 5117 / 4859 kbps in 30 minutes
        Average sessions: 1611631 sessions in 1 minute, 1695979 sessions in 10 minutes, 1083588 sessions in 30 minutes
        Average session setup rate: 3642 sessions per second in last 1 minute, 3999 sessions per second in last 10 minutes, 3163 sessions per second in last 30 minutes
        Average NPU sessions: 0 sessions in last 1 minute, 0 sessions in last 10 minutes, 0 sessions in last 30 minutes
        Virus caught: 0 total in 1 minute
        IPS attacks blocked: 0 total in 1 minute
        read uptime error!
        get uptime failed.
        '''
        sname = 'fortigate.FortiGate.check_cpu_idle'
        logger.debug("\nIn {}\n".format(sname))
        perfinfo = 'MISS RETURN FROM FGT'
        self.console.mysend('get system performance status')
        perfinfo = self.console.rt_read_until(timer=FGT_WAIT_CPU_INFO_TIMER)
        cpuidle = 0
        musage = 0
        # if perfinfo and
        for line in perfinfo.splitlines():
            if line.upper().startswith('CPU STATES: '):
                cpuidle = line.split(' nice ')[1].split('% idle')[0]
            elif line.startswith('Memory:'):
                # for v5.6 and later
                musage = line.split('used (')[1].split('%')[0]
            elif line.startswith('Memory states:'):
                # for v5.4
                musage = line.split(': ')[1].split('%')[0]
            else:
                pass
        ret = (100 - int(cpuidle), musage, perfinfo)
        logger.debug("\nOut %s, return:'%s'\n" % (sname, str(ret)))
        return ret

    # def chk_cpu_mem_err(self, perinfo):
    #     '''
    #     Empty
    #     Memory_conserve: -1
    #     No_error: 1
    #     perinfo
    #     #special case
    #     CPU31 states: 16% user 82% system 0% nice 2% idle
    #     Memory: Data Unavailable
    #     Average network usage: 196230 / 24182 kbps in 1 minute, 6473 / 6147 kbps in 10 minutes, 5117 / 4859 kbps in 30 minutes
    #     Average sessions: 1611631 sessions in 1 minute, 1695979 sessions in 10 minutes, 1083588 sessions in 30 minutes
    #     Average session setup rate: 3642 sessions per second in last 1 minute, 3999 sessions per second in last 10 minutes, 3163 sessions per second in last 30 minutes
    #     Average NPU sessions: 0 sessions in last 1 minute, 0 sessions in last 10 minutes, 0 sessions in last 30 minutes
    #     Virus caught: 0 total in 1 minute
    #     IPS attacks blocked: 0 total in 1 minute
    #     read uptime error!
    #     get uptime failed.
    #     '''
    #     if not perinfo:
    #         pass

    def setoutput(self, mode='standard'):
        '''
        set cli output mode to be 'mode', default is 'standard'
        '''
        sname = 'fortigate.FortiGate.setoutput'
        logger.debug("\nIn {}, 'mode':'{}'\n".format(sname, mode))
        self.vd_ops_bef_cmd()
        cmdlst = ['config system console', 'set output %s' % mode, 'end']
        for cmd in cmdlst:
            self.console.mysend(cmd)
            self.console.rt_read_until()
        self.vd_ops_aft_cmd()
        logger.debug("\nOut %s\n" % sname)

    def setintip(self, port, ip, autocheck=False):
        '''
        set interface ip for 'port' with 'ip', 'autocheck' is reserved for later usage
        '''
        sname = 'fortigate.FortiGate.setintip'
        tmp = "\nIn {}, 'port':'{}', 'ip':'{}', 'autocheck':'{}'\n"
        logger.debug(tmp.format(sname, port, ip, autocheck))
        cmdlst = ['config system interface', 'edit %s' %
                  port, 'set mode static', 'set ip %s' % ip, 'end']
        for cmd in cmdlst:
            self.console.mysend(cmd)
            self.console.rt_read_until()
        logger.debug("\nOut %s\n" % sname)

    def reboot(self):
        '''
        reboot FortiGate with CLI, and then login
        '''
        sname = 'fortigate.FortiGate.reboot'
        logger.debug("\nIn {}\n".format(sname))
        self.console.mysend('\x03')
        time.sleep(0.1)
        self.vd_ops_bef_cmd()
        self.console.mysend('execute reboot')
        self.console.rt_read_until('y/n')
        self.console.mysend('y')
        self.console.rt_read_until(' login:')
        self.console.mysend(self.user)
        self.console.rt_read_until('Password:')
        self.console.mysend(self.password)
        self.console.rt_read_until()
        logger.debug("\nOut %s\n" % sname)

    def justreboot(self):
        '''
        reboot FortiGate with CLI
        '''
        sname = 'fortigate.FortiGate.justreboot'
        logger.debug("\nIn {}\n".format(sname))
        time.sleep(0.1)
        # in case the previous command is something like 'show full',
        # then ctrl-c will cause user logged out
        self.console.mysend('\x03')
        time.sleep(0.1)
        self.vd_ops_bef_cmd()
        self.console.mysend('execute reboot')
        self.console.rt_read_until('y/n')
        self.console.mysend('y')
        logger.debug("\nOut %s\n" % sname)

    def console_logout(self):
        sname = 'fortigate.FortiGate.console_logout'
        logger.debug("\nIn {}\n".format(sname))
        self.console.mysend('\x03')
        time.sleep(0.1)
        self.console.mysend('\x04')
        time.sleep(0.1)
        logger.debug("\nOut %s\n" % sname)

    def console_login(self,
                      timeout=FGT_WAIT_TIMER,
                      clearline=False,
                      send_init_lf=True):
        sname = 'fortigate.FortiGate.console_login'
        tmp = "\nIn {}, 'timeout':'{}', 'clear_line':'{}', 'send_init_lf':'{}'\n"
        logger.debug(tmp.format(sname, timeout, clearline, send_init_lf))
        self.console.login(user=self.user,
                           pwd=self.password,
                           timeout=timeout,
                           clearline=clearline,
                           send_init_lf=send_init_lf)
        logger.debug("\nOut %s\n" % sname)

    def factoryreset(self):
        '''
        factory reset FortiGate with CLI, and then login
        '''
        sname = 'fortigate.FortiGate.factoryreset'
        logger.debug("\nIn {}\n".format(sname))
        self.vd_ops_bef_cmd()
        self.console.mysend('execute factoryreset')
        self.console.rt_read_until('y/n')
        self.console.mysend('y')
        self.console.rt_read_until(' login:')
        self.console.mysend(self.user)
        self.console.rt_read_until('Password:')
        self.console.mysend(self.password)
        self.console.rt_read_until()
        self.vdom_enable = False
        logger.debug("\nOut %s\n" % sname)

    def vd_ops_bef_cmd(self):
        sname = 'fortigate.FortiGate.vd_ops_bef_cmd'
        logger.debug("\nIn {}\n".format(sname))
        if self.vdom_enable:
            self.console.mysend('config global')
        logger.debug("\nOut %s\n" % sname)

    def vd_ops_aft_cmd(self):
        sname = 'fortigate.FortiGate.vd_ops_aft_cmd'
        logger.debug("\nIn {}\n".format(sname))
        if self.vdom_enable:
            self.console.mysend('end')
        logger.debug("\nOut %s\n" % sname)

    def upd_vdom_flag(self, force=True):
        sname = 'fortigate.FortiGate.upd_vdom_flag'
        logger.debug("\nIn {}\n".format(sname))
        if force:
            self.console_logout()
            self.console_login()
        self.console.mysend('show full | grep vdom-admin')
        time.sleep(0.2)
        ret = self.console.rt_read_until()
        # print('%"{}"%'.format(ret))
        if ret.find('enable') != -1:
            self.vdom_enable = True
        else:
            self.vdom_enable = False
        logger.debug("\nOut %s\n" % sname)

    def upd_sys_info(self):
        '''
        parse return from 'get system status' to get:
        1> version, branch point
        2> serial number
        3> BIOS
        '''
        sname = 'fortigate.FortiGate.upd_sys_info'
        logger.debug("\nIn {}\n".format(sname))
        self.vd_ops_bef_cmd()
        self.console.mysend('get system status')
        time.sleep(0.2)
        sys_rule = r'System time.*? # '
        sysinfo = self.console.rt_read_until(exp=sys_rule)
        self.vd_ops_aft_cmd()
        logger.debug('\nSystem inofrmation:\n %s \n' % sysinfo)
        for line in sysinfo.splitlines():
            if line.startswith('Version: '):
                info = line.split(' ')
                self.model_name = info[1]
                self.fos_version = info[2]
                self.build = self.fos_version.split(',')[1]
            elif line.startswith('Serial-Number'):
                self.serial = line.split(' ')[1]
            elif line.startswith('BIOS version'):
                self.bios_version = line.split(': ')[1]
            elif line.startswith('Branch point'):
                self.branch_point = line.split(': ')[1]
            else:
                continue
        logger.debug("\nOut %s\n" % sname)

    def purge(self, conf):
        '''
        execute purge after executing cli of 'conf'
        '''
        sname = 'fortigate.FortiGate.purge'
        logger.debug("\nIn {}\n".format(sname))
        self.console.mysend(conf)
        self.console.rt_read_until()
        self.console.mysend('purge')
        self.console.rt_read_until('y/n')
        self.console.mysend('y')
        self.console.rt_read_until()
        self.console.mysend('end')
        logger.debug("\nOut %s\n" % sname)

    def set_vdom_status(self, st):
        sname = 'fortigate.FortiGate.set_vdom_status'
        logger.debug("\nIn {}, 'st':'{}'\n".format(sname, st))
        self.vdom_enable = st
        logger.debug("\nOut %s\n" % sname)

    def burn_image(self, release, build, image_server, debug_flag, tftp_server, sbranch=None):
        '''
        burn image for fortigate, if sbranch is there, means it is a NPI special branch
        '''
        sname = 'fortigate.FortiGate.burn_image'
        tmp = "\nIn{}, 'release': '{}', 'build': '{}', 'image_server': '{}', "\
            + " 'debug_flag':'{}', 'tftp_server':'{}', 'sbranch':'{}'\n"
        msg = tmp.format(sname, release, build, str(
            image_server), debug_flag, tftp_server, sbranch)
        logger.debug(msg)
        enter_bios_ind = r'ress any key to display configuration menu'
        bios_options_ind = r'Enter [CG].*?H:$'
        tftp_server_ind = r'Enter.* TFTP server.* address \[.*?\]:'
        local_ip_ind = r'Enter local.* address \[.*?\]:'
        firmware_ind = r'Enter firmware.* file name \[.*?\]:'
        default_fmw_ind = r'Save as Default firmware/Backup firmware/Run image without saving:\[D/B/R\]\?'
        set_img_ind = [r'Continue:\[Y/N\]\?',  # The default and backup firmware will be lost.
                       r'login\: $'  # get the login page
                       ]
        login_pop = r'login\: $'
        ret = self.console.rt_read_until(enter_bios_ind)
        if ret.find(enter_bios_ind) != -1:
            self.console.mysend(' ')
        else:
            logger.info('Error, did NOT get bios option')
        self.model_name = get_plt_from_boot_info(ret)
        image = image_server.gen_image_name(
            self.model_name, build, release, debug_flag)
        done_flag = image_server.downloadimage(
            self.model_name, build, release, debug_flag, stag=sbranch)
        if not done_flag:
            print("Exit program since image can't be download!!!")
            sys.exit()
        self.console.rt_read_until(bios_options_ind)
        self.console.mysend('g', addenter=False)
        time.sleep(0.5)
        ret = self.console.rt_read_until(tftp_server_ind)
        self.console.mysend(tftp_server)
        time.sleep(0.5)
        self.console.rt_read_until(local_ip_ind)
        self.console.mysend(self.burn_ip)
        time.sleep(0.5)
        self.console.rt_read_until(firmware_ind)
        self.console.mysend(image)
        time.sleep(0.5)
        self.console.rt_read_until(default_fmw_ind)
        self.console.mysend('D')
        time.sleep(0.5)
        index, match, text = self.console.realtime_expect(set_img_ind)
        if index == 0:
            self.console.mysend('y')
            text = self.console.rt_read_until(login_pop)
        if text and text.endswith('login: '):
            self.console.login(self.user, self.password)
        logger.debug("\nOut %s\n" % sname)

    def upgrade(self, build):
        pass

    def login(self):
        '''
        login console
        '''
        sname = 'fortigate.FortiGate.login'
        logger.debug("\nIn {}\n".format(sname))
        self.console.mysend(self.user)
        self.console.rt_read_until('Password: $')
        self.console.mysend(self.password)
        self.console.rt_read_until()
        logger.debug("\nOut %s\n" % sname)

    def waitcpuidle(self, cpuidle, timeout):
        '''
        wait CPU idle until usage is less than 'cpuidle'
        if after 'timeout' still didn't, raise an error of 'WaitTimerTimeOut'
        '''
        sname = 'fortigate.FortiGate.waitcpuidle'
        tmp = "\nIn {}, 'cpuidle':'{}', 'timeout':'{}'\n"
        logger.debug(tmp.format(sname, cpuidle, timeout))
        self.vd_ops_bef_cmd()
        cused, _, _, = self.check_cpu_idle()
        start = time.time()
        timer = 0
        while int(100 - cused) < cpuidle:
            time.sleep(2)
            cused, _, _ = self.check_cpu_idle()
            timer = time.time() - start
            if timer > timeout:
                raise WaitTimerTimeOut(timeout, cpuidle)
        self.vd_ops_aft_cmd()
        logger.debug("\nOut %s\n" % sname)


def get_plt_from_boot_info(bootinfo):
    '''
    Please stand by while rebooting the system.
    Restarting system.
    FortiGate-1200D (15:58-06.23.2016)
    or sometimes return like:
    .........FortiGate-1200D (15:58-06.23.2016)
    '''
    sname = 'fortigate.get_plt_from_boot_info'
    logger.debug("\nIn {}, 'bootinfo':'{}'\n".format(sname, bootinfo))
    model_name = None
    for line in bootinfo.splitlines():
        start = line.find('Forti')
        if start != -1:
            model_name = line[start:].strip().split(' (')[0]
    logger.debug("\nOut %s, return:'%s'\n" % (sname, model_name))
    return model_name


def parse_crash_log(crashlog):
    '''
    the real parse crash log of 'crashlog' to return
    1> daemon_killed_log
    2> crash_dump_log
    3> conserve_mode_log
    '''
    sname = 'fortigate.parse_crash_log'
    logger.debug("\nIn {}, 'crashlog':'{}'\n".format(sname, crashlog))
    crashlog_list = crashlog.splitlines()
    daemon_killed = re.compile(r' the killed daemon is (/.*?)\:')
    daemon_crash = re.compile(r'> application (.*?)\n')
    crash_found_flag = False
    crash_dump = ''
    daemon_killed_log = {}
    crash_dump_log = {}
    conserve_mode_log = []
    crash_time_stamp = ''
    daemon_killed_name = ''
    current_crash_time = ''
    need_to_write_flag = False
    conserve_found_flag = False
    conserve_dump = ''
    for line in crashlog_list:
        # get current log time stamp
        current_crash_time = check_crash_time(line)
        if line.find(' conserve=') != -1:
            conserve_found_flag = True
            cons_time_stamp = check_crash_time(line)
        elif line.find(' the killed daemon is ') != -1:
            dk = re.findall(daemon_killed, line)
            if len(dk) > 0:
                daemon_killed_name = dk[0]
            if daemon_killed_name != '/bin/getty':
                if daemon_killed_name not in daemon_killed_log:
                    daemon_killed_log[daemon_killed_name] = []
                daemon_killed_log[daemon_killed_name].append(line)
        # crash found
        elif line.find(' firmware ') != -1:
            crash_found_flag = True
            need_to_write_flag = True
            # get crash happened time
            crash_time_stamp = check_crash_time(line)
        if conserve_found_flag is True:
            if current_crash_time == cons_time_stamp:
                # print '-> added to crash log dump'
                conserve_dump = conserve_dump + line + '\n'
            else:
                conserve_mode_log.append(conserve_dump)
                conserve_found_flag = False
                conserve_dump = ''
                cons_time_stamp = ''
        # deamon killed case
        # if crash happened, and current log's time stamp is eqaul to the crash time stamp, append it to the crash log string
        if crash_found_flag is True and crash_time_stamp == current_crash_time:
            # print '-> added to crash log dump'
            crash_dump = crash_dump + line + '\n'

        init_flag = False

        # if current log's time stamp is different from the crash log time, then we can save the crash log
        if crash_time_stamp != current_crash_time:
            if crash_found_flag:
                crash_time_stamp = check_crash_time(line)
                application_name = re.findall(daemon_crash, crash_dump)
                if len(application_name) > 0:
                    if application_name[0] not in crash_dump_log:
                        crash_dump_log[application_name[0]] = []
                    crash_dump_log[application_name[0]].append(crash_dump)
                    need_to_write_flag = False
                else:
                    if init_flag is False:
                        crash_dump_log['unknow_application'] = []
                        init_flag = True
                    crash_dump_log['unknow_application'].append(crash_dump)
                    need_to_write_flag = False
                if need_to_write_flag is False:
                    crash_dump = ''
                crash_found_flag = False

    # in case the crash log is ended at the last line, then we also need to save the crash log
    if need_to_write_flag is True:
        application_name = re.findall(daemon_crash, crash_dump)
        if len(application_name) > 0:
            if application_name[0] not in crash_dump_log:
                crash_dump_log[application_name[0]] = []
            crash_dump_log[application_name[0]].append(crash_dump)
            need_to_write_flag = False
        else:
            if init_flag is False:
                crash_dump_log['unknow_application'] = []
                init_flag = True
            crash_dump_log['unknow_application'].append(crash_dump)
            need_to_write_flag = False
    tmp = "\nOut {}, 'daemon_killed_log':'{}', 'crash_dump_log':'{}', 'conserve_mode_log':'{}'\n"
    logger.debug(tmp.format(sname, daemon_killed_log,
                            crash_dump_log, conserve_mode_log))
    return daemon_killed_log, crash_dump_log, conserve_mode_log


def check_crash_time(crash_log_line):
    '''
    grab crash time from a 'crash_log_line
    '''
    sname = 'fortigate.check_crash_time'
    logger.debug("\nIn {}, 'crash_log_line':'{}'\n".format(
        sname, crash_log_line))
    crash_log_cont = crash_log_line.split(' ')
    ret = False
    if len(crash_log_cont) >= 3:
        ret = crash_log_cont[2]
    logger.debug("\nOut {}, return:'{}'".format(sname, ret))
    return ret


class ConsoleCon(telnetlib.Telnet):

    def __init__(self,
                 host,
                 port=0,
                 user=None,
                 pwd=None,
                 timeout=None,
                 autologin=True,
                 clearline=True):
        sname = "fortigate.ConsoleCon.__init__"
        tmp = "\nIn {}, 'host':'{}', 'port':'{}', 'user':'{}', 'pwd':'{}',"\
            + " 'timeout':'{}', 'autologin':'{}', 'clearline':'{}'\n"
        msg = tmp.format(sname, host, port, user, pwd,
                         timeout, autologin, clearline)
        logger.debug(msg)
        if timeout:
            super(ConsoleCon, self).__init__(timeout=timeout)
        else:
            super(ConsoleCon, self).__init__()
        self.tsip = host
        self.tserver = TerminalServer(host=self.tsip)
        self.port = port if port else 23
        self.user = user
        self.password = pwd

        if host and port:
            self.init_connect(clearline)
            if user and autologin:
                self.login(self.user, self.password)
        logger.debug("\nOut %s\n" % sname)

    def __str__(self):
        return "Console %s:%d" % (self.tsip, self.port)

    def init_connect(self, clearline=True):
        sname = "fortigate.ConsoleCon.init_connect"
        msg = "\nIn {}, 'clearline':'{}'".format(sname, clearline)
        logger.debug(msg)
        if clearline:
            self.tserver.login()
            self.tserver.clear_line(str(self.port)[-2:])
            self.tserver.close()
        time.sleep(1)
        self.open(self.tsip, self.port, self.timeout)
        logger.debug("\nOut %s\n" % sname)

    def login(self,
              user=None,
              pwd=None,
              timeout=FGT_WAIT_TIMER,
              clearline=False,
              send_init_lf=True,
              retry=3):
        sname = 'fortigate.ConsoleCon.login'
        tmp = "\nIn {}, 'user':'{}', 'pwd':'{}', 'timeout':'{}'," \
            + " 'clearline':'{}', 'send_init_lf':'{}', 'retry':'{}'\n"
        msg = tmp.format(sname, user, pwd, str(
            timeout), clearline, send_init_lf, retry)
        logger.debug(msg)
        if user:
            self.user = user
        elif self.user:
            pass
        else:
            self.user = FGT_DEF_ADMIN

        if pwd:
            self.password = pwd
        elif self.password:
            pass
        else:
            self.password = FGT_DEF_PWD
        self.timeout = timeout if timeout else self.timeout
        if clearline:
            self.tserver.login()
            self.tserver.clear_line(str(self.port)[-2:])
            self.tserver.close()
            self.sock = None
        time.sleep(1)
        if not self.sock:
            self.open(self.tsip, self.port, self.timeout)
        if send_init_lf:
            self.mysend('\n')
        rtext = self.rt_read_until(timer=timeout)
        # if return is none or can't get the login pop-up
        retry_time = retry
        while retry_time > 0:
            if rtext and rtext.endswith('login: '):
                logger.debug("\nGet login pop-up at %d time try!\n" %
                             retry_time)
                break
            else:
                # if can't get login pop-up, send ctrl_c
                if retry_time != retry:
                    logger.debug("\nSleep 30 sec and then try it again!!!")
                    time.sleep(30)
                self.mysend('\x03')
                time.sleep(0.1)
                self.rt_read_until(timer=timeout)
                # send ctrl_d
                self.mysend('\x04')
                time.sleep(0.5)
                self.mysend('\n')
                time.sleep(0.1)
                rtext = self.rt_read_until(timer=timeout)
            retry_time -= 1

        if not rtext or (rtext and not rtext.endswith(' login: ')):
            raise UnabletoGetLogin()

        self.lazy_read_proc()
        logger.debug("\nOut %s\n" % sname)

    def mysend(self, cmd, addenter=True):
        sname = 'fortigate.ConsoleCon.mysend'
        tmp = "\nIn {}, 'cmd':'{}', 'addenter':'{}'\n"
        msg = tmp.format(sname, cmd, addenter)
        logger.debug(msg)
        clear_cmd = cmd.upper().strip()
        logger.debug("\nGoing to send:'%s'" % cmd)
        if addenter and not cmd.endswith('\n'):
            cmd = cmd + '\n'
        if not isinstance(cmd, bytes):
            cmd = cmd.encode()
        self.write(cmd)
        logger.debug('  <--- sent\n')
        # process special commands
        for c in DIAG_EXE_CLI_SKIP:
            if clear_cmd.find(c) != -1:
                return
        if clear_cmd.startswith('EXE') or clear_cmd.startswith('DIAG'):
            time.sleep(3)
            self.mysend('\n')
        logger.debug("\nOut %s\n" % sname)

    def lazy_read_proc(self, timer=FGT_WAIT_TIMER):
        sname = 'fortigate.ConsoleCon.lazy_read_proc'
        tmplate = "\nIn {}, 'timer':'{}'\n"
        msg = tmplate.format(sname, timer)
        logger.debug(msg)
        self.mysend('\n')
        index, matched, text = self.expect(FGT_EXP_PATTERN, timer)
        # htprint(type(text))
        # htprint(index)
        ret = text.decode(errors='ignore')
        # htprint(type(ret))
        # htprint(ret)
        logger.info(ret)
        tmplate = "\nOut {}, return:'{}'\n"
        sys.stdout.flush()
        if index == 0:
            # logger.info(ret)
            logger.debug(tmplate.format(sname, ret))
            return ret
        elif index == 1:
            self.mysend('\n')
            tmp = self.lazy_read_proc()
            if tmp:
                ret += tmp
        elif index == 2 or index == 3:
            self.mysend(self.user)
            tmp = self.lazy_read_proc()
            if tmp:
                ret += tmp
        elif index == 4:
            self.mysend(self.password)
            tmp = self.lazy_read_proc()
            if tmp:
                ret += tmp
        elif index >= 5 and index <= 8:
            self.mysend('y')
            tmp = self.lazy_read_proc()
            if tmp:
                ret += tmp
        elif index == 9:
            self.mysend('a')
            tmp = self.lazy_read_proc()
            if tmp:
                ret += tmp
        elif index == 10 or index == 11:
            # logger.info(ret)
            logger.debug(tmplate.format(sname, ret))
            return ret
        else:
            # logger.info(ret)
            logger.debug(tmplate.format(sname, ret))
            return ret

    def rt_read_until(self, exp=UNIVERSAL_REG, timer=FGT_WAIT_TIMER):
        sname = 'fortigate.ConsoleCon.rt_read_until'
        tmplate = "\nIn {}, 'exp':'{}', 'timer':'{}'\n"
        msg = tmplate.format(sname, str(exp), timer)
        logger.debug(msg)
        exppattern = re.compile(exp, flags=re.M | re.S)
        ct = int(time.monotonic())
        deadline = ct + timer
        ret = ''
        tmplate = "\nOut {}, return:'{}'\n"
        #logger.info('current time: %d, dd: %d, timer: %d' % (ct, deadline, timer))
        while True:
            result = re.findall(exppattern, ret)
            if len(result) > 0:
                # logger.info(ret)
                logger.debug(tmplate.format(sname, ret))
                return ret
            elif not self.eof:
                tmp = self.read_very_eager()
                if tmp:
                    # have data
                    deadline = int(time.monotonic()) + timer
                    tmp = tmp.decode(errors='ignore')
                    # print('+')
                    logger.info(tmp)
                    # print(tmp, end='')
                    ret += tmp
                else:
                    # no data
                    if int(time.monotonic()) > deadline:
                        logger.warning(
                            '\nTimeout and no more data..........\n')
                        # logger.info(ret)
                        #
                        tret = ret.strip() if ret else False
                        if tret and tret.endswith('login:'):
                            self.login()
                        else:
                            self.login(clearline=True)
                        logger.debug(tmplate.format(sname, ret))
                        return ret
            else:
                # print('self.eof   --->', self.eof)
                logger.info('#Got eof, and return')
                logger.debug(tmplate.format(sname, ret))
                return ret

    def realtime_expect(self, exp_lst, timer=FGT_WAIT_TIMER):
        sname = 'fortigate.ConsoleCon.realtime_expect'
        tmp = "\nIn {}, 'exp_lst':'{}', 'timer':'{}'\n"
        msg = tmp.format(sname, str(exp_lst), timer)
        logger.debug(msg)
        pat_list = exp_lst[:]
        indices = range(len(exp_lst))
        for i in indices:
            if not hasattr(exp_lst[i], "search"):
                pat_list[i] = re.compile(pat_list[i])
        deadline = time.monotonic() + timer
        ret = ''
        tmp = "\nOut {}, return:'{}'\n"
        mret = None
        while True:
            for i in indices:
                m = pat_list[i].search(ret)
                if m:
                    e = m.end()
                    mret = (i, m, ret)
                    logger.debug(tmp.format(sname, str(mret)))
                    return mret
            if not self.eof:
                tmp = self.read_very_eager()
                if tmp:
                    deadline = time.monotonic() + timer
                    tmp = tmp.decode(errors='ignore')
                    logging.info(tmp)
                    # print(tmp, end='')
                    ret += tmp
            else:
                logger.info('\nself.eof   --->%s\n' % str(self.eof))
                if time.monotonic() > deadline:
                    logger.info('\nTimer is timed out..........\n')
                    logger.debug()
                    mret = (-1, None, ret)
                    logger.debug(tmp.format(sname, str(mret)))
                    return mret
        mret = (-2, None, ret)
        logger.debug(tmp.format(sname, str(mret)))
        return mret

    def logout(self, clearline=True):
        '''
        logout console and then clear
        '''
        sname = 'fortigate.ConsoleCon.logout'
        tmp = "\nIn {}, 'clearline':'{}'\n"
        msg = tmp.format(sname, clearline)
        logger.debug(msg)
        if self.sock is not None:
            self.close()
        if clearline:
            self.tserver.login()
            self.tserver.clear_line(str(self.port)[-2:])
            self.tserver.close()
        logger.debug("\nOut %s\n" % sname)


if __name__ == '__main__':

    fgt = FortiGate()
    fgt.console = ConsoleCon(host='172.16.106.64', port=2016, timeout=3)
    fgt.console.login('admin', '', 1)
    fgt.console.mysend('diag debug crashlog read')
    fgt.console.rt_read_until()
    # except:
    #     print('Error info: type  %s , error message -> %s,'
    #           ' error -> %s' % (sys.exc_info()[0],
    #                             sys.exc_info()[1],
    #                             str(sys.exc_info()[2].tb_lineno)))
    fgt.console.mysend('get sys status')
    fgt.console.rt_read_until()
    fgt.console.mysend('diag autoupdate version')
    verinfo = fgt.console.rt_read_until()
    print(verinfo)
    # testcase = r'C:\Users\VAN-201130-NB\OneDrive\BMRK\autotest\testcase'
    # with open(testcase, 'r') as f:
    #     for line in f:
    #         if line.strip().startswith('['):
    #             pass
    #         elif line.strip().startswith('#'):
    #             pass
    #         else:
    #             pass
    # enter_bios = 'Press any key to display configuration menu'
    # image = 'FGT_140D-v5-build1150-FORTINET.out'
    # fgt.burn_image(image, '10.6.30.55')

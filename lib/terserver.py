#!/usr/bin/python3
import telnetlib
import socket
import logging
logger = logging.getLogger(__name__)
import ftplib
import re
import sys
import time


DEFAULT_USER = 'cisco'
DEFAULT_PWD = 'cisco'
EXPECT_LIST = [r': $',              # input password
               r'>$',               # enable mode
               r'#$',               # after enable
               r'\[confirm\]$',     # [confirm]
               r'Bad passwords$',   # bad password, then connection will be reset
               r'255\)$',           # wrong command with FQDN resolve
               r'--More--$',        # more output
               ]
EXPECT_PATTERN = [re.compile(exp.encode('utf-8')) for exp in EXPECT_LIST]
WRONG_CMD_WAIT = 11                 # wrong command need to wait 11 seconds


class TerminalServer(telnetlib.Telnet):

    def __init__(self,
                 host,
                 port=0,
                 user=DEFAULT_USER,
                 pwd=DEFAULT_PWD,
                 timeout=socket._GLOBAL_DEFAULT_TIMEOUT):
        """Constructor.

        When called without arguments, create an unconnected instance.
        With a hostname argument, it connects the instance; port number
        and timeout are optional.
        all the followed attribute are defined in super class
        self.debuglevel = DEBUGLEVEL
        self.host = host
        self.port = port
        self.timeout = timeout
        self.sock = None
        self.rawq = b''
        self.irawq = 0
        self.cookedq = b''
        self.eof = 0
        self.iacseq = b'' # Buffer for IAC sequence.
        self.sb = 0 # flag for SB and SE sequence.
        self.sbdataq = b''
        self.option_callback = None

        """
        sname = 'terserver.TerminalServer.__init__'
        tmp = "\nIn {}, 'host':'{}', 'port':'{}', 'user':'{}', 'pwd':'{}', 'timeout':'{}'\n"
        msg = tmp.format(sname, host, str(port), user, pwd, str(timeout))
        logger.debug(msg)
        super(TerminalServer, self).__init__(timeout=timeout)
        self.user = user
        self.password = pwd
        self.port = port if port else 23
        self.host = host
        logger.debug("\nOut %s\n" % sname)

    def send(self, cmd):
        sname = 'terserver.TerminalServer.send'
        msg = "\nIn {}, 'cmd':'{}'\n".format(sname, cmd)
        logger.debug(msg)
        if not cmd.endswith('\n'):
            cmd = cmd + '\n'
            # if cmd == '\x03':
            #     msg = 'send ctrl_c'
            # else:
            #     msg = cmd
            # sys.stdout.write(msg)
        if not (isinstance(cmd, bytes)):
            #cmd = cmd.encode('utf-8', errors="ignore")
            cmd = cmd.encode('utf-8', errors="ignore")
        # print('send command'.center(100, '-'))
        # print(cmd)
        self.write(cmd)
        time.sleep(0.2)
        index, matched, text = self.expect(EXPECT_PATTERN, 1)
        ret = text.decode('utf-8', errors="ignore")
        #ret = text.decode(errors="ignore")
        # sys.stdout.write(ret)
        logger.info(ret)
        dmsg = "\n'index':'{}', 'matched':'{}', 'text':'{}'\n"
        logger.debug(dmsg.format(str(index), str(matched), str(text)))
        # print('print return'.center(100, '-'))
        # sys.stdout.write(ret.center(100, '-'))
        # print(index)
        # print('*' * 100)
        # print(matched)
        ret_flag = False
        if index == 0:
            # print("index==0")
            self.send(self.password)
        elif index == 1:
            # print("index==1")
            self.send('enable')
        elif index == 2:
            # print("index==2")
            ret_flag = True
        elif index == 3:
            # print("index==3")
            self.send('y')
        elif index == 4:
            # print("index==4")
            self.sock = None
            # logging.info(ret)
            ret_flag = True
        elif index == 5:
            # print("index==5")
            time.sleep(WRONG_CMD_WAIT)
            self.send('')
        elif index == 6:
            self.send(' ')
        else:
            ret_flag = True

        if ret_flag:
            logger.debug("\nOut {}, return:'{}'\n".format(sname, ret))
            return ret
        else:
            logger.debug("\nOut {}\n".format(sname))

    def clear_line(self, line):
        '''
        clear a console line, by sending
        1> ctrl + c
        2> clear line 'line'
        3> enter
        '''
        sname = 'terserver.TerminalServer.clear_line'
        msg = "\nIn {}, 'cmd':'{}'\n".format(sname, line)
        logger.debug(msg)
        cmd_list = ['\x03', 'clear line %s' % line, '']
        for cmd in cmd_list:
            self.send(cmd)
        logger.debug("\nOut %s\n" % sname)

    def login(self,
              user=None,
              pwd=None,
              timeout=None):
        '''
        login terminal server with 'user', 'pwd'
        '''
        sname = 'terserver.TerminalServer.login'
        tmp = "\nIn {}, 'user':'{}', 'pwd':'{}', 'timeout':'{}'\n"
        msg = tmp.format(sname, user, pwd, timeout)
        logger.debug(msg)
        self.user = user if user else self.user
        self.password = pwd if user else self.password
        self.timeout = timeout if timeout else self.timeout
        tmp = ' Terminal Server( %s:%s ) ' % (self.host, str(self.port))
        msg = '\n' + tmp.center(70,  '-')
        logger.info(msg)
        if self.sock is None:
            self.open(self.host, self.port, self.timeout)
        while True:
            ret = self.send('\x03')
            if ret:
                if ret.endswith(')#'):
                    continue
                else:
                    break
        logger.debug("\nOut %s\n" % sname)
        return True

    def close(self):
        '''
        close connection to terminal server
        '''
        sname = 'terserver.TerminalServer.close'
        logger.debug("\nIn %s\n" % sname)
        try:
            super(TerminalServer, self).close()
        except NameError as e:
            logger.warning("\n%s\n" % e)
        msg = '\n' + '-' * 70 + '\n'
        logger.info(msg)
        logger.debug("\nOut %s\n" % sname)


if __name__ == '__main__':
    myts = TerminalServer(host='172.16.106.64')
    myts.login()
    myts.send('aaa')
    myts.send('bbb')

    # myts.clear_line('9')
    myts.close()

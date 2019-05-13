#!/usr/bin/python3
'''
Created on Dec 7, 2017
@author: Rainxiaole
'''

import ftplib
import sys
import os
import time
import re
import socket
import threading
import logging
from subprocess import check_output
from ipaddress import IPv4Interface
if __name__ == "__main__":
    from myexception import UnkownModel
else:
    from lib.myexception import UnkownModel

logger = logging.getLogger(__name__)

# if __name__ == '__main__':
#     import inspect
#     current = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
#     parentdir = os.path.dirname(current)
#     sys.path.insert(0, parentdir)
#     #logger.setLevel(logger.DEBUG)

# from utils.util import enablelog

BUILD_DICT = {'5.0': [1, 512],
              '5.2': [513, 891],
              '5.4': [892, 1390],
              '5.6': [1391, 2000],
              '5.8': [2001, 3000],
              '5.9': [3001, 4000],
              '6.0': [1, 1000]
              }

IMAGE_LOCATION = r'/home/images02/FortiOS/v{}.00/images'
FTP_SERVER_IP = '172.16.100.71'
FTP_USER = 'test'
FTP_PASSWORD = 'test'
TARGET_LOCATION = r'/tftpboot/'
SPECIAL_BRANCH_FOLDER = r'NoMainBranch'


class DownloadProgress:
    '''download progress bar'''

    def __init__(self, ttsize, fl, tt):
        # statinfo = os.stat(fname)
        # self.filesize = statinfo.st_size
        self.filesize = ttsize
        self.so_far = 0
        self.fldesc = fl
        self.title = tt

    def ddcallback(self, buffer):
        '''callback fucntion for ftp to call, to update progress bar'''
        self.fldesc.write(buffer)
        self.so_far = self.so_far + len(buffer) - 1
        progress = self.so_far / self.filesize
        self.update_progress(self.title, progress)
        return

    def update_progress(self, job_title, progress):
        '''update progress during download'''
        length = 38
        block = int(round(length * progress))
        bartp = "\r{0:}: [{1}] {2: 3}%"
        msg = bartp.format(job_title,
                           "#" * block + "-" * (length - block),
                           round(progress * 100, 1))
        sys.stdout.write(msg)
        time.sleep(0.001)
        sys.stdout.flush()
        self.fldesc.flush()
        # this one is for logger, don't want log to have a buch of garbe info
        if progress * 10000 == 10000:
            logger.info(msg)


def normalize_model(model):
    sname = 'imageserver.normalize_model'
    tmp = "\nIn {}, 'model':'{}'\n"
    msg = tmp.format(sname, model)
    logger.debug(msg)
    '''normalize model input'''
    nm_ml = model.upper()
    nm_dict = {'FORTIGATE': 'FGT',
               'FGT': 'FGT',
               'FORTIWIFI': 'FWF',
               'FORTICARRIER': 'FGT',
               'FORTIAP': 'FAP',
               'FORTIRUG': 'FGR',
               'FORTIGATERUGGED': 'FGR',
               'KVM': 'FGT_VM64_KVM',
               'SVM': 'FGT_VM64_SVM',
               'VMX': 'FGT_VM64_VMX',
               'HV': 'FGT_VM64_HV',
               '-': '_'}
    for entry in nm_dict:
        nm_ml = nm_ml.replace(entry, nm_dict[entry])
    if nm_ml.find('_') == -1:
        nm_ml = nm_ml[:3] + '_' + nm_ml[3:]
    tmp = "\nOut {}, return:'{}'\n"
    msg = tmp.format(sname, nm_ml)
    logger.debug(msg)
    return nm_ml


# def gen_image_name(model, build, release, debug_flag):
#     '''compose the image name'''
#     mdl = normalize_model(model)
#     ext = 'deb' if debug_flag else 'out'
#     tmp = '{}-v{}-build{}-FORTINET.{}'
#     ret = tmp.format(mdl, release[:1], build, ext)
#     return ret

def search_image(image_list, image):
    '''
    search image in image list
    '''
    sname = 'imageserver.search_image'
    tmp = "\nIn {}, 'image_list':\n'{}',\n 'image':'{}'\n"
    msg = tmp.format(sname, str(image_list), image)
    logger.debug(msg)
    ret = False
    if image in image_list:
        ret = True
    msg = ">>>> unable to find the {} you need in server!!!".format(image)
    print_and_log(msg, level='error')
    logger.debug("\nOut {}, return:'{}'\n".format(sname, ret))
    return ret


def release_builds(lst, brch='5.0'):
    '''
    get all the builds of release, and return the list
    '''
    sname = 'imageserver.release_builds'
    tmp = "\nIn {}, 'lst':\n'{}',\n 'brch':'{}'\n"
    msg = tmp.format(sname, str(lst), brch)
    logger.debug(msg)
    brch_bld = []
    for build in lst:
        if int(build) in range(BUILD_DICT[brch][0], BUILD_DICT[brch][1]):
            brch_bld.append(build)
    logger.debug("\nOut {}, return:'{}'\n".format(sname, str(brch_bld)))
    return brch_bld


def get_max_n(lst, recent):
    '''
    get the 'recent' maxmium in  list of 'lst'
    '''
    sname = 'imageserver.get_max_n'
    tmp = "\nIn {}, 'lst':\n'{}',\n 'recent':'{}'\n"
    msg = tmp.format(sname, str(lst), recent)
    logger.debug(msg)
    tmp = lst[:]
    tmp.sort(reverse=True)
    max_list = ['build{0:04d}'.format(bld) for bld in tmp[:recent]]
    logger.debug("\nOut {}, return:'{}'\n".format(sname, str(max_list)))
    return max_list


def image_path(ftp_folder, build, stag=None):
    '''
    get the full path of image on ftp server with 'ftp_folder' and 'build'
    '''
    sname = 'imageserver.image_path'
    tmp = "\nIn {}, 'ftp_folder':'{}', 'build':'{}', 'stag':'{}'\n"
    msg = tmp.format(sname, ftp_folder, build, stag)
    logger.debug(msg)
    tmp = r'{}/build_tag_{}' if stag else r'{}/build{}'
    ret = tmp.format(ftp_folder, build)
    logger.debug("\nOut {}, return:'{}'\n".format(sname, ret))
    return ret


def release_folder(release, stag=None):
    '''
    return release folder path for a specified release
    '''
    sname = 'imageserver.image_path'
    tmp = "\nIn {}, 'release':'{}', 'stag':'{}'\n"
    msg = tmp.format(sname, release, stag)
    logger.debug(msg)
    ret = IMAGE_LOCATION.format(release[0])
    if stag:
        stag = normal_branch(stag)
        ret += '/{}/{}'.format(SPECIAL_BRANCH_FOLDER, stag)
    logger.debug("\nOut {}, return:'{}'\n".format(sname, ret))
    return ret


def download_file_path(targefolder, file):
    '''
    compose full name of download file with 'targefolder', 'file'
    '''
    return os.path.join(targefolder, file)


def change_folder(target_folder):
    '''
    change current working folder to 'target_folder'
    '''
    os.chdir(target_folder)


def print_slected_img(slist, image_dict):
    '''
    check each build(in a format of 'buildxxxx' in slist against image_dict
    return the selected image information as a string
    '''
    sname = 'imageserver.print_slected_img'
    tmp = "\nIn {}, 'slist':\n'{}',\n 'image_dict':'{}'\n"
    msg = tmp.format(sname, str(slist), str(image_dict))
    logger.debug(msg)
    max_n_bld = ''
    for bld in sorted(slist):
        if not isinstance(bld, int):
            bld = int(bld[-4:])
        if bld in image_dict:
            max_n_bld += image_dict[bld] + '\n'
    if max_n_bld:
        print_and_log(max_n_bld.strip() + '  <--\n')
    else:
        print_and_log('--- NA ---\n')
    logger.debug("\nOut {}, return:\n'{}',\n".format(sname, max_n_bld))
    return max_n_bld


def normal_branch(stag):
    '''
    the branch tag on ftp server is fg_xxxx, but on infosite it shows as br_xxx
    '''
    if stag.startswith('br_'):
        stag = 'fg_' + stag[3:]
    return stag


class ImageServer(ftplib.FTP):

    def __init__(self,
                 host=FTP_SERVER_IP,
                 user=FTP_USER,
                 password=FTP_PASSWORD):
        sname = 'imageserver.ImageServer.__init__'
        msg = "\nIn {}, 'host':'{}', 'user':'{}', 'password':'{}'\n"
        logger.debug(msg.format(sname, host, user, '****'))
        super(ImageServer, self).__init__(host, user, password)
        self.user = user
        self.password = password
        logger.debug("\nOut {}\n".format(sname))

    def check_folder(self, folder):
        '''
        check image list in ftp server 'folder'
        '''
        sname = 'imageserver.ImageServer.check_folder'
        msg = "\nIn {}, 'folder':'{}'\n"
        logger.debug(msg.format(sname, folder))
        self.check_connection()
        self.cwd(folder)
        logger.debug("\nOut {}\n".format(sname))
        return self.nlst()

    def get_release_image(self, release, stag=None):
        '''
        check img info from ftp server,
        return a dictionary of build number(key) and original information(value
        '''
        sname = 'imageserver.ImageServer.get_release_image'
        msg = "\nIn {}, 'release':'{}', 'stag':'{}'\n"
        logger.debug(msg.format(sname, release, stag))
        self.check_connection()
        if stag:
            stag = normal_branch(stag)
        imgfld = release_folder(release, stag)
        self.cwd(imgfld)
        images = {}
        img_lst = []
        self.dir(img_lst.append)
        # print(img_lst)
        for line in img_lst:
            if (line[-4:]).isdigit() is False:
                continue
            else:
                build = int(line[-4:])
                images[build] = line
        msg = "\nOut {}, 'images':\n'{}'\n".format(sname, str(images))
        logger.debug(msg)
        return images

    def latest_image(self, rls=None, recent=3, stag=False):
        '''
        get the LATEST 'recent'(default is 3) images
        from image list for a specified release 'rls'
        '''
        sname = 'imageserver.ImageServer.latest_image'
        msg = "\nIn {}, 'rls':'{}', 'recent':'{}', 'stag':'{}'\n"
        logger.debug(msg.format(sname, rls, recent, stag))
        release = rls
        img_dct = {}
        # Trunk image
        if not stag:
            if not release:
                release = BUILD_DICT.keys()
            release = sorted(release)
            for brch in release:
                image_dict = self.get_release_image(brch)
                img_dct[brch] = get_max_n(release_builds(
                    image_dict.keys(), brch), recent)
                if len(img_dct[brch]) > 0:
                    print_and_log(('< LATEST %s IMAGES >' %
                                   brch).center(70, '-') + '\n')
                    print_slected_img(img_dct[brch], image_dict)
        # check special image
        else:
            if not release:
                print_and_log(
                    "Must specify release information for SPECIAL IMAGE!!\n")
                sys.exit()
            else:
                brch = release[0]
                img_dct = self.get_release_image(brch, stag)
                msg = '< LATEST {}/{} IMAGES >'.format(brch, stag)
                if len(img_dct) > 0:
                    print_and_log(msg.center(70, '-') + '\n')
                    imglatest = sorted(img_dct.keys(), reverse=True)[:recent]
                    print_slected_img(imglatest, img_dct)
        msg = "\nOut {}, 'images':\n'{}'\n".format(sname, str(img_dct))
        logger.debug(msg)
        return img_dct

    def checkimage(self, platform, build, release, debug_flag, stag=None):
        '''
        check existence from ftp server for
        1> paltform
        2> build
        3> release
        4> if 'debug_flag' is True, .deb image else .out image

        '''
        sname = 'imageserver.ImageServer.checkimage'
        tmp = "\nIn {}, 'platform':'{}', 'build':'{}', 'relase':'{}', 'debug_flag':'{}', 'stag':'{}'\n"
        msg = tmp.format(sname, platform,
                         build, release, debug_flag, stag)
        logger.debug(msg)
        self.check_connection()
        build = '{0:04d}'.format(int(build))
        image = self.gen_image_name(platform, build, release, debug_flag)
        img_folder = image_path(release_folder(release, stag), build, stag)
        msg = "\nUnable to find image '%s'!" % image
        tmp = "\nOut {}, return:'{}'\n"
        ret = False
        try:
            self.cwd(img_folder)
        except:
            ret = False
            print_and_log(msg)
            logger.debug(tmp.format(sname, ret))
            return ret
        all_img = self.nlst()
        for entry in all_img:
            if entry.find(image) != -1:
                ret = True
                logger.debug(tmp.format(sname, ret))
                return ret
        print_and_log(msg)
        logger.debug(tmp.format(sname, ret))
        return ret

    def downloadimage(self,
                      platform,
                      build,
                      release,
                      debug_flag,
                      targetfile=None,
                      stag=None):
        '''
        perform image download from ftp server for
        1> paltform
        2> build
        3> release
        4> if 'debug_flag' is True, .deb image else .out image
        5> save as 'targetfile', if no 'targetfile',
        save to current folder with the same name on server
        '''
        sname = 'imageserver.ImageServer.downloadimage'
        tmp = "\nIn {}, 'platform':'{}', 'build':'{}', 'relase':'{}',"\
            + " 'debug_flag':'{}', 'targetfile':'{}', stag':'{}'\n"
        msg = tmp.format(sname, platform,
                         build, release, debug_flag, targetfile, stag)
        logger.debug(msg)
        self.check_connection()
        if not self.checkimage(platform, build, release, debug_flag, stag):
            return False
        build = '{0:04d}'.format(int(build))
        image = self.gen_image_name(platform, build, release, debug_flag)
        if not targetfile:
            targetfile = os.path.join(TARGET_LOCATION, image)

        img_folder = image_path(release_folder(release, stag), build, stag)

        # self.cwd(img_folder)
        full_image_name = os.path.join(img_folder, image)
        tsize = self.size(full_image_name)
        stime = time.time()
        print_and_log('\n\n' + ' Going to download image '.center(70, '-'))
        print_and_log('\nTotal  Size:  %d\n' % tsize)
        with open(targetfile, 'wb') as tfile:
            ddprogress = DownloadProgress(tsize, tfile, 'Approaching')
            print_and_log("Downloading: %s \n" % os.path.basename(image))
            self.retrbinary("RETR " + image, callback=ddprogress.ddcallback)
        etime = time.time()
        print_and_log('\nImage  Stored: %s\n' % targetfile)
        print_and_log('Time Consumed: %d (seconds)\n' % (etime - stime))
        print_and_log('\n%s\n' % ('-' * 70))
        '''check file is downloaded or not'''
        ret = False
        if os.path.isfile(targetfile):
            ret = True

        logger.debug("\nOut {}, return:'{}'\n".format(sname, ret))
        return ret

    def down_iamge_fgt_list(self, model_lst, build, release, debug_flag=False, stag=None):
        '''
        perform images download from ftp server for models in 'model_lst'
        1> paltform
        2> build
        3> release
        4> if 'debug_flag' is True, .deb image else .out image
        5> save as 'targetfile', if no 'targetfile',
        save to current folder with the same name on server
        '''
        sname = 'imageserver.ImageServer.down_iamge_fgt_list'
        tmp = "\nIn {}, 'model_lst':'{}', 'build':'{}', 'relase':'{}', 'debug_flag':'{}', 'stag':'{}'\n"
        msg = tmp.format(sname, str(model_lst),
                         build, release, debug_flag, stag)
        logger.debug(msg)
        self.check_connection()
        for fgt in model_lst:
            self.downloadimage(fgt, build, release, debug_flag, stag=stag)
        logger.debug("\nOut %s\n" % sname)

    def check_connection(self):
        '''
        check whether a socekt is there or not, if not create one
        '''
        tmp = '\n{}, imageserver.ImageServer.check_connection\n'
        logger.debug(tmp.format('In'))
        reinitial = False
        if not self.sock:
            logger.info("\nImage Server Session closed!!!!\n")
            reinitial = True
        else:
            try:
                self.voidcmd("NOOP")
            except Exception as e:
                logger.error("\nConnection Error:%s\n" % e)
                try:
                    self.close()
                except:
                    pass
                reinitial = True
        if reinitial:
            logger.info("\nImage Server Reconnect!!!!\n")
            self.connect(self.host)
            self.login(self.user, self.password)
        logger.debug(tmp.format('Out'))

    def gen_image_name(self, model, build, release, debug_flag, fzip=True):
        '''
        compose the image name with:
        model, build, release, debug_flag
        '''
        sname = 'imageserver.ImageServer.gen_image_name'
        tmp = "\nIn {}, 'model':'{}', 'build':'{}', 'relase':'{}', 'debug_flag':'{}'\n"
        msg = tmp.format(sname, model,
                         build, release, debug_flag)
        logger.debug(msg)
        mdl = normalize_model(model)
        build = '{0:04d}'.format(int(build))
        ext = 'deb' if debug_flag else 'out'
        if mdl.find('VM64') != -1:
            VM_ZIP_EXT = {'FGT_VM64_KVM': 'out.kvm.zip',
                          'FGT_VM64_SVM': 'out.ovf.zip',  # out.vmware.zip
                          'FGT_VM64_VMX': 'out.ovf.zip',  # out.vmware.zip
                          'FGT_VM64_HV': 'out.hyperv.zip', }
            if fzip:
                ext = VM_ZIP_EXT.get(mdl, None)
                if not ext:
                    logger.error("\nUnknown device type '%s'!!!!\n" % mdl)
                    logger.warning("\nSupported VM types: '%s'\n" %
                                   ', '.join(VM_ZIP_EXT.keys()))

                    raise UnkownModel(mdl)
            else:
                ext = 'out'
        tmp = '{}-v{}-build{}-FORTINET.{}'
        ret = tmp.format(mdl, release[:1], build, ext)
        logger.debug("\nOut {}, return:'{}'\n".format(sname, ret))
        return ret

    def destroy(self):
        msg = "\n{} imageserver.ImageServer.destroy\n"
        logger.debug(msg.format('In'))
        if self.sock is not None:
            try:
                self.quit()
            except ftplib.error_temp as e:
                logger.warning("\nException: %s\n" % str(e))
                self.close()
        logger.info("\nLogout and session closed!\n")
        logger.debug(msg.format('Out'))


def print_and_log(msg='', level='info'):
    '''
    keep this one here, as I want this imageserver to be a tool as well
    '''
    logdict = {'info': logger.info,
               'warning': logger.warning,
               'error': logger.error,
               'exception': logger.exception,
               'critical': logger.critical,
               'debug': logger.debug}
    if __name__ == '__main__':
        print(msg)
    logdict[level]("\n%s\n" % msg.strip())


def main(args):
    '''
    input should have:
    platform
    release
    build
    debug/official
    '''
    import argparse
    desc = "Test program is used for Image Server Operating for FortiOS"
    parser = argparse.ArgumentParser(description=desc, prog='imageserver.py',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--version', action='version', version='%(prog)s 1.0')
    parser.add_argument("-f", "--fortigate", dest="fgtlst", nargs='*',
                        help="specify fortigate platfrom, like FGT_300D, or either FGT_300D,FGT_200D")
    parser.add_argument("-r", "--release", dest="release", nargs='*',
                        help="specify release, like 5.6")
    parser.add_argument("-b", "--build", dest="build",
                        help="specify a build to run")
    parser.add_argument("-d", "--debug", dest="debug_flag", action='store_true',
                        default=False, help="debug image or official image")
    parser.add_argument("-s", "--special", dest="sp_branch", default=False,
                        help="check special branch")
    parser.add_argument("-c", "--check", dest="check", type=int, default=3,
                        help="check <N> latest image")
    # print(parser.print_help())
    args = parser.parse_args()
    myserver = ImageServer()

    if args.check and not args.fgtlst:
        myserver.latest_image(args.release, args.check, args.sp_branch)
        sys.exit()
    elif args.fgtlst and args.release and args.build:
        myserver.down_iamge_fgt_list(
            args.fgtlst, args.build, args.release[0], args.debug_flag, args.sp_branch)
    else:
        print(parser.print_help())
        sys.exit()


if __name__ == '__main__':
    # import inspect
    # current = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
    # parentdir = os.path.dirname(current)
    # sys.path.insert(0, parentdir)
    # from utils.util import enablelog
    # myserver = ImageServer()
    # myserver.latest_image('5.0', 5, 'br_5-6_2018_nss')
    main(sys.argv)

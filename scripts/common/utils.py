import shutil
import logging
import os
import subprocess
import pandas

from common.consts import HISTORY_DIR

logger = logging.getLogger()


def dump_to_history(df: pandas.DataFrame, f_name):
    git_remote = "https://gitlab.cnpem.br/con/streamdevice-ioc-history.git"
    df.to_csv(os.path.join(HISTORY_DIR, f_name), encoding="utf-8", index=False)
    out = subprocess.check_output("cd {}; git init .".format(HISTORY_DIR), shell=True)
    logger.info("Git Init {}".format(out))
    out = subprocess.check_output(
        "cd {}; git remote add origin {}; git config user.name streamdevice-ioc; git config user.email streamdevice@lnls.br".format(
            HISTORY_DIR, git_remote
        ),
        shell=True,
    )
    logger.info("Git add_remote {}".format(out))
    git_add = subprocess.check_output(
        "cd {}; git add .".format(HISTORY_DIR), shell=True
    )
    logger.info("Git add {}".format(git_add))
    try:
        out = subprocess.check_output(
            "cd {}; git commit -m 'Changes at {}'".format(HISTORY_DIR, f_name),
            shell=True,
        )
        logger.info("Git commit {}".format(out))
    except subprocess.CalledProcessError as grepexc:
        logger.warning(
            "Git commit failed with code {}. Output {}.".format(
                grepexc.returncode, grepexc.output
            )
        )


def copytree(src, dst, symlinks=False, ignore=None):
    if os.path.exists(src):
        logger.info("Coping cmd files from {} to {}.".format(src, dst))
        for item in os.listdir(src):
            s = os.path.join(src, item)
            d = os.path.join(dst, item)
            if os.path.isdir(s):
                shutil.copytree(s, d, symlinks, ignore)
            else:
                shutil.copy2(s, d)
    else:
        logger.warning(
            "Failed to copy {} to {}, origin path do not exist.".format(src, dst)
        )


def deploy_files(base_origin_dir, top):
    # fmt: off
    logger.info("Deploying IOC files to {}.".format(top))
    copytree(os.path.join(base_origin_dir, "server/cmd"), "{}/iocBoot/iocStreamDeviceIOC".format(top))
    copytree(os.path.join(base_origin_dir, "server/db"), "{}/db".format(top))
    copytree(os.path.join(base_origin_dir, "server/autosave"), "{}/autosave".format(top))
    copytree(os.path.join(base_origin_dir, "server/protocol"), "{}/protocol".format(top))
    # fmt: on

# Prevent any .app application run outside of approved location

import subprocess
import re

approved_path = [
    r' /Applications/',  # /Applications/*
    r' /System/',  # /System/*
    r' /Library/Developer/',  # /Library/Developer/*
    r' /Library/Application Support/',  # /Library/Application Support/*
    r' /Users/[^/]+/Library/Application Support/',  # /Users/*/Library/Application Support/*
    r' /Users/[^/]+/Applications/',  # /Users/*/Applications/*
    r' /opt/homebrew/Cellar/'  # /opt/homebrew/Cellar/*
]

process_list_raw = subprocess.check_output(
    ['grep', '.app/'],
    stdin=subprocess.Popen(
        ['ps', 'aux'],
        stdout=subprocess.PIPE
    ).stdout
).decode('utf-8').split('\n')

# [0:USER, 1:PID, 2:%CPU, 3:%MEM, 4:VSZ, 5:RSS, 6:TT, 7:STAT, 8:STARTED, 9:TIME, 10:COMMAND]
process_list = [' '.join(process.split()).split(' ', 10) for process in process_list_raw]
del process_list[-1]


def path_check(path: str, white_list: list[str]) -> bool:
    """
    Check if path match any regex in white list
    :param path: Path to be validated
    :param white_list: White listed path list in regex
    :return:
    """
    path = ' ' + path
    for w_path in white_list:
        if re.search(w_path, path):
            return True
    return False


for process in process_list:
    if 'grep' not in process[10]:
        if path_check(process[10], approved_path) is False:
            # Kill process
            subprocess.Popen(['kill', '-9', process[1]])
            # Workspace ONE hub notification
            app_name = re.search(r'/[^/]*\.app/', process[10])[0][1:-5]
            subprocess.Popen([
                'hubcli', 'notify',
                '--title', f'{app_name} is Blocked',
                '--subtitle', f'{app_name} is not allowed to be run.',
                '--info', 'Please contact IT dep for more info.'
            ])

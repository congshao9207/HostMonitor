# import shutil
# SMARTCTL_PATH = shutil.which('smartctl')
# print(SMARTCTL_PATH)
import os
project_root = os.path.dirname(os.path.abspath(__file__)) # 向上回一级
print("项目根目录:", project_root)

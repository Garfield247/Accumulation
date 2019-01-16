# -*- coding: utf-8 -*-
# @Date    : 2018-12-17
# @Author  : LvGang/Garfield
# @Email   : Garfield_lv@163.com


import os

readme = './README.md'
rfp = open(readme,'w',encoding='utf-8')
rfp.write('# 目录\n\n')
rfp.write('![avatar](./Utils/linux.jpg)\n\n')

bd = '.'
def li(path):
    for f in os.listdir(path):
        if not str(f).startswith('.') :
            fp=os.path.join(path,f)
            if os.path.isfile(fp):
                rfp.write('    ['+f+']('+fp+')\n\n')
            elif os.path.isdir(fp):
                rfp.write('- %s\n\n'%str(fp).replace('./',''))
                li(fp)

li(bd)
rfp.write('\n> 本目录结构由%s自动生成\n后期将使用LinuxShell进行复写并替代\n'%str(__file__))
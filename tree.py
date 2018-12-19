import os

readme = './README.md'
rfp = open(readme,'w',encoding='utf-8')
rfp.write('# README\n\n')
bd = '.'
def li(path):
    for f in os.listdir(path):
        if str(f) != '.git':
            fp=os.path.join(path,f)
            if os.path.isfile(fp):
                rfp.write('    ['+f+']('+fp+')\n\n')
            elif os.path.isdir(fp):
                rfp.write('- %s\n\n'%str(fp).replace('./',''))
                li(fp)

li(bd)

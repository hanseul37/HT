import os

topmodule = dict()

with open('F:\\study\\AssembleGNN\\HT_dataset\\synth\\topmodule.txt') as fp:
    for line in fp.readlines():
        if line[0] == '\000' or line[:2] == '//':
            continue
        
        line = line.replace(' ', '')
        line = line.replace('\r\n', '')
        line = line.replace('\n', '')
        v_top = line.split(',')
        
        if len(v_top) != 2:
            continue
        
        name = v_top[0].replace('.v', '')
        topmodule[name] = v_top[1]


ban_keywords = ['test.v', 'tb.v', 'test_', '_test', 'tb_', '_tb', 'testbench']

if __name__ == '__main__':
    for ty in os.listdir():#[x for x in os.listdir() if x != 'AES']:
        if len(os.path.splitext(ty)[1]):
            continue
        
        for num in os.listdir(ty):
            if num not in topmodule.keys():
                print(f'No topmodule data exists: {num}')
                continue
            
            files = [x for x in os.listdir(f'{ty}\\{num}')
                if all([ban not in x.lower() for ban in ban_keywords])
                and os.path.splitext(x)[1] == '.v'
            ]
            
            if len(files) == 0:
                continue
            
            '''
            with open(f'{ty}\\{num}\\cfg.tcl', 'w') as fp:
                fp.write('set verilog_files {\\\n')
                for file in files:
                    fp.write(f'\t{file}\\\n')
                fp.write(')\n\nset clk clk\n\n')
                fp.write(f'set top_des_name {topmodule[num]}\n\nset dont_touch_module_name TSC\n')
                fp.close()
            '''
            
            with open(f'{ty}\\{num}\\cfg.tcl') as fp:
                lines = fp.readlines()
                fp.close()
            
            with open(f'{ty}\\{num}\\cfg.tcl', 'w') as fp:
                for li in lines:
                    if li[:16] != 'set top_des_name':
                        fp.write(li)
                        continue
                    
                    fp.write(f'set top_des_name {topmodule[num]}\n')

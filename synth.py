import os
import sys

'''
Example:
> ls ..\
GNNTest HT_dataset
> synth.py ..\GNNTest\synthesizer.py ..\GNNTest\example\common\vsclib013.lib .\synth .\clean_data

--> Execution
{execution:..\GNNTest\synthesizer.py}
-l {liberty:..\GNNTest\example\common\vsclib013.lib}
-t {PARENT_NAME}
-o {output:.\synth}\\{CHILD_DIR}
{CHILD_DIR}
'''

if __name__ == '__main__':
    if len(sys.argv) != 5:
        print('Usage: synth.py {EXECUTION_PATH} {LIBERTY_PATH} {OUTPUT_PATH} {TARGET_PATH}')
        sys.exit(0)
    
    execution = sys.argv[1]
    liberty = sys.argv[2]
    output = sys.argv[3]
    target = sys.argv[4]

    targets = os.listdir(target)

    for parent in targets:
        parent_path = os.path.join(target, parent)
        if os.path.isfile(parent_path):
            continue

        subtargets = os.listdir(parent_path)

        for child in subtargets:
            child_path = os.path.join(parent_path, child)
            if os.path.isfile(child_path):
                continue

            print(f'\n{sys.argv[0]}: synthesizing {child_path} ...')
            _ = os.system(f"{execution} -l {liberty} -t {parent} -o {output}\\{child_path} {child_path}")
            print(f'{sys.argv[0]}: Done.')

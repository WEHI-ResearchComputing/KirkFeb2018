import os
import sys

DATA_DIR = '/stornext/Bioinf/data/bioinf-data/Papenfuss_lab/projects/malaria/cowman_lab/drug_resistance/GilsonT210617/sequence_data'

forward_parent_reads = []
backward_parent_reads = []
forward_child_reads = []
backward_child_reads = []

for f in os.listdir(DATA_DIR):
    d = f[-10:-9]
    t = f[0:3]
    if d == '1' and t == '3D7':
        forward_parent_reads.append(f)
    if d == '1' and t != '3D7':
        forward_child_reads.append(f)
    if d == '2' and t == '3D7':
        backward_parent_reads.append(f)
    if d == '2' and t != '3D7':
        backward_child_reads.append(f)

nParent = len(forward_parent_reads)
if nParent != len(backward_parent_reads):
    print('Forward and backward parent reads do not match')
    sys.exit(0)

nChild = len(forward_child_reads)
if nChild != len(backward_child_reads):
    print('Forward and backward child reads do not match')
    sys.exit(0)

forward_parent_reads.sort()
backward_parent_reads.sort()
forward_child_reads.sort()
backward_child_reads.sort()

def printFile(f):
        print('  - class: File')
        print('    format: "edam:format_1930"')
        print('    location: "' + DATA_DIR + '/' + f + '"')

print('child-reads1:')
for f in forward_child_reads:
    printFile(f)
print('child-reads2:')
for f in backward_child_reads:
    printFile(f)
print('parent-reads1:')
for f in forward_parent_reads:
    printFile(f)
print('parent-reads2:')
for f in backward_child_reads:
    printFile(f)

print('')
print('$namespaces: { edam: http://edamontology.org/ }')
print('$schemas: [ http://edamontology.org/EDAM_1.16.owl ]')

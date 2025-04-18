#!/usr/bin/env python3

import re
import sys

if (int(sys.argv[2]) == 1):
    print("\n",end="")

with open(sys.argv[1], 'r') as file:
    for line in file:
        if (int(sys.argv[2]) == 2):
            print("tf_workshop_map_sync ", end="")
        else:
            print("- ", end="")
        print(re.search(r'workshop/(.*).ugc([0-9]+)', line).group(int(sys.argv[2])))

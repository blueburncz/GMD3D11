path = "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.26100.0\\um\\d3dcommon.h"

with open(path, "r") as f:
    code = f.read()

start = 0
counter = 0

while True:
    i = code.find("typedef \nenum", start)
    if i == -1:
        break
    i = code.find("{", i) + 1
    j = code.find("}", i)
    start = j

    print(
        code[i:j] \
            .replace(" " * 8, "#macro ") \
            .replace("\t=", "") \
            .replace("L,", "") \
            .replace("L\n", "") \
            .replace(",", "") \
            .replace("    ", "")
    )
    counter += 1

import sys
import subprocess

lines = sys.stdin.readlines()[2:-1]

new_lines = []

for line in lines:
    new_lines.append(line.strip()[2:])

try:
    result = subprocess.run(
        ["yamlfmt", "-formatter", "indent=2", "-"],
        input="\n".join(new_lines),
        text=True,
        capture_output=True,
        check=True,
    )
    ret = ["/**", " * @swagger"]
    for line in result.stdout.splitlines():
        ret.append(f" * {line}")
    ret.append(" */")
    print("\n".join(ret))
except:
    exit(1)

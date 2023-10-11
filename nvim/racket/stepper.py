import subprocess
import sys
import re
import json

if len(sys.argv) < 2:
    sys.exit(0)


def replace_quote(s):
    s = s[7:len(s) - 1]
    try:
        int(s)
        return s
    except:
        if len(s) == 3 and s[:2] == "#\\":
            return s
        elif len(s) == 2 and s[0] == "#" and s[1] in ["t", "f"]:
            return s
        else:
            return s

def replace_quotes(s):
    matches = re.findall("\\(quote [^)]+\\)", s)
    for match in matches:
        s = s.replace(match, replace_quote(match))
    return s

def find_closing(exp, i):
    m = {
        "(": ")",
        "[": "]",
        "{": "}",
        "<": ">"
    }
    m_inv = {v: k for k, v in m.items()}
    stack = []
    for j in range(len(exp) - i):
        c = exp[j + i]
        if c in m:
            stack += c
        elif c in m_inv:
            if m_inv[c] == stack[len(stack) - 1]:
                stack.pop()

        if len(stack) == 0:
            return i + j
    return i

def substitute_variables(exp, vars):
    if len(exp) > 1 and exp[0] == "(" and exp[len(exp) - 1] == ")":
        spaceIdx = exp.index(" ")
        fn = exp[1:spaceIdx]
        args = exp[spaceIdx + 1:len(exp) - 1]
        i = 0
        m = len(args)
        while i < m:
            if args[i] == "(":
                closingIdx = find_closing(args, i)
                sub = substitute_variables(args[i:closingIdx + 1], vars)
                args = args[:i] + sub + args[closingIdx + 1:]
                i += len(sub) - 1
            elif args[i] != " ":
                closingIdx = -1
                try:
                    closingIdx = args.index(" ", i)
                except:
                    try:
                        closingIdx = args.index(")", i)
                    except:
                        closingIdx = len(args)

                if closingIdx != -1:
                    if args[i:closingIdx] in vars:
                        sub = vars[args[i:closingIdx]]
                        if isinstance(sub, str):
                            sub = "\"" + sub + "\""
                        args = args[:i] + str(sub) + args[closingIdx:]
                        i += len(str(sub)) - 1
            i += 1
            m = len(args)
        return "({} {})".format(fn, args)
    return exp

run_stepper = subprocess.check_output(["racket", "stepper.rkt", sys.argv[1]]).decode("utf-8")

run_stepper = run_stepper.replace('#%app ', '')
run_stepper = run_stepper.replace('\n', '')
run_stepper = replace_quotes(run_stepper)

result, steps = run_stepper.split('--')

with open(sys.argv[1], 'r') as f:
    lines = f.readlines()
    for step in json.loads(steps):
        row = step['line']
        col = step['column']
        span = step['span']
        vars = {}

        if 'bindings' in step:
            for binding in step['bindings']:
                if step['bindings'][binding][:2] != "#<":
                    val = step['bindings'][binding]
                    try:
                        vars[binding] = int(val)
                    except:
                        vars[binding] = val

        for i in range(len(lines)):
            line = lines[i].replace("\n", "")

            if i == row - 1:
                spanFullLine = False
                if step['kind'] == 'normal-break' and 'becomes' in step:
                    line = step['becomes']
                    col = 0
                    span = len(line)
                    spanFullLine = True

                if step['kind'] == 'result-value-break':
                    line = line[:col] + step['value'] + line[col + span:]
                    span = len(step['value'])

                if (len(vars) > 0):
                    line = substitute_variables(line, vars)
                    if spanFullLine:
                        span = len(line)

                lines[i] = line
                print(line[:col] + "\033[1;32m" + line[col:col + span] + "\033[0m" + line[col + span:])
            else:
                print(line)

        input()
    print("Result is", result)

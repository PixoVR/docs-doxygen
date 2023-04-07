#!/usr/bin/env python3

import re
import sys
import json


# This is from https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
def paren_matcher (n):
    # poor man's matched paren scanning, gives up
    # after n+1 levels.  Matches any string with balanced
    # parens inside; add the outer parens yourself if needed.
    # Nongreedy.
    return r"[^()]*?(?:\("*n+r"[^()]*?"+r"\)[^()]*?)*?"*n

# Check we have the right number of args
if len(sys.argv) != 2:
    print("Usage: "+sys.argv[0]+" <C++ Filename>", file=sys.stderr)
    sys.exit(1)

debug=False
#debug=True

# Get the filename from args
filename = sys.argv[1]

if debug: print("File: "+filename, file=sys.stderr)

# Slurp file into a single string
file = open(filename, 'r')
if file.closed:
    print("Cannot read file", file=sys.stderr)
    sys.exit(1)
content = file.read()

macros = "UCLASS|UENUM|UINTERFACE|USTRUCT|UFUNCTION|UPROPERTY" # todo: |IMPLEMENT_MODULE|IMPLEMENT_GAME_MODULE"

def makeQualifier(match):
	#if debug: print(match)
	macro = match.group(2)
	parts = re.match(r'('+macros+')\(\s*((?:[^\s]+[,\s]*)*)\s*\)',macro,re.M)
	#parts = re.match(r'('+macros+')\((.*)\)',macro,re.M)
	qualifier = ""
	#if debug: print(parts)
	if parts is None:
		#qualifier = "bad regex for %s" % (macro)
		return match.group(0)
	else:
		q = parts.group(2)
		#if (len(q.strip())==0):	# case of empty USTRUCT()
		#	return q
		q = re.sub('\(','{',q)
		q = re.sub('\)','}',q)
		if debug: print(q, file=sys.stderr)
		q = re.sub('=\s*([^",]+)\s*(,|$)',r'="\1"\2',q)
		if debug: print(q, file=sys.stderr)
		#q = re.sub('(\"[^:][^"]+\")([^:])',r'"STRING"\2',q)
		#q = re.sub('(\"[^:,]?[^",]+\")',r'"STRING"',q)
		q = re.sub('(\"[^:,]?[^"]+\")',r'"STRING"',q)
		if debug: print(q, file=sys.stderr)
		q = re.sub('([\w]*)\s*=',r'"\1":',q)
		if debug: print(q, file=sys.stderr)
		q = re.sub('([\w]+)\s*(}|,|$)',r'"\1":null\2',q)
		if debug: print(q, file=sys.stderr)
		q = re.sub('(/\*.*\*/)','',q);
		if debug: print(q, file=sys.stderr)
		q = '{'+q+'}'
		#print(filename, file=sys.stderr)
		if debug: print(q, file=sys.stderr)
		j = json.loads(q)
		#print(j)
		k = list({ele for ele in j if j[ele] is None})
		#print(k)
		for i in k:
			qualifier += "\t\\qualifier "+i+"\n"

	return "%s/**\n\t\\brief **%s**\n%s*/" % (match.group(1), match.group(2), qualifier)

# Do a regular expression to replace all UE4 macros, include balanced params
regex = '^(\s*)((?:'+macros+')\s*\('+paren_matcher(25)+'\))'

#content = re.sub(regex, r'\1/** \\details **\2** */', content, flags=re.MULTILINE)
content = re.sub(regex, makeQualifier, content, flags=re.MULTILINE)

# Output the content
print(content, end='')

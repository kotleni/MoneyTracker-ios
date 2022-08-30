#!/usr/bin/python3
#
#  scan_strings.py
#  MoneyTracker
#
#  Created by Victor Varenik on 30.08.2022.
#

import os

# find string in file and print
def find_in_file(file):
	path = file
	
	if not file.endswith('.swift') or file.endswith("Currencies.swift"):
		return

	_, tail = os.path.split(file)
	if tail[0] == '.':
		return
		
	file = open(file, 'r')
	content = file.read()
	file.close()

	if content[:2] != '//':
		return

	strings = []

	buffer = ""
	is_stringmode = False
	index = 0
	for ch in content:
		if not is_stringmode:
			if ch == '"':
				is_stringmode = True
		else:
			if ch == '"':
				is_stringmode = False
				if content[index + 1] != '.':
					strings.append(buffer)
				buffer = ""
			else:
				buffer += ch

		index += 1

	if len(strings) > 0:
		print("\n")
		print(path)

		for str in strings:
			print("'{}'".format(str), end=', ')
	return

# forech files by path
def find_files(path):
	files = os.listdir(path)
	for entry in files:
		path2 = "{}/{}".format(path, entry)
		if os.path.isdir(path2):
			find_files(path2)
		else:
			find_in_file(path2)

find_files(".")
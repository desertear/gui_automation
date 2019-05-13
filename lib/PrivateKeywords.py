import pyautogui
import os
import json
from robot.api.deco import keyword

class PrivateKeywords(object):
	"""docstring for keyboard"""
	def __init__(self):
		None

	@staticmethod
	def type(keys):
		pyautogui.typewrite(keys)

	@staticmethod
	def write_json_to_file(json_obj,file):
		json_str=json.dumps(json_obj,sort_keys=True,indent=4)
		with open(file,'w') as f:
			f.write(json_str)
		return f



if __name__=="__main__":
	type("abc")


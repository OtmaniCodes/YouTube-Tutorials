from kivy.app import App
from kivy.lang import Builder
from random import randint

KV = """
FloatLayout:
	TextInput:
		id: txt
		size_hint: [0.9, 0.2]
		pos_hint: {'top':0.8, "center_x":0.5}
		font_size: "60sp"
		bold: True
		multiline: False
	Button:
		text: "generate a password".title()
		size_hint: [0.5, 0.2]
		pos_hint: {'top':0.5, "center_x":0.5}
		font_size: "20sp"
		bold: True
		background_normal: ""
		background_color: [1,0,0,1]
		color: [0,0,0,1]
		on_release:
			app.generate_password(txt)
"""

class MyApp(App):
	def build(self):
		return Builder.load_string(KV)

	def generate_password(self, txt_id):
		password_string = ""
		chars = [char for char in range(ord("A"), ord("Z")+1)]
		symbols = ["#", "@", "$", "£", "%"]
		for round in range(4):
			password_string += chr(chars[randint(0, len(chars)-1)])
		password_string += symbols[randint(0, len(symbols)-1)]
		for round in range(4):
			password_string += str(randint(0, 10))
		txt_id.text = password_string

if __name__ == "__main__":
	app = MyApp()
	app.run()















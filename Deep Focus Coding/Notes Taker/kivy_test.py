from kivy.app import App
from kivy.lang import Builder
from kivy.uix.label import Label 
from kivy.core.window import Window

KV = """
<Note>:
	size_hint: [1, None]
	height: self.texture_size[1] + 20
	font_size: '24px'
	color: [0,0,0,1]
	canvas.before:
		Color:
			rgba: [0, 1, 1, 1]
		Rectangle:
			size: self.size
			pos: self.pos


FloatLayout:
	canvas.before:
		Color:
			rgba: [1, 1, 0.75, 1]
		Rectangle:
			size: self.size
			pos: self.pos

	FloatLayout:
		canvas.before:
			Color:
				rgba: [1, 0.8, 0.5, 1]
			Rectangle:
				size: self.size
				pos: self.pos
		pos_hint: {"top": 1}
		size_hint: [1, None]
		height: 56
		Label:
			pos_hint: {"center_y":.5, "center_x":.5}
			text: "Notes Taker"
			color: [0,0,0,1]
			font_size: '28px'
			bold: True

	FloatLayout:
		size_hint: [1, None]
		height: root.height + 120
		top: root.height - 70
		pos_hint: {'center_x':.5}

		TextInput:
			id: text_input
			size_hint: [0.94, None]
			pos_hint: {'top':1, 'center_x': 0.5}
			height: 140
			font_size: '24px'

		Button:
			text: "Add"
			size_hint: [None, None]
			pos_hint: {'right': 0.975}
			top: root.height - 220
			size: [120, 50]
			font_size: '22px'
			bold: True
			background_normal: ''
			background_color: [1, 0, 1,1]
			on_press:
				app.add_note()

		GridLayout:
			pos_hint: {'center_x': 0.5}
			top: root.height - 300
			size_hint: [1, None]
			height: 500
			cols: 1
			spacing: 10
			padding: [40, 10, 40, 10]
			id: notes_box
"""

class Note(Label):
	pass

class NotesTaker(App):

	def build(self):
		Window.size = [450, 540]
		return Builder.load_string(KV)

	def on_start(self):
		lines = self.get_notes_from_db()
		if len(lines) > 0:
			for line in lines:
				self.add_note(line)

	def add_note(self, default=''):
		text_input = self.root.ids['text_input']
		notes_box = self.root.ids['notes_box']
		if default != '':
			note = Note(text=default)
			notes_box.add_widget(note)
		else:
			if(text_input.text.strip() != ''):
				note = Note(text=text_input.text)
				self.save_in_db(text_input.text)
				text_input.text = ''
				notes_box.add_widget(note)

	def save_in_db(self, input_text):
		if(input_text.strip() != ''):
			with open('notes_db.txt', 'a') as db:
				db.write(input_text)
				db.write('\n')

	def get_notes_from_db(self):
		lines = []
		with open('notes_db.txt', 'r') as db:
			for line in db.readlines():
				if(line):
					lines.append(line.strip())
		return lines



if __name__ == '__main__':
	app = NotesTaker()
	app.run()
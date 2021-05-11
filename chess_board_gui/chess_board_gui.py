from kivy.app import App
from kivy.lang.builder import Builder
from kivy.core.window import Window 
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button

KV = """
FloatLayout:
	BoxLayout:
		id: chess_board
		orientation: "vertical"
"""


class MyApp(App):
	def build(self):
		Window.size = [700, 700]
		return Builder.load_string(KV)

	def on_start(self):
		board = self.root.ids.chess_board
		for i in range(8):
			board_row = BoxLayout(orientation="horizontal")
			for j in range(8):
				board_row.add_widget(Button(background_normal="",
					background_color=self.get_color(i, j)))
			board.add_widget(board_row)

	def get_color(self, i, j):
		is_light_square = (i+j)%2 != 0
		if is_light_square:
			return [1,1,1,1]
		else:
			return [0,0,0,1]


app = MyApp()
app.run()



from kivy.app import App
from kivy.lang import Builder
from kivy.uix.floatlayout import FloatLayout
from kivy.graphics.vertex_instructions import Rectangle
from kivy.core.window import Window
from kivy.metrics import dp


class CarGame(FloatLayout):
	
	def __init__(self, **kwargs):
		super().__init__(**kwargs)
		self.speed_factor = 10
		screen_height = Window.size[1]
		with self.canvas.after:
			self.car = Rectangle(source='car.png', size=[120, 100], pos=[10, (screen_height / 2) - 50])


	def go_left(self):
		x, y = self.car.pos

		if x > 0:
			x -= dp(self.speed_factor)
			self.car.pos = [x, y]

	def go_right(self):
		x, y = self.car.pos
		screen_width = Window.size[0]
		car_width = self.car.size[0]
		if x < screen_width - car_width:
			x += dp(self.speed_factor)
			self.car.pos = [x, y]

	def go_up(self):
		x, y = self.car.pos
		screen_height = Window.size[1]
		if y < screen_height * 0.65:
			y += dp(self.speed_factor)
			self.car.pos = [x, y]

	def go_down(self):
		x, y = self.car.pos
		screen_height = Window.size[1]
		if y > screen_height * 0.18:
			y -= dp(self.speed_factor)
			self.car.pos = [x, y]

	def speed_up(self):
		if self.speed_factor < 100:
			self.speed_factor += 5

	def speed_down(self):
		if self.speed_factor > 5:
			self.speed_factor -= 5


class MainApp(App):

	def build(self):
		return Builder.load_file('main.kv')

if __name__ == "__main__":
	MainApp().run()
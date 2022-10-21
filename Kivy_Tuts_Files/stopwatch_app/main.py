from kivy.app import App
from kivy.core.window import Window
from kivy.lang.builder import Builder
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.clock import Clock
from kivy.properties import StringProperty
from kivy.metrics import dp

class MainLayout(FloatLayout):
    stopwatch_txt = StringProperty()
    records_count = 0

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.seconds = 0
        self.minutes = 0
        self.houres = 0
        self.started = False

    def update_time(self, args):
        self.seconds += 1
        if(self.houres < 24):
            if(self.seconds / 60 == 1):
                self.minutes += 1
                self.seconds = 0
            if(self.minutes / 60 == 1):
                self.houres += 1
                self.minutes = 0
                self.seconds = 0
        self.stopwatch_txt = f'{str(self.houres).rjust(2, "0")}:{str(self.minutes).rjust(2, "0")}:{str(self.seconds).rjust(2, "0")}'

    def record_lap(self, args):
        ids = self.ids
        lap = f'{str(self.houres).rjust(2, "0")}:{str(self.minutes).rjust(2, "0")}:{str(self.seconds).rjust(2, "0")}'
        self.records_count += 1
        lap_lbl = Label(text= str(self.records_count).rjust(2, '0') + '. ' + lap, color=[1,1,1,1], texture_size=self.size, font_size=dp(16))
        ids['laps'].add_widget(lap_lbl)
        

    def start_stopwatch(self):
        self.started = True
        Clock.schedule_interval(self.update_time, 1)
        lap_btn = Button(text='ADD LAP', on_release=self.record_lap, background_color=[0, 1, 0, 1], background_normal='', color=[0,0,0,1], pos_hint={'center_x': .5, 'top': .25}, size_hint=[None, None], size=[dp(200), dp(50)])
        self.add_widget(lap_btn)
        self.ids['start_btn'].disabled = True



class MainApp(App):

    def build(self):
        Window.size = [360, 640]
        return Builder.load_file('main.kv')


if __name__ == '__main__':
    MainApp().run()

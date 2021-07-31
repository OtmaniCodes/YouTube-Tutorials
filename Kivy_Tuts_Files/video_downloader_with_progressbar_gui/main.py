from kivy.app import App
from kivy.lang.builder import Builder
import pytube
from kivy.clock import Clock


KV = """
FloatLayout:
    canvas.before:
        Color:
            rgba: [1,0,0.5,1]
        Rectangle:
            pos: self.pos
            size: self.size
    TextInput:
        id: input_field
        size_hint: [0.8, 0.1]
        pos_hint: {"center_x":.5, "top":0.9}
        font_size: "22sp"
    Button:
        size_hint: [0.8, 0.1]
        pos_hint: {"center_x":.5, "top":0.6}
        font_size: "32sp"
        text: "download"
        on_press: app.download_vid(input_field)
    ProgressBar:
        id: progress_bar
        size_hint: [0.8, 0.1]
        pos_hint: {"center_x":.5, "top":0.4}
        value: 50


"""


class MyApp(App):
    def build(self):
        return Builder.load_string(KV)

    def download_vid(self, target):
        # try:
        print(target.text)
        yt = pytube.YouTube(target.text, on_progress_callback=self.progress_func)
        Clock.schedule_once(lambda x:  yt.streams.first().download(), 4)
        
        # yt.streams.first().download()
        # except:
            # print("error")
    def percent(self, tem, total):
        perc = (float(tem) / float(total)) * float(100)
        return perc
        

    def progress_func(self, stream, chunck, file_handle, bytes_remaining):
        print("hi")
        size = stream.filesize
        p = 0
        while p <= 100:
            progress = p
            print(f"{p}%")
            p = self.percent(bytes_remaining, size)

    



if __name__ == "__main__":
    app = MyApp()
    app.run()
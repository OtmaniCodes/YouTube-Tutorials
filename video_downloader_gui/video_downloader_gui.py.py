from kivy.app import App
from kivy.lang.builder import Builder
from kivy.core.window import Window
from kivy.clock import Clock
import pytube
import kivymd


KV = """
FloatLayout:
    canvas.before:
        Color:
            rgba: rgba("#FF5555")
        Rectangle:
            size: self.size
            pos: self.pos
    Label:
        text: "youtube videos downloader".title()
        size_hint: [None, None]
        size: self.texture_size
        pos_hint: {"top":0.94, "center_x":0.5}
        font_size: "27sp"
        bold: True
        canvas.before:
            Color:
                rgba: rgba("#000000")
            Rectangle:
                size: self.size
                pos: self.pos
    TextInput:
        id: txt_input
        background_color: [1,1,1,1]
        pos_hint: {"top":0.8, "center_x":0.5}
        color: [0,0,0,1]
        bold: True
        font_size: "20sp"
        multiline: False
        size_hint: [0.85, 0.06]
    Button:
        id: save_btn
        text: "Download"
        background_normal: ""
        background_color: [0,0,0,1]
        color: [1,1,1,1]
        bold: True
        font_size: "18sp"
        pos_hint: {"top":0.7, "center_x":0.5}
        size_hint: [0.3, 0.08]
        on_press:
            app.download_video(txt_input.text)
    AsyncImage:
        id: thumbnail
        pos_hint: {"top":0.4, "center_x":0.5}
        size_hint: [0.9, 0.2]
        source: ''
    Label:
        id: title
        text: "video title".title()
        size_hint: [None, None]
        size: self.texture_size
        pos_hint: {"top":0.2, "center_x":0.5}
        font_size: "20"
        bold: True
        color: [0,0,0,1]
"""

class MyApp(App):
    image_loaded = False

    def build(self):
        Window.size = [360, 600]
        return Builder.load_string(KV)

    def set_assets(self, thumbnail, title):
        self.root.ids.thumbnail.source = thumbnail
        self.root.ids.title.text = title

    def get_video(self, stream):
        if self.image_loaded == True:
            stream.download()
        # kivymd.toast("video is downloading...", 1)

    def download_video(self, url):
        yt = pytube.YouTube(url)
        self.set_assets(yt.thumbnail_url, yt.title)
        self.image_loaded = True
        Clock.schedule_once(lambda x: self.get_video(yt.streams.first()), 4)


if __name__ == "__main__":
    app = MyApp()
    app.run()
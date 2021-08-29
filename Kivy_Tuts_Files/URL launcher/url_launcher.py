from kivy.app import App
from kivy.lang.builder import Builder
from kivy.core.window import Window
import webbrowser

KV = """
<LinkButton@Button>
    background_normal: ''
    color: [1,1,1,1]
    bold: True
    size_hint: [0.8, 0.06]

FloatLayout:
    canvas.before:
        Color:
            rgba: [1,1,1,1]
        Rectangle:
            pos: self.pos
            size: self.size
    AsyncImage:
        source: "https://www.freeiconspng.com/uploads/links-icon-28.png"

    Label:
        text: "URL Launcher"
        color: [0,0,0,1]
        font_size: '28sp'
        texture_size: self.size
        size_hint: [None, None]
        pos_hint: {"center_x":0.5, "top":0.9}


    LinkButton:
        pos_hint: {"center_x":0.5, "top":0.6}
        background_color: [1,0,0,1]
        text: "YouTube"
        on_release:
            app.launch_link(0)
    LinkButton:
        pos_hint: {"center_x":0.5, "top":0.5}
        background_color: [0,0,1,1]
        text: "Twitter"
        on_release:
            app.launch_link(1)
    LinkButton:
        pos_hint: {"center_x":0.5, "top":0.4}
        background_color: [1,0,0.5,1]
        text: "Instagram"
        on_release:
            app.launch_link(2)
    LinkButton:
        pos_hint: {"center_x":0.5, "top":0.3}
        background_color: [0,0,0,1]
        text: "GitHub"
        on_release:
            app.launch_link(3)


"""

class MyApp(App):
    def build(self):
        Window.size = [400, 600]
        return Builder.load_string(KV)

    def launch_link(self, index):
        link = ''
        if index == 0:
            link = 'https://www.youtube.com/channel/UCNFmUzWMC5uzy8by0hJf9-Q'
        elif index == 1:
            link = 'https://twitter.com/ahmed0tdc?s=09'
        elif index == 2:
            link = 'https://www.instagram.com/ahmed0tdc'
        else:
            link = 'https://github.com/Ahmed0tdc'
        webbrowser.open(link)


if __name__ == '__main__':
    app = MyApp()
    app.run()

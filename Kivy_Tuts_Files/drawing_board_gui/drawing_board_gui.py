from tkinter import *
from tkinter import ttk, messagebox
import turtle

root = Tk()
root.title('drawing GUI')
root.geometry('809x620')
root.config(bg='black')


class Movements:

    def exit(self):
        q = messagebox.askyesno('Exit.', 'do you want to leave?'.title())
        if q == True:
            root.destroy()
        else:
            pass

    def changing_color(self):
        john.pencolor(cbox.get())
        john.color(cbox.get())

    def board_color(self):
        canvas.config(bg=bbox.get())

    def shape(self, shape):
        if shape == 'turtle':
            john.shape('turtle')
        elif shape == 'square':
            john.shape('square')
        elif shape == 'circle':
            john.shape('circle')

    def forward(self):
        john.forward(50)

    def backward(self):
        john.back(50)

    def right(self):
        john.right(90)

    def left(self):
        john.left(90)


pro = Movements()

canvas = Canvas(root, width=809, height=400)
canvas.grid(row=0, columnspan=6, pady=20)

john = turtle.RawTurtle(canvas)

# Buttons:

ft = 'tahoma 10 bold'
btn_style = ttk.Style()
btn_style.configure('TButton', background='red',
                    forground='red', font=ft)


forward_btn = ttk.Button(root, text='Forward',
                         style='TButton', command=pro.forward)
backward_btn = ttk.Button(root, text='backward',
                          style='TButton', command=pro.backward)
right_btn = ttk.Button(root, text='Right', style='TButton', command=pro.right)
left_btn = ttk.Button(root, text='Left', style='TButton', command=pro.left)


forward_btn.grid(row=1, column=1)
backward_btn.grid(row=3, column=1)
right_btn.grid(row=2, column=2)
left_btn.grid(row=2, column=0)


# Colors:
colors = ["red", 'purple', 'yellow',
          'pink', 'blue', 'lightblue',
          'brown', 'white', 'orange']


cbox = ttk.Combobox(root, values=colors)
cbox.config(font=('arial', 15, 'underline'), width=20)
cbox.set('Change Color!')
cbox.grid(row=1, column=5)
cbox['state'] = 'readonly'

ok_btn = ttk.Button(root, text='Save', style='TButton',
                    command=pro.changing_color)
ok_btn.grid(row=1, column=4)

bbox = ttk.Combobox(root, values=colors)
bbox.config(font=('arial', 15, 'underline'), width=20)
bbox.grid(row=3, column=5)
bbox.set('Change Board\'s Color!')
bbox['state'] = 'readonly'

ok2_btn = ttk.Button(root, text='Save', style='TButton',
                     command=pro.board_color)
ok2_btn.grid(row=3, column=4)


btn1 = ttk.Button(root, text='Turtle', style='TButton',
                  command=lambda: pro.shape('turtle'))
btn2 = ttk.Button(root, text='Square', style='TButton',
                  command=lambda: pro.shape('square'))
btn3 = ttk.Button(root, text='Circle', style='TButton',
                  command=lambda: pro.shape('circle'))

btn1.grid(row=4, column=1, pady=10)
btn2.grid(row=4, column=3, pady=30)
btn3.grid(row=4, column=5, pady=10)

lbl1 = Label(root, text='|')
lbl2 = Label(root, text='|')


ft2 = 'impact 13 bold'
lbl1.config(bg='black', fg='red', font=ft2)
lbl2.config(bg='black', fg='red', font=ft2)

lbl1.grid(row=4, column=2, pady=10)
lbl2.grid(row=4, column=4, pady=10)

exit_btn = Button(root, text='Exit', command=pro.exit)
exit_btn.config(bg='red', fg='black', font=ft2)
exit_btn.grid(row=4, column=0)

root.resizable(False, False)


root.mainloop()
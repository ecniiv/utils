#!/bin/python3
import plotly.figure_factory as ff

TITLE = "My gantt"
HEIGHT = 800

# Tasks
df = [
    dict(Task='Task 1', Start='2021-01-01', Finish='2021-01-12', Complete=100),
    dict(Task='Task 2', Start='2021-01-07', Finish='2021-01-23', Complete=70),
    dict(Task='Task 3', Start='2021-01-19', Finish='2021-02-02', Complete=30)
]

# Range colors
colors = ['#333F44', '#93e4c1']

# Create gantt diagram
fig = ff.create_gantt(df, colors=colors, index_col='Complete', title=TITLE, show_colorbar=True, height=HEIGHT, bar_width=0.4, showgrid_x=True, showgrid_y=True, show_hover_fill=False)

# Display in web browser
fig.show()

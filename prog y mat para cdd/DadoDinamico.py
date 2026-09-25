import sys
import random
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import seaborn as sns

try:
    total_rolls = int(sys.argv[1])
except IndexError:
    print("No se proporcionó argumento. Usando 36,000 por defecto.")
    total_rolls = 36000

number_of_frames = 30
rolls_per_frame = total_rolls // number_of_frames

frequencies = [0] * 13
sum_values = list(range(2, 13)) 

sns.set_style("whitegrid")
fig = plt.figure(figsize=(10, 6))

def update(frame_number):
    for _ in range(rolls_per_frame):
        die1 = random.randrange(1, 7)
        die2 = random.randrange(1, 7)
        frequencies[die1 + die2] += 1
    
    plt.cla()
    
    freqs_to_plot = frequencies[2:]
    current_total = sum(freqs_to_plot)
    
    axes = sns.barplot(x=freqs_to_plot, y=sum_values, hue=sum_values, orient='h', palette='bright', legend=False)
    
    axes.set_title(f'Tirando 2 dados {current_total:,} veces')
    axes.set(xlabel='Frecuencia', ylabel='Suma de los 2 dados')
    
    if max(freqs_to_plot) > 0:
        axes.set_xlim(right=max(freqs_to_plot) * 1.15)
    
    for bar, frequency in zip(axes.patches, freqs_to_plot):
        if frequency > 0:
            text_x = bar.get_width() 
            text_y = bar.get_y() + bar.get_height() / 2.0
            text = f' {frequency:,} ({frequency / current_total:.3%})'
            axes.text(text_x, text_y, text, fontsize=11, ha='left', va='center')

ani = FuncAnimation(fig, update, frames=number_of_frames, repeat=False)

plt.show()
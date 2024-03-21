import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np
import cv2
import pandas as pd

# Read data from CSV file
data = pd.read_csv('vt_energy_2024_03_03_16_59.csv')  # Assuming your CSV file is named 'data.csv'
# Downsample factor (adjust as needed)
downsample_factor = 20

# Extract variables from the CSV data
rho = data['rho'][::downsample_factor]
rho_frc = data['rho_frc'][::downsample_factor]
t = data['time_duration'][::downsample_factor]

duration = 38.695  # read from csv file
fps = 50 # 1k hz / downsample factor

# Initialize video writer
fourcc = cv2.VideoWriter_fourcc(*'mp4v')
out = cv2.VideoWriter('dynamic_plot.mp4', fourcc, fps, (800, 600))

# Create a dynamic plot
fig, ax = plt.subplots()


# Render each frame and save it to the videot
for i in range(len(t)):
    ax.clear()
    ax.set_ylim(0, 1.2)

    ax.set_xlabel('time [s]')
    ax.set_ylabel('rho_frc')
    ax.plot(t[:i], rho_frc[:i])  # Update the plot for the current frame

    fig.canvas.draw()  # Draw the updated plot on the canvas
    frame = np.frombuffer(fig.canvas.tostring_rgb(), dtype=np.uint8)
    frame = frame.reshape((480,640) + (3,))
    frame = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
    frame = cv2.resize(frame, (800, 600))  # Resize frame to match video dimensions
    out.write(frame)

# Release video writer
out.release()

# Close the Matplotlib window
plt.close(fig)
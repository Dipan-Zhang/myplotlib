import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import pandas as pd
# Define the coordinates

x = np.linspace(0.529194, 0.829194, 100)
y = np.linspace(-0.18277, 0.3877, 100)
# Create a meshgrid
X, Y = np.meshgrid(x, y)
# Define the function for z
# Z = 0.03 * np.sin(np.pi / 0.225 * (Y + 0.48277)) - 0.0514193
Z = 0.0225 * np.sin(np.pi / 0.19125 * (Y + 0.43777)) + 0.0008768438553769359

offset = 0.00260926 - (0.0225 * np.sin(np.pi / 0.19125 * (-0.13902 + 0.43777)) + 0.0238057)
print(offset)
# Read 3D points from CSV file
data = pd.read_csv('vt_energy_2024_02_18_18_46.csv')
# Extract x, y, z coordinates from the CSV data
x_points = data['x']
y_points = data['y']
z_points = data['z']

# Plotting
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.set_zlim3d(bottom=-0.1,top=0.2)
# Plot the surface
ax.plot_surface(X, Y, Z, cmap='viridis', alpha=0.5)
# Plot the points
ax.scatter(x_points, y_points, z_points,s=0.8, color='red', label='Points')
# Labeling the axes
ax.set_xlabel('X [m]')
ax.set_ylabel('Y [m]')
ax.set_zlabel('Z [m]')
# Show the plot
plt.legend()
plt.show()
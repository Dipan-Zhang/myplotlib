
addpath(genpath('plot2svg-1.9.0')); %load the functions
% Define cylinder parameters
radius = 20;  % Radius of the cylinder
height = 40; % Height of the cylinder

% Create a grid of points in cylindrical coordinates (r, theta, z)
theta = linspace(0, pi, 200);   % Ranges from 0 to pi (for half cylinder)
x = linspace(0, height, 100);    % Ranges from 0 to height
[theta, x] = meshgrid(theta, x);

% Convert cylindrical coordinates to Cartesian coordinates (x, y, z)
y_cylinder = radius * cos(theta);
z_cylinder = radius * sin(theta);
x_cylinder = x;

% Plot the half cylinder using surf
figure;
surf(x_cylinder, y_cylinder, z_cylinder, 'FaceAlpha', 0.8);
hold on;
xlabel('x-position [cm]');
ylabel('y-position [cm]');
zlabel('z-position [cm]');
title('Trajectory Projection');

% Add the circle
circle_radius = 16;
circle_center = [20,0, 35]; % Center of the circle (x, y, z)
theta_circle = linspace(0, 2*pi, 100); % radius corrdinate
x_circle = circle_center(1) + circle_radius * cos(theta_circle);
y_circle = circle_center(2) + circle_radius * sin(theta_circle);
z_circle = circle_center(3) * ones(size(theta_circle));

plot3(x_circle, y_circle, z_circle, 'r', 'LineWidth', 2);

% surf(x_circle, y_circle, z_proj, 'FaceAlpha', 0.5, 'FaceColor', 'b', 'EdgeColor', 'none');

proj_points = zeros(size(x_circle, 2), 3);
for i = 1:size(x_circle, 2)
    dist = sqrt((x_cylinder - x_circle(i)).^2 + (y_cylinder - y_circle(i)).^2);
    [min_dist, min_idx] = min(dist(:));
    [min_row, min_col] = ind2sub(size(dist), min_idx);
    proj_points(i, :) = [x_cylinder(min_row, min_col), y_cylinder(min_row, min_col), z_cylinder(min_row, min_col)];
end
plot3(proj_points(:, 1), proj_points(:, 2), proj_points(:, 3), 'b', 'LineWidth', 2,'DisplayName', 'Trajectory Projection');
% Project the circle onto the cylinder surface (simple orthogonal projection)
% x_proj = circle_center(1) + circle_radius * cos(theta);
% y_proj = circle_center(2) + circle_radius * sin(theta);
% z_proj = z;
% surf(x_proj, y_proj, z_proj, 'FaceAlpha', 0.5, 'FaceColor', 'b', 'EdgeColor', 'none');

axis equal;
view(3); % Set the 3D view
plot2svg('sphere.svg');
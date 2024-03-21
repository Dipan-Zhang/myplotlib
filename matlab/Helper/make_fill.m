function [fill_mat] = make_fill(cases,color_mat)
%MAKE_FILL computes a fill_mat for my gif_plot, with 5 colors. 
% cases is vector of integers with length of data to plot, which determines
% in which region which case/color is active. Zero is treated as no color.
% color_mat matrix with different RGB colors as rows.

% init
fill_mat = [];
duration = size(cases,1);

% calculate times where case is changed
ti_vec = [1];
v1 = cases(1);
for i_case = 2:duration
    if v1 ~= cases(i_case)
        ti_vec = [ti_vec;i_case];
    end
    v1=cases(i_case);
end
ti_vec = [ti_vec;duration];

% Calculate regions
for i_reg = 1:size(ti_vec,1)-1
    % get case in this region
    reg_case = cases(ti_vec(i_reg));
    % put region borders and color in fill matrix
    switch reg_case
        case 1
            fill_mat = [fill_mat;ti_vec(i_reg) ti_vec(i_reg+1) color_mat(1,:)];
        case 2
            fill_mat = [fill_mat;ti_vec(i_reg) ti_vec(i_reg+1) color_mat(2,:)];
        case 3
            fill_mat = [fill_mat;ti_vec(i_reg) ti_vec(i_reg+1) color_mat(3,:)];
        case 4
            fill_mat = [fill_mat;ti_vec(i_reg) ti_vec(i_reg+1) color_mat(4,:)];
        case 5
            fill_mat = [fill_mat;ti_vec(i_reg) ti_vec(i_reg+1) color_mat(5,:)];
    end
end

end


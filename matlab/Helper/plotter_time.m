function fig = plotter_time(toplot,save_pdf)

%% parameters
line_width = 1; %default linewidth for all lines
line_style = '-'; %default linestyle
line_factor = 0.001;      % fill function


%% basics
ndata = toplot.idata;
legend_entries = cell(ndata,2); % For saving the entries and handles
fig = figure; %make figure
hold on
cmap = colormap(lines); %load colormap

%% actual plot
% Plot fills
if isfield(toplot,'fill_mat') 
if ~isempty(toplot.fill_mat)
    ax = gca;
    if ~isfield(toplot,'YLim') 
        error('Sorry, but fill_mat function needs YLim!');
    end
    upp_lim = toplot.YLim(2);
    low_lim = toplot.YLim(1);
    T_inter = [toplot.time_vec inf]-[0 toplot.time_vec];
    T_sample = mean(T_inter(2:end-1)); % sample Time from data
    clear T_inter

    line_offset = (upp_lim - low_lim)*line_factor;
    fill_upp = upp_lim - line_offset;
    fill_low = low_lim + line_offset;
    for fill_i = 1:size(toplot.fill_mat,1)
        fill_lef = toplot.fill_mat(fill_i,1)*T_sample;
        fill_rig = toplot.fill_mat(fill_i,2)*T_sample; %draw full region
        fill(...
            [fill_lef fill_lef fill_rig fill_rig],... % timeslot to fill
            [fill_upp fill_low fill_low fill_upp],... % subplot hight
            toplot.fill_mat(fill_i,3:5), ... % color from toplot.fill_mat
            'EdgeColor','none','facealpha',0.5);  %rest is fixed
    end
end
end

for idata=1:ndata
    if isfield(toplot.data(idata),'line_width')
        if ~isempty(toplot.data(idata).line_width)
            line_width_int = toplot.data(idata).line_width;
        else
            line_width_int = line_width;
        end
    else
        line_width_int = line_width;
    end
    if isfield(toplot.data(idata),'line_color')
        if ~isempty(toplot.data(idata).line_color)
            line_color_int = toplot.data(idata).line_color;
        else
            line_color_int = cmap(idata,:);
        end
    else
        line_color_int = cmap(idata,:);
    end
    if isfield(toplot.data(idata),'style')
        if ~isempty(toplot.data(idata).style)
            line_style_int = toplot.data(idata).style;
        else
            line_style_int = line_style;
        end
    else
        line_style_int = line_style;
    end
    
    toplot.data(idata).plot = plot(...
        toplot.time_vec,...
        toplot.data(idata).data,...
        line_style_int,...
        'color',line_color_int,...
        'linewidth',line_width_int...
        );
        
    % Save plot and name for legend entry
    legend_entries{idata,1} = toplot.data(idata).plot;
    legend_entries{idata,2} = toplot.data(idata).name;
end

%% Legend
legend([legend_entries{:,1}],legend_entries{:,2});

hold off

fig = plotter_handle(fig,toplot,save_pdf);

end


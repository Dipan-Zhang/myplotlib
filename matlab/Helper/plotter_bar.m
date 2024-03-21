function fig = plotter_bar(toplot,save_pdf)

%% parameters
LineWidth = 1; %default linewidth for errorbar lines
LineColor = [0 0 0];  %default line color for errorbar lines

%% basics
fig = figure;

%% bar plot
fake_multi_mode = false;
if isfield(toplot,'Single_as_multi') %If you have just a single row, but want to have different colors per bar
    if toplot.Single_as_multi
        if size(toplot.bar_data,1)==1
            toplot.bar_data = [toplot.bar_data; zeros(1,size(toplot.bar_data,2))];
            fake_multi_mode = true;
        end
    end
end
fig_bar = bar(toplot.bar_data); %make bar plot
% if size(toplot.bar_data,1)==1
%     cmap = colormap(lines);
%     fig_bar.CData = cmap(1:size(toplot.bar_data,2),:);
% end
for i=1:numel(fig_bar)
    x(i,:) = fig_bar(i).XEndPoints;
    if isfield(toplot,'barcolor')
        fig_bar(i).FaceColor = toplot.barcolor(i,1:3); %colors of bars as rows  
    end
end
if isfield(toplot,'XTickLabel')
    toplot.XTick = mean(x); %label at X axis  
end
if fake_multi_mode
    ax = gca;
    toplot.XLim = [ax.XLim(1) (mean(ax.XLim))];
end
toplot.XGrid = 'off'; %switch off x grid
toplot.XTickLength = [0 0]; %switch off xticks

%% errorbar plot
hold on
if isfield(toplot,'bar_err')
    toplot.bar_err_low = toplot.bar_err;
    toplot.bar_err_high = toplot.bar_err;
end
if isfield(toplot,'bar_err_low') && isfield(toplot,'bar_err_high')
    if fake_multi_mode
        toplot.bar_err_low = [toplot.bar_err_low; zeros(1,size(toplot.bar_err_low,2))];
        toplot.bar_err_high = [toplot.bar_err_high; zeros(1,size(toplot.bar_err_high,2))];
    end
    err_bar = errorbar(x,toplot.bar_data',toplot.bar_err_low',toplot.bar_err_high'); 
    for i=1:numel(err_bar)                         
        err_bar(i).LineStyle = 'none';
        if isfield(toplot,'LineColor')
            err_bar(i).Color = toplot.LineColor;
        else
            err_bar(i).Color = LineColor;
        end
        if isfield(toplot,'LineWidth')
            err_bar(i).LineWidth = toplot.LineWidth;
        else
            err_bar(i).LineWidth = LineWidth;
        end  
    end
end

%% Legend
if isfield(toplot,'legend_entries')
    legend(toplot.legend_entries);
end

hold off

fig = plotter_handle(fig,toplot,save_pdf); %direct call of plotter handle


end


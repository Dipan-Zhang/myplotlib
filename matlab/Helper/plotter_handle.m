function fig = plotter_handle(fig,toplot,save_pdf)

%% style parameters
if isfield(toplot,'style')
    if strcmpi(toplot.style,'paper') 
        style = 1;
    elseif strcmpi(toplot.style,'ppt') || strcmpi(toplot.style,'pptx') || strcmpi(toplot.style,'powerpoint') || strcmpi(toplot.style,'presentation')
        style = 2;
    elseif strcmpi(toplot.style,'thesis')
        style = 3;
    else
        warning('unknown style in plotter_handle! using default instead');
        style = 0;
    end
else
    style = 0;
end

switch style
    case 0 % default
        latex_style = false; %if true overrides font_name
        font_name = ''; %Set '' to automatic
        style_width = 10; %default plot width in cm
        style_height = 6; %default plot height in cm
        font_size = 0; %default fontsize; or 0 = matlab default
    case 1 % paper
        latex_style = true; %if true overrides font_name
        font_name = ''; %Set '' to automatic
        style_width = 8.63477;
        style_height = 8.63477; %default plot size is square ...
        font_size = 13;
        if ~isfield(toplot,'height_fac') %... But 0.6 height factor
            toplot.height_fac = 0.6;
        end
    case 2 % ppt
        latex_style = false; %if true overrides font_name
        font_name = 'Helvetica'; %Set '' to automatic
        style_width = 23.64; %TUM template size
        style_height = 8.88;
        font_size = 12;
    case 3 % thesis
        latex_style = true; %if true overrides font_name
        font_name = ''; %Set '' to automatic
        style_width = 14.8; %for STUDENTS: put here textwidth in cm of your thesis !
        style_height = 7.0; %for STUDENTS: put here your standard height in cm of a plot in your thesis !
        font_size = 10;
end

% Overrides from outside
if isfield(toplot,'latex_style')
    latex_style = toplot.latex_style;
end   
if isfield(toplot,'font_name')
    font_name = toplot.font_name;
end    
if isfield(toplot,'font_size')
    font_size = toplot.font_size; % set 0 to automatic
end 

%% make plot nice
box on
grid on 
if isfield(toplot,'width_fac')
    wfac = toplot.width_fac;
else
    wfac = 1.0;
end
if isfield(toplot,'height_fac')
    hfac = toplot.height_fac;
else
    hfac = 1.0;
end
dimensions = [style_width*wfac, style_height*hfac];
% set dimension of figure suitable for latex document
set(gcf, 'Units', 'centimeters', 'Position', [10, 10, dimensions], 'PaperUnits', 'centimeters', 'PaperSize', dimensions)

%% Set general properties of axes
ax = gca;
if ~isempty(font_name)
    ax.FontName = font_name;
end
if font_size>0
    ax.FontSize = font_size;
    ax.LabelFontSizeMultiplier = 1.0;
end
if isfield(toplot,'title')
    ax.Title.String = toplot.title;
    if ~isempty(font_name)
        ax.Title.FontName = font_name;
    end
    if font_size>0
        ax.Title.FontSize = font_size;
    end
    if latex_style
        ax.Title.Interpreter = 'latex';
    end
end
ax.GridLineStyle = '--';
if latex_style
    ax.TickLabelInterpreter = 'latex';
end

%% xaxis
ax.XLabel.Color = [0 0 0]; %real black label
ax.XColor = [0 0 0]; %line + ticklabels
if isfield(toplot,'XLim')
    ax.XLim = toplot.XLim;
end
if isfield(toplot,'XLabel')
    ax.XLabel.String = toplot.XLabel;
end
if isfield(toplot,'XScale')
    ax.XScale = toplot.XScale;
end
if isfield(toplot,'XTick')
    ax.XTick = toplot.XTick; 
end
if isfield(toplot,'XTickLabel')
    ax.XTickLabel = toplot.XTickLabel;
end
if isfield(toplot,'XTickLabelRotation')
    ax.XTickLabelRotation = toplot.XTickLabelRotation;
end
if isfield(toplot,'XTickLength')
    ax.XAxis.TickLength = toplot.XTickLength; %switch off xticks with [0 0]
end
if isfield(toplot,'XGrid')
    ax.XGrid = toplot.XGrid;
end
if latex_style
    ax.XAxis.TickLabelInterpreter = 'latex';
    ax.XAxis.Label.Interpreter = 'latex';
end

%% yaxis
ax.YLabel.Color = [0 0 0]; %real black label
ax.YColor = [0 0 0]; %line + ticklabels
if isfield(toplot,'YLim')
    ax.YLim = toplot.YLim;
end
if isfield(toplot,'YLabel')
    ax.YLabel.String = toplot.YLabel;
end
if isfield(toplot,'YScale')
    ax.YScale = toplot.YScale;
end
if isfield(toplot,'YTick')
    ax.YTick = toplot.YTick;
end
if isfield(toplot,'YTickLabel')
    ax.YTickLabel = toplot.YTickLabel;
end
if isfield(toplot,'YTickLabelRotation')
    ax.YTickLabelRotation = toplot.YTickLabelRotation;
end
if isfield(toplot,'YTickLength')
    ax.YAxis.TickLength = toplot.YTickLength; %switch off yticks with [0 0]
end
if isfield(toplot,'YGrid')
    ax.YGrid = toplot.YGrid;
end
if latex_style
    ax.YAxis.TickLabelInterpreter = 'latex';
    ax.YAxis.Label.Interpreter = 'latex';
end

%% zaxis
ax.ZLabel.Color = [0 0 0]; %real black label
ax.ZColor = [0 0 0]; %line + ticklabels
if isfield(toplot,'ZLim')
    ax.ZLim = toplot.ZLim;
end
if isfield(toplot,'ZLabel')
    ax.ZLabel.String = toplot.ZLabel;
end
if isfield(toplot,'ZScale')
    ax.ZScale = toplot.ZScale;
end
if isfield(toplot,'ZTick')
    ax.ZTick = toplot.ZTick; 
end
if isfield(toplot,'ZTickLabel')
    ax.ZTickLabel = toplot.ZTickLabel;
end
if isfield(toplot,'ZTickLabelRotation')
    ax.ZTickLabelRotation = toplot.ZTickLabelRotation;
end
if isfield(toplot,'ZTickLength')
    ax.ZAxis.TickLength = toplot.ZTickLength; %switch off xticks with [0 0]
end
if isfield(toplot,'ZGrid')
    ax.ZGrid = toplot.ZGrid;
end
if latex_style
    ax.ZAxis.TickLabelInterpreter = 'latex';
    ax.ZAxis.Label.Interpreter = 'latex';
end

%% Legend
hLegend = findobj(gcf, 'Type', 'Legend');
if ~isempty(hLegend)
    if isfield(toplot,'legend_loc')
        hLegend.Location = toplot.legend_loc;
    end
    if isfield(toplot,'legend_ori')
        hLegend.Orientation = toplot.legend_ori;
    end
    if isfield(toplot,'legend_cols')
        hLegend.NumColumns = toplot.legend_cols;
    end
    if font_size>0
        hLegend.FontSize = font_size;
    end
    if ~isempty(font_name)
        hLegend.FontName = font_name;
    end
    if latex_style
        hLegend.Interpreter = 'latex';
    end
    if isfield(toplot,'legend_tokensize')
        hLegend.ItemTokenSize = hLegend.ItemTokenSize*toplot.legend_tokensize;
    else
        hLegend.ItemTokenSize = hLegend.ItemTokenSize*0.66;
    end
end

%% maximize plot in figure window
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
if abs(ax.Position(1)-left)>1e-6
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3) - 0.005; %0.003 self adjusted, due to box
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.005;
    ax.Position = [left bottom ax_width ax_height];
end


%% save if requested
if save_pdf
    if isfield(toplot,'folderpath')
        folderpath = toplot.folderpath;
    else
        folderpath = 'plots';
    end 
    if ~isempty(folderpath) && ~exist(folderpath,'dir')
        mkdir (folderpath) % make fresh one
    end
    if ~isfield(toplot,'name')
        toplot.name = 'plot';
    end
    if isempty(toplot.name)
        toplot.name = 'plot';
    end
    saveas(fig, fullfile(folderpath, toplot.name), 'pdf');
    saveas(fig, fullfile(folderpath, toplot.name), 'png');
    saveas(fig, fullfile(folderpath, toplot.name), 'fig');
end

end


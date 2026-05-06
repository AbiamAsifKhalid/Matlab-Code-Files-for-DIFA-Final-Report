%% DoF Figure 
clear; clc;

f   = 1.88e-3;      
N   = 2.0;          
c   = 2.09e-6;      
H   = f^2 / (N*c);  

so     = linspace(0.05, 1.2, 1000);
d_near = H .* so ./ (H + so);
d_far  = H .* so ./ (H - so);
d_far(so >= H) = 3.0; 

figure(4);
set(gcf, 'Units', 'inches', 'Position', [1 1 8 5]);
set(gcf, 'Color', 'w');

h_dof = patch([so, fliplr(so)], ...
    [d_near, fliplr(min(d_far, 3.0))], ...
    [0.6 0.85 1.0], ...
    'FaceAlpha', 0.35, 'EdgeColor', 'none');
h_dof.DisplayName = 'In-focus region (DoF)';
hold on;

h_wr = patch([0.2 1.0 1.0 0.2], [0 0 3 3], ...
    [1.0 0.9 0.7], ...
    'FaceAlpha', 0.20, 'EdgeColor', [0.8 0.6 0.2], ...
    'LineStyle', '--', 'LineWidth', 1.2);
h_wr.DisplayName = 'Working range (0.2 – 1.0 m)';


plot(so, d_near,         'b-',  'LineWidth', 2.0, 'DisplayName', 'd_{near}');
plot(so, min(d_far,3.0), 'r-',  'LineWidth', 2.0, 'DisplayName', 'd_{far}');
plot(so, so,             'k--', 'LineWidth', 1.2, 'DisplayName', 'Focus distance s_o');

xline(H, 'Color', [0.1 0.6 0.1], 'LineStyle', ':', 'LineWidth', 2.0, 'DisplayName', sprintf('Hyperfocal H = %.3f m', H));

d_far_02  = H*0.2 / (H - 0.2);
d_near_02 = H*0.2 / (H + 0.2);
plot(0.2, d_far_02, 'kv', 'MarkerSize', 8, 'MarkerFaceColor', 'k', 'HandleVisibility', 'off');
text(0.22, d_far_02 + 0.05, ...
    sprintf('DoF = %.1f cm at 0.2 m', (d_far_02-d_near_02)*100), 'FontSize', 9, 'Color', 'k');

xlabel('Focus distance  s_o  (m)', 'FontSize', 12);
ylabel('Distance (m)',             'FontSize', 12);
title({'Depth of Field  --  D435i RGB Lens', sprintf('f = 1.88 mm,  f/# = %.1f,  c = 2.09 um  (H = %.3f m)', N, H)}, 'FontSize', 11, 'Interpreter', 'none');

legend('Location', 'northwest', 'FontSize', 9);
grid on;
ylim([0 3]);
xlim([0.05 1.25]);
set(gca, 'FontSize', 10, 'LineWidth', 1.0);
box on;
hold off;


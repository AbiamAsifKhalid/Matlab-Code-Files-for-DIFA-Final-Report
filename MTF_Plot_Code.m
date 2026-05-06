%% MTF Figure 
clear; clc;

lambda  = 550e-9;       
f_num   = 2.0;         
p       = 1.4e-6;      
D_T     = 0.07;         
d_o     = 0.5;          
f       = 1.88e-3;      
NEM     = 0.10;        

xi_c   = 1 / (lambda * f_num);
xi_nyq = 1 / (2 * p);

h_i    = abs(-f/d_o) * D_T;          
xi_tom = 1 / (h_i * 1e3);             

xi  = linspace(0, xi_c, 100000);
u   = xi / xi_c;

MTF_opt = (2/pi) * (acos(u) - u .* sqrt(1 - u.^2));
MTF_opt(u >= 1) = 0;

xi_mm     = xi     * 1e-3;
xi_c_mm   = xi_c   * 1e-3;
xi_nyq_mm = xi_nyq * 1e-3;

u_nyq      = xi_nyq / xi_c;
mtf_at_nyq = (2/pi) * (acos(u_nyq) - u_nyq * sqrt(1 - u_nyq^2));

idx_nem = find(MTF_opt <= NEM, 1, 'first');
xi_nem  = xi_mm(idx_nem);

u_tom      = (xi_tom * 1e3) / xi_c;
mtf_at_tom = (2/pi) * (acos(u_tom) - u_tom * sqrt(1 - u_tom^2));

figure(3);
set(gcf, 'Units', 'inches', 'Position', [1 1 9 5.5]);
set(gcf, 'Color', 'w');

plot(xi_mm, MTF_opt, 'b-', 'LineWidth', 2.5);
hold on;

idx_tom  = find(xi_mm >= xi_tom, 1, 'first');
xi_fill  = [xi_mm(idx_tom:idx_nem), fliplr(xi_mm(idx_tom:idx_nem))];
mtf_fill = [MTF_opt(idx_tom:idx_nem), NEM*ones(1, idx_nem-idx_tom+1)];
fill(xi_fill, mtf_fill, [0.4 0.6 1.0], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
text((xi_tom + xi_nem)/2, NEM + 0.12, 'MTFA', 'FontSize', 10, 'FontWeight', 'bold', 'Color', [0.2 0.3 0.8], 'HorizontalAlignment', 'center');

patch([xi_nyq_mm xi_c_mm xi_c_mm xi_nyq_mm], [0 0 1.05 1.05], [0.82 0.82 0.82], 'FaceAlpha', 0.30, 'EdgeColor', 'none');
text(xi_nyq_mm + 15, 0.72, {'Optically present,', 'sensor unresolvable'}, 'FontSize', 8, 'Color', [0.35 0.35 0.35], 'HorizontalAlignment', 'left');

yline(NEM, 'r--', 'LineWidth', 1.8);
text(15, NEM + 0.03, 'NEM = 10%', 'FontSize', 9, 'Color', 'r', 'FontWeight', 'bold');

xline(xi_tom, 'k--', 'LineWidth', 1.5);
text(xi_tom + 2, 0.55, {sprintf('\\xi_{tomato} = %.1f cy/mm', xi_tom), sprintf('MTF \\approx %.2f', mtf_at_tom)}, 'FontSize', 8, 'Color', 'k', 'HorizontalAlignment', 'left');
plot(xi_tom, mtf_at_tom, 'k^', 'MarkerSize', 8, 'MarkerFaceColor', 'k');

xline(xi_nyq_mm, 'Color', [0.0 0.55 0.0], 'LineStyle', ':', 'LineWidth', 2.0);
text(xi_nyq_mm + 4, 0.88, sprintf('\\xi_{Nyq} = %d cy/mm', round(xi_nyq_mm)), 'FontSize', 9, 'Color', [0.0 0.55 0.0], 'FontWeight', 'bold');
plot(xi_nyq_mm, mtf_at_nyq, 'o', 'MarkerSize', 8, 'MarkerFaceColor', [0.0 0.55 0.0], 'MarkerEdgeColor', [0.0 0.55 0.0]);
text(xi_nyq_mm + 4, mtf_at_nyq - 0.06, sprintf('MTF = %.3f', mtf_at_nyq), 'FontSize', 8, 'Color', [0.0 0.55 0.0]);

xline(xi_c_mm, 'm:', 'LineWidth', 2.0);
text(xi_c_mm - 10, 0.88, sprintf('\\xi_c = %d cy/mm', round(xi_c_mm)), 'FontSize', 9, 'Color', 'm', 'FontWeight', 'bold', 'HorizontalAlignment', 'right');

plot(xi_nem, NEM, 'rs', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
text(xi_nem + 4, NEM + 0.05, sprintf('Detectability limit\n\\xi = %.0f cy/mm', xi_nem), 'FontSize', 8, 'Color', 'r');

xlabel('Spatial Frequency  \xi  (cy/mm)', 'FontSize', 12);
ylabel('MTF', 'FontSize', 12);
title({'Diffraction-Limited MTF  --  D435i RGB Lens', 'Circular aperture,  lambda = 550 nm,  f/# = 2.0,  p = 1.4 um'},'FontSize', 11, 'Interpreter', 'none');
grid on;
grid minor;
ylim([0 1.05]);
xlim([0 xi_c_mm * 1.05]);
set(gca, 'FontSize', 10, 'LineWidth', 1.0, 'Color', 'w');
box on;
hold off;


%% Spatial Separation Figure
clear; clc;

lambda = 550e-9;        
D      = 0.940e-3;     
f      = 1.88e-3;      

do_vec = linspace(0.05, 1.2, 1000);

Delta_R = 1.22 * lambda * do_vec / D * 1e3;   
Delta_A =  1.0 * lambda * do_vec / D * 1e3;  
Delta_S = 0.94 * lambda * do_vec / D * 1e3;  

figure(5);
set(gcf, 'Units', 'inches', 'Position', [1 1 8 5]);
set(gcf, 'Color', 'w');

h_wr = patch([0.2 1.0 1.0 0.2], [0 0 1.5 1.5], [1.0 0.9 0.7], 'FaceAlpha', 0.25, 'EdgeColor', [0.8 0.6 0.2], 'LineStyle', '--', 'LineWidth', 1.2);
h_wr.DisplayName = 'Working range (0.2 – 1.0 m)';
hold on;

plot(do_vec, Delta_R, 'b-',  'LineWidth', 2.5, 'DisplayName', '\Delta_R  (Rayleigh,  k = 1.22)');
plot(do_vec, Delta_A, 'r--', 'LineWidth', 2.0, 'DisplayName', '\Delta_A  (Abbe,  k = 1.00)');
plot(do_vec, Delta_S, 'k:',  'LineWidth', 2.0, 'DisplayName', '\Delta_S  (Sparrow,  k = 0.94)');

yline(30, 'm:', 'LineWidth', 1.5, ...
    'DisplayName', 'Typical tomato gap (~30 mm)');

r_at1 = 1.22 * lambda * 1.0 / D * 1e3;
a_at1 =  1.0 * lambda * 1.0 / D * 1e3;
s_at1 = 0.94 * lambda * 1.0 / D * 1e3;

plot(1.0, r_at1, 'bo', 'MarkerSize', 7, 'MarkerFaceColor', 'b', 'HandleVisibility', 'off');
plot(1.0, a_at1, 'ro', 'MarkerSize', 7, 'MarkerFaceColor', 'r', 'HandleVisibility', 'off');
plot(1.0, s_at1, 'ko', 'MarkerSize', 7, 'MarkerFaceColor', 'k', 'HandleVisibility', 'off');

text(1.02, r_at1 + 0.01, sprintf('%.3f mm', r_at1), 'FontSize', 8, 'Color', 'b');
text(1.02, a_at1 + 0.01, sprintf('%.3f mm', a_at1), 'FontSize', 8, 'Color', 'r');
text(1.02, s_at1 - 0.03, sprintf('%.3f mm', s_at1), 'FontSize', 8, 'Color', 'k');

xlabel('Working distance  d_o  (m)', 'FontSize', 12);
ylabel('Minimum resolvable separation (mm)', 'FontSize', 12);
title({'Minimum Resolvable Separation  --  D435i RGB Lens', 'lambda = 550 nm,  D = 0.940 mm,  f = 1.88 mm'}, 'FontSize', 11, 'Interpreter', 'none');
legend('Location', 'northwest', 'FontSize', 9);
grid on;
ylim([0 1.5]);
xlim([0.05 1.25]);
set(gca, 'FontSize', 10, 'LineWidth', 1.0);
box on;
hold off;


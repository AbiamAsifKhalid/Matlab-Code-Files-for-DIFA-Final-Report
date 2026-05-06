%% Figure 1 - PSF 3D Surface Plot (Airy Pattern)
clear; clc;

lambda = 550e-9;       
f = 1.88e-3;           
D = 0.940e-3;        
si = f;                 
p = 1.4e-6;            

x = linspace(-4e-6, 4e-6, 500);
y = linspace(-4e-6, 4e-6, 500);
[X, Y] = meshgrid(x, y);
r = sqrt(X.^2 + Y.^2);

r(r == 0) = eps;

arg = pi * D * r / (lambda * si);
I = (2 * besselj(1, arg) ./ arg).^2;
I(isnan(I)) = 1;

r_dark = 1.2197 * lambda * si / D;

figure(1);
surf(x*1e6, y*1e6, I, 'EdgeColor', 'none');
colormap(jet);
shading interp;
hold on;

theta = linspace(0, 2*pi, 500);
plot3(r_dark*1e6*cos(theta), r_dark*1e6*sin(theta),zeros(1,500), 'w--', 'LineWidth', 1.5);

px = p/2 * 1e6;
plot3([-px  px  px -px -px], [-px -px  px  px -px], zeros(1,5), 'w-', 'LineWidth', 1.5);

xlabel('x (\mum)', 'FontSize', 12);
ylabel('y (\mum)', 'FontSize', 12);
zlabel('PSF', 'FontSize', 12);
title({'PSF — D435i RGB Lens (Airy Pattern)', sprintf('lambda = %d nm,  f/# = %.1f,  D = %.3f mm', lambda*1e9, f/D, D*1e3)}, 'FontSize', 12);

view(-37.5, 30);
axis tight;
grid on;
zlim([0 1.05]);

c = colorbar;
c.Label.String = 'Normalized Intensity';
c.Label.FontSize = 10;
hold off;

%% Figure 2 - PSF 1D Cross Section Profile
r_1d = linspace(-4e-6, 4e-6, 10000);
r_1d_abs = abs(r_1d);
r_1d_abs(r_1d_abs == 0) = eps;
arg_1d = pi * D * r_1d_abs / (lambda * si);
I_1d = (2 * besselj(1, arg_1d) ./ arg_1d).^2;
figure(2);
plot(r_1d*1e6, I_1d, 'k-', 'LineWidth', 2);
hold on;

xline(r_dark*1e6,  'b--', 'LineWidth', 1.5,'DisplayName', sprintf('First dark ring (r = %.3f \\mum)', r_dark*1e6));
xline(-r_dark*1e6, 'b--', 'LineWidth', 1.5, 'HandleVisibility', 'off');

xline(p/2*1e6,  'r:', 'LineWidth', 1.5, 'DisplayName', sprintf('Pixel boundary (\\pm%.1f \\mum)', p/2*1e6));
xline(-p/2*1e6, 'r:', 'LineWidth', 1.5, 'HandleVisibility', 'off');

patch([-p/2*1e6, p/2*1e6, p/2*1e6, -p/2*1e6], [0, 0, 1.05, 1.05], 'r', 'FaceAlpha', 0.08, 'EdgeColor', 'none', 'DisplayName', 'Single pixel width');

yline(0, 'k-', 'LineWidth', 0.5);
text(r_dark*1e6 + 0.1, 0.05, sprintf('r_{dark} = %.3f \\mum', r_dark*1e6), 'FontSize', 9, 'Color', 'b');
text(p/2*1e6 + 0.1, 0.5, sprintf('p/2 = %.1f \\mum', p/2*1e6), 'FontSize', 9, 'Color', 'r');

xlabel('Radial distance r (\mum)', 'FontSize', 12);
ylabel('Normalized Intensity I(r) / I_0', 'FontSize', 12);
title({'PSF Cross-Section — D435i RGB Lens', sprintf('lambda = %d nm, f/# = %.1f, D = %.3f mm', lambda*1e9, f/D, D*1e3)}, 'FontSize', 12);

legend('PSF profile', 'First dark ring', 'Pixel boundary', 'Single pixel width','Location', 'northeast', 'FontSize', 9);

grid on;
ylim([-0.05 1.1]);
xlim([-4 4]);
hold off;

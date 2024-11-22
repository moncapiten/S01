clear all;

% data import and creation of the uncertainty vectors
rawData = readmatrix("./Data/data001.txt");

tt = rawData(:, 1);
vi = rawData(:, 2);
s_vi = repelem(0.0013, length(vi));
vo = rawData(:, 3);
s_vo = repelem(0.0013, length(vi));




% fit preparation, functions and p0 vectors
function y = fitfunc(params, x)

    y = params(1) * sin(2 * pi * params(2) .* x + params(3)) + params(4) ;

end

p0i = [ 0.5*(max(vi) - min(vi)), 1000, 0, mean(vi) ];
p0o = [ 0.5*(max(vo) - min(vo)), 1000, 0, mean(vo) ];


% fit execution and k^2 calculation
[betai, Ri, ~, covbetai] = nlinfit(tt, vi, @fitfunc, p0i);
[betao, Ro, ~, covbetao] = nlinfit(tt, vo, @fitfunc, p0o);


ki = 0;
for i = 1:length(Ri)
    %ki = ki + (vi(i) - fitfunc(betai, tt(i)))^2/s_vi(i)^2;
    ki = ki + Ri(i)^2/s_vi(i)^2;
end
ki/8188

ko = 0;
for i = 1:length(Ro)
    %ko = ko + (vo(i) - fitfunc(betao, tt(i)))^2/s_vo(i)^2;
    ko = ko + Ro(i)^2/s_vo(i)^2;
end
ko/8188




% plot setting and execution

t = tiledlayout(2, 2);

% plot of the data, prefit and fit
ax1 = nexttile([1 2]);

errorbar(tt, vi, s_vi, 'o', Color= '#0072BD');
hold on
plot(tt, fitfunc(p0i, tt), '--', Color= 'black');
plot(tt, fitfunc(betai, tt), '-', Color= 'red');
errorbar(tt, vo, s_vo, 'v', Color= '#7E2F8E');
plot(tt, fitfunc(p0o, tt), '--', Color= 'black');
plot(tt, fitfunc(betao, tt), '-', Color= 'yellow');
hold off
grid on
grid minor


% residual plots for both fits
ax2 = nexttile;
plot(tt, repelem(0, 8192), '--', Color= 'black');
hold on
errorbar(tt, Ri, s_vi, Color= '#0072BD');
hold off
grid on
grid minor

ax3 = nexttile;
plot(tt, repelem(0, 8192), '--', Color= 'black');
hold on
errorbar(tt, Ro, s_vo, Color= '#7E2F8E');
hold off
grid on
grid minor

% plot settings
title(t, 'Fit and residuals of Vi and Vo - Narrow range');
t.TileSpacing = "tight";
linkaxes([ax2, ax3], 'y');


xlabel(ax1, 'time [ms]')
ylabel(ax1, 'Voltage [V]')
legend(ax1, 'Vi', '', 'Vi (model)', 'Vo', '', 'Vo (model)', Location= 'ne')


xlabel(ax2, 'time[ms]');
ylabel(ax2, 'Vi - Residuals [V]');

xlabel(ax3, 'time[ms]');
ylabel(ax3, 'Vo - Residuals [V]')


fig = gcf;
orient(fig, 'landscape')
print(fig,'./Media/fitPlot.pdf','-dpdf')
saveas(fig, './Media/fitPlot', 'svg');

betai(1)
sqrt(covbetai(1))
betao(1)
sqrt(covbetao(1))

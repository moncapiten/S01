% data import and organization
rawData1 = readmatrix('./Data/data006.txt');
rawData2 = readmatrix('./Data/data007.txt');

tt1  = rawData1( :, 1);
vva1 = rawData1( :, 2);
vvb1 = rawData1( :, 3);

tt2  = rawData2( :, 1);
vva2 = rawData2( :, 2);
vvb2 = rawData2( :, 3);


% fit of the first data series and plot preparation
pda(1) = fitdist(vva1, 'Normal');
pda(2) = fitdist(vva2, 'Normal');

ha1 = histfit(vva1, 20);
hold on
ha2 = histfit(vva2, 20);
ha1(1).FaceColor = 'cyan';
ha1(2).Color = 'magenta';
ha2(1).FaceColor = '#D95319';
ha2(2).Color = 'blue';
legend('narrow range', 'narrow range gaussian' ,'wide range', 'wide range gaussian', Location= 'northwest');
xlabel('Voltage [V]');
ylabel('Counts ( 20 bins)')
title('Distribution of input voltage at different ranges');
hold off

plota = gcf;
orient(plota,'landscape')
print(plota,'Media/vvaDistPlot.pdf','-dpdf')
saveas(plota, 'Media/vvaDistPlot.png')

% fit of the second data series and plot preparation
pdb(1) = fitdist(vvb1, 'Normal');
pdb(2) = fitdist(vvb2, 'Normal');

hb1 = histfit(vvb1, 20);
hold on
hb2 = histfit(vvb2, 20);
hb1(1).FaceColor = 'cyan';
hb1(2).Color = 'magenta';
hb2(1).FaceColor = '#D95319';
hb2(2).Color = 'blue';
legend('narrow range', 'narrow range gaussian' ,'wide range', 'wide range gaussian', Location= 'northwest');
xlabel('Voltage [V]');
ylabel('Counts ( 20 bins)')
title('Distribution of output voltage at different ranges');
hold off

plotb = gcf;
orient(plotb, 'landscape')
print(plotb,'Media/vvbDistPlot.pdf','-dpdf')
saveas(plotb, 'Media/vvbDistPlot.png')

% saving the fit parameters

save('Data/vvaDistFit.mat', 'pda');
save('Data/vvbDistFit.mat', 'pdb');

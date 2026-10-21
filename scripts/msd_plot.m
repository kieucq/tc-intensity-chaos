clear;
data1 = load('msd_r0p00.txt');
data2 = load('msd_r0p01.txt');
data3 = load('msd_r0p05.txt');
data4 = load('msd_r0p10.txt');
data5 = load('msd_r0p20.txt');
data6 = load('msd_r0p30.txt');
data7 = load('msd_r0p40.txt');
data8 = load('msd_r0p50.txt');
hr   = data1(:,1);  % time
u1   = data1(:,2);  % U-wind
b1   = data1(:,4);  % warm core
v1   = data1(:,3);  % V-wind
v2   = data2(:,3);  % V-wind
v3   = data3(:,3);  % V-wind
v4   = data4(:,3);  % V-wind
v5   = data5(:,3);  % V-wind
v6   = data6(:,3);  % V-wind
v7   = data7(:,3);  % V-wind
v8   = data8(:,3);  % V-wind
figure('Position',[0 0 900 650])
plot(hr,v1);
hold on
plot(hr,v2);
hold on
plot(hr,v3);
hold on
plot(hr,v4);
hold on
plot(hr,v5);
hold on
plot(hr,v6);
hold on
plot(hr,v7);
hold on
plot(hr,v8);
hold on
xlabel('Time (nondimensional unit)') 
ylabel('Nondimensional VMAX')
title('Dependence of VMAX on radiative forcing parameter (r)')
xlim([0 10])
ylim([0 1])
set(gca,'YTick',[0:0.1:1]) % axis limits
set(gca,'XTick',[0:1:10],'LineWidth',2.75)
set(gca,'FontSize',18)

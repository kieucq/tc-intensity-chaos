%
% [NOTE]: This program solves for the expanded MSD system in (Kieu and Wang
% 2017)
%
% [AUTHOR]: Chanh Kieu, Indiana University
%
% [HIST]: - August 26, 2016: created from Zach Moon's rk4 function
%
%==========================================================================
close all; clear
%
% Initialize parameters
%
p1 = 200;
p2 = 201;
p3 = 1.0; 
%p1 = 200;   % [\alpha^3 /(\gamma(\alpha^2+beta^2))]p -- standard p
%p2 = 100;   % [\alpha^2 / (\alpha^2+\gamma^2)] (p+1) -- standard p+1
%p3 = 0.5;   % \alpha^2/(\alpha^2 + \gamma^2)         -- standard 1
r = 0.2;    % radiative forcing per day
s = 0.2;
f2 = 0.1;
f1 = p1*f2;
n = 1000000;  %number of integrations
dt = 0.001; %time step
%
% Set HSD initial conditions by creating 4 different initial points in the
% phase space of (u,v,b)
% 
u_0s = [-0.001, -1.0, -1.0, -0.1];
v_0s = [0.001,  1.0,  1.4, -0.2];
b_0s = [0.001,   0.5,  1.0,  0.1];
%
% integrate the HSD system in time for the first initial condition, 
% using RK4 order and plot right away
%
fig1 = figure('Position',[0 0 900 650]);
[t1,u1,v1,b1] = msd_rk4(u_0s(1), v_0s(1), b_0s(1), p1, p2, p3, r, s, f1, f2, dt, n);
plot3(u1,v1,b1, 'color', 'red', 'LineWidth', 3)
hold on
plot3(u1(1),v1(1),b1(1), '+', 'Color','red',  'MarkerSize', 25)
hold on
%
% integrate the second initial condition (u_0s(2), v_0s(2), b_0s(2))
%
[t2,u2,v2,b2] = msd_rk4(u_0s(2), v_0s(2), b_0s(2), p1, p2, p3, r, s, f1, f2, dt, n);
plot3(u2,v2,b2, 'Color', 'cyan', 'LineWidth', 3)
plot3(u2(1),v2(1),b2(1), '+', 'Color','cyan',  'MarkerSize', 25)
hold on
%
% integrate the third initial condition (u_0s(3), v_0s(3), b_0s(3))
%
[t3,u3,v3,b3] = msd_rk4(u_0s(3), v_0s(3), b_0s(3), p1, p2, p3, r, s, f1, f2, dt, n);
plot3(u3,v3,b3, 'Color', 'green', 'LineWidth', 3)
plot3(u3(1),v3(1),b3(1), '+', 'Color','green',  'MarkerSize', 25)
hold on
%
% integrate the fourth initial condition (u_0s(4), v_0s(4), b_0s(4))
%
[t4,u4,v4,b4] = msd_rk4(u_0s(4), v_0s(4), b_0s(4), p1, p2, p3, r, s, f1, f2, dt, n);
plot3(u4,v4,b4, 'Color', 'blue', 'LineWidth', 3)
plot3(u4(1),v4(1),b4(1), '+', 'Color','blue',  'MarkerSize', 25)
%
% labels and axis settings of the 3D plots
%
xlabel('normalized tangential wind u'); 
ylabel('normalized vertical wind v'); 
zlabel('normalized temperature anomaly b')
grid on
view(58,9)
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',14,'LineWidth',2.75)
print('figure1e', '-dpng', '-r450');
%
% plot time series of vmax now
%
figure('Position',[0 0 900 650]);
plot(t1(1:30000),v1(1:30000),'color', 'red', 'LineWidth', 1.8)
hold on
plot(t1(1:30000),v2(1:30000),'color', 'cyan', 'LineWidth', 1.8)
hold on
plot(t1(1:30000),v3(1:30000),'color', 'green', 'LineWidth', 1.8)
hold on
plot(t1(1:30000),v4(1:30000),'color', 'blue', 'LineWidth', 1.8)
set(gca,'FontSize',18,'LineWidth',2.75)
xlabel('Nondimentional time'); 
ylabel('Nondimentional maximum tangential wind v');
print('figure1f', '-dpng', '-r450');
%
% plot time series of umax now
%
figure('Position',[0 0 900 650]);
plot(t1(1:30000),u2(1:30000),'color', 'cyan', 'LineWidth', 1.8)
hold on
plot(t1(1:30000),u3(1:30000),'color', 'green', 'LineWidth', 1.8)
hold on
plot(t1(1:30000),u4(1:30000),'color', 'blue', 'LineWidth', 1.8)
hold on
plot(t1(1:30000),u1(1:30000),'color', 'red', 'LineWidth', 1.8)
set(gca,'FontSize',18,'LineWidth',2.75)
xlabel('Time'); 
ylabel('Normalized maximum radial wind U');
print('figure1g', '-dpng', '-r450');
%
% plot time series of bmax now
%
figure('Position',[0 0 900 650]);
plot(t1(1:30000),b1(1:30000),'color', 'red', 'LineWidth', 1.8)
hold on
plot(t1(1:30000),b2(1:30000),'color', 'cyan', 'LineWidth', 1.8)
hold on
plot(t1(1:30000),b3(1:30000),'color', 'green', 'LineWidth', 1.8)
hold on
plot(t1(1:30000),b4(1:30000),'color', 'blue', 'LineWidth', 1.8)
set(gca,'FontSize',18,'LineWidth',2.75)
xlabel('Time'); 
ylabel('Normalized maximum bouyancy B');
print('figure1h', '-dpng', '-r450');
%
% print out data file
%
%fileID = fopen('msd_s1p00.txt','w');
fileID = fopen('MSD_all_vars.txt','w');
for i=1:n
    %fprintf(fileID,'%7.2f %7.2f %7.2f %7.2f\r\n',t1(i),u1(i),v1(i),b1(i));
    fprintf(fileID,'%7.2f %7.2f %7.2f\r\n',u1(i),v1(i),b1(i));
end    
fclose(fileID);


close all

out = ans;
clear ans

%%
switch simulationType
    case 1
        folder = '/Regulation/';
    case 2
        folder = '/RegulationMultiple/';
    case 3
        folder = '/Tracking/';
end

switch Adaptive_OFF
    case 1
        filename_3D_Traj = strcat('./images',folder,'/Adaptive_OFF/UAV_Trajectory_Plot_3D_Adaptive_OFF','.pdf');
        filename_2D_Traj = strcat('./images',folder,'/Adaptive_OFF/UAV_Trajectory_Plot_2D_Adaptive_OFF','.pdf');
        filenamePosition = strcat('./images',folder,'/Adaptive_OFF/UAV_Position_Adaptive_OFF','.pdf');
        filenameOrientation = strcat('./images',folder,'/Adaptive_OFF/UAV_Orientation_Adaptive_OFF','.pdf');
        filenameInputBaseline = strcat('./images',folder,'/Adaptive_OFF/UAV_Input_Baseline_Adaptive_OFF','.pdf');
        filenameInputAdaptive = strcat('./images',folder,'/Adaptive_OFF/UAV_Input_Adaptive_Adaptive_OFF','.pdf');
    case 0
        filename_3D_Traj = strcat('./images',folder,'/Adaptive_ON/UAV_Trajectory_Plot_3D_Adaptive_ON_Gamma_',num2str(gamma),'.pdf');
        filename_2D_Traj = strcat('./images',folder,'/Adaptive_ON/UAV_Trajectory_Plot_2D_Adaptive_ON_Gamma_',num2str(gamma),'.pdf');
        filenamePosition = strcat('./images',folder,'/Adaptive_ON/UAV_Position_Adaptive_ON_Gamma_',num2str(gamma),'.pdf');
        filenameOrientation = strcat('./images',folder,'/Adaptive_ON/UAV_Orientation_Adaptive_ON_Gamma_', num2str(gamma),'.pdf');
        filenameInputBaseline = strcat('./images',folder,'/Adaptive_ON/UAV_Input_Baseline_Adaptive_ON_Gamma_',num2str(gamma),'.pdf');
        filenameInputAdaptive = strcat('./images',folder,'/Adaptive_ON/UAV_Input_Adaptive_Adaptive_ON_Gamma_',num2str(gamma),'.pdf');
end

% Recupera il vettore del tempo e i dati dal timeseries
t = out.tout;     % Tempo

% Output
yout = out.logsout.get('y').Values.Data;     % Dati del segnale
x = squeeze(yout(1, :, :)); 
y = squeeze(yout(2, :, :)); 
z = squeeze(yout(3, :, :));
yaw = squeeze(yout(4, :, :));

% Reference
r_all = out.logsout.get('r').Values.Data;     % Dati del segnale
r_x = r_all(:,1); 
r_y = r_all(:,2); 
r_z = r_all(:,3);
r_psi = r_all(:,4);

% Baseline Input
ubl_all = out.logsout.get('ubl').Values.Data;     % Dati del segnale
ubl1 = squeeze(ubl_all(1, :, :)); 
ubl2 = squeeze(ubl_all(2, :, :)); 
ubl3 = squeeze(ubl_all(3, :, :));
ubl4 = squeeze(ubl_all(4, :, :));

% Adaptive Input
uad_all = out.logsout.get('uad').Values.Data;     % Dati del segnale
uad1 = squeeze(uad_all(1, :, :)); 
uad2 = squeeze(uad_all(2, :, :)); 
uad3 = squeeze(uad_all(3, :, :));
uad4 = squeeze(uad_all(4, :, :));

% States
X_all = out.logsout.get('X').Values.Data;     % Dati del segnale
roll = squeeze(X_all(4, :, :)); 
pitch = squeeze(X_all(5, :, :)); 

% Rad to deg for ploting
roll  = rad2deg(roll);
pitch  = rad2deg(pitch);
yaw  = rad2deg(yaw);


%% Plot settings
plotSettings.regulation.axis = [-1 9 -1 9 -1 6];
plotSettings.regulation.xlim = [0, 50];

plotSettings.regulationMultiple.axis = [-1 9 -1 9 -1 6];
plotSettings.regulationMultiple.xlim = [0, 200];

plotSettings.tracking.axis = [-2 2 -2 2 -1 6];
plotSettings.tracking.xlim = [0, 100];

switch simulationType
    case 1
        settings = plotSettings.regulation;
    case 2
        settings = plotSettings.regulationMultiple;
    case 3
        settings = plotSettings.tracking;
end

%% Plot 3D      
figure; 
plot3(r_x(1),r_y(1),r_z(1),'.','MarkerSize',15,'Color',[0.4660 0.6740 0.1880])
hold all
plot3(r_x(end),r_y(end),r_z(end),'r*','LineWidth',1)
if simulationType == 3
    plot3(r_x,r_y,r_z,'LineWidth',1,'Color',[0.8500 0.3250 0.0980])
end
plot3(x,y,z,'LineWidth',1,'Color',[0 0.4470 0.7410])
grid on;
xlabel('$x$ [m]','Interpreter','latex');
ylabel('$y$ [m]','Interpreter','latex');
zlabel('$z$ [m]','Interpreter','latex');    
legend('Starting','Goal','Interpreter','Latex','Location','northeast')
axis(settings.axis)
set(gca,'TickLabelInterpreter','latex')
if Adaptive_OFF
    title('Adaptive\_OFF','Interpreter','latex','FontSize',12);
else
    title(['Adaptive\_ON: $\gamma = ' num2str(gamma) '$'],'Interpreter','latex','FontSize',12);
end

picturewidth = 25; % set this parameter and keep it forever
hw_ratio = 0.45; % feel free to play with this ratio (1 is a square)
set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size
pause(0.5);
exportgraphics(gcf,filename_3D_Traj,'ContentType','vector')


%% Plot 2D
figure; 
plot3(r_x(1),r_y(1),r_z(1),'.','MarkerSize',15,'Color',[0.4660 0.6740 0.1880])
hold all
plot3(r_x(end),r_y(end),r_z(end),'r*','LineWidth',1)
if simulationType == 3
    plot3(r_x,r_y,r_z,'-.','LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
end
plot3(x,y,z,'LineWidth',1,'Color',[0 0.4470 0.7410])
grid on;
xlabel('$x$ [m]','Interpreter','latex');
ylabel('$y$ [m]','Interpreter','latex');
zlabel('$z$ [m]','Interpreter','latex');    
legend('Starting','Goal','Interpreter','Latex','Location','northeast')
axis(settings.axis)
set(gca,'TickLabelInterpreter','latex')
if Adaptive_OFF
    title('Adaptive\_OFF','Interpreter','latex','FontSize',12);
else
    title(['Adaptive\_ON: $\gamma = ' num2str(gamma) '$'],'Interpreter','latex','FontSize',12);
end
view(2)
axis equal

pause(0.5);
exportgraphics(gcf,filename_2D_Traj,'ContentType','vector')


%% Position
figure
hold all
plot(t, x, 'LineWidth', 1.5)
plot(t, y, 'LineWidth', 1.5)
plot(t, z, 'LineWidth', 1.5)
plot(t, r_x ,'-.', 'Color', [0, 0.4470, 0.7410], 'LineWidth', 1)
plot(t, r_y ,'-.', 'Color', [0.8500, 0.3250, 0.0980], 'LineWidth', 1)
plot(t, r_z ,'-.', 'Color', [0.9290, 0.6940, 0.125], 'LineWidth', 1)
xline(t_failure, '--')
hold off
grid on
xlabel({'$t$ [s]'},'Interpreter','latex');
ylabel('Position [m]','Interpreter','latex');
legend('$x$','$y$','$z$','Location','northwest','Interpreter','latex')
xlim([0, t(end)])
ylim([-1, 7])
set(gca,'TickLabelInterpreter','latex')
if Adaptive_OFF
    title('Adaptive\_OFF','Interpreter','latex','FontSize',12);
else
    title(['Adaptive\_ON: $\gamma = ' num2str(gamma) '$'],'Interpreter','latex','FontSize',12);
end

picturewidth = 25; % set this parameter and keep it forever
hw_ratio = 0.45; % feel free to play with this ratio (1 is a square)
set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size
pause(0.5);
exportgraphics(gcf,filenamePosition,'ContentType','vector')


%% Orientation
figure
hold all
plot(t, roll, 'LineWidth', 1.5)
plot(t, pitch, 'LineWidth', 1.5)
plot(t, yaw, 'LineWidth', 1.5)
plot(t, r_psi ,'-.', 'Color', [0.9290, 0.6940, 0.125], 'LineWidth', 1)
xline(t_failure, '--')
hold off
grid on
xlabel({'$t$ [s]'},'Interpreter','latex');
ylabel('Orientation [deg]','Interpreter','latex');
legend('$\phi$ (roll)','$\theta$ (pitch)','$\psi$ (yaw)','Location','north','Interpreter','latex')
xlim([0, t(end)])
ylim([-7, 7])
set(gca,'TickLabelInterpreter','latex')
if Adaptive_OFF
    title('Adaptive\_OFF','Interpreter','latex','FontSize',12);
else
    title(['Adaptive\_ON: $\gamma = ' num2str(gamma) '$'],'Interpreter','latex','FontSize',12);
end

picturewidth = 25; % set this parameter and keep it forever
hw_ratio = 0.45; % feel free to play with this ratio (1 is a square)
set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size
pause(0.5);
exportgraphics(gcf,filenameOrientation,'ContentType','vector')


%% Baseline Input
figure
hold all
plot(t, ubl1, 'LineWidth', 1.5)
plot(t, ubl2, 'LineWidth', 1.5)
plot(t, ubl3, 'LineWidth', 1.5)
plot(t, ubl4, 'LineWidth', 1.5)
xline(t_failure, '--')
hold off
grid on
xlabel({'$t$ [s]'},'Interpreter','latex');
ylabel('$U$ (N)','Interpreter','latex');
legend('$u_{bl_1}$','$u_{bl_2}$','$u_{bl_3}$','$u_{bl_4}$','Location','north','Interpreter','latex')
xlim([0, t(end)])
ylim([-8 8])
set(gca,'TickLabelInterpreter','latex')
if Adaptive_OFF
    title('Adaptive\_OFF','Interpreter','latex','FontSize',12);
else
    title(['Adaptive\_ON: $\gamma = ' num2str(gamma) '$'],'Interpreter','latex','FontSize',12);
end

picturewidth = 25; % set this parameter and keep it forever
hw_ratio = 0.45; % feel free to play with this ratio (1 is a square)
set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size
pause(0.5);
exportgraphics(gcf,filenameInputBaseline,'ContentType','vector')

%% Adaptive Input
if ~Adaptive_OFF
    figure
    hold all
    plot(t, uad1, 'LineWidth', 1.5)
    plot(t, uad2, 'LineWidth', 1.5)
    plot(t, uad3, 'LineWidth', 1.5)
    plot(t, uad4, 'LineWidth', 1.5)
    xline(t_failure, '--')
    hold off
    grid on
    xlabel({'$t$ [s]'},'Interpreter','latex');
    ylabel('$U$ (N)','Interpreter','latex');
    legend('$u_{ad_1}$','$u_{ad_2}$','$u_{ad_3}$','$u_{ad_4}$','Location','north','Interpreter','latex')
    xlim([0, t(end)])
    ylim([-35 35])
    set(gca,'TickLabelInterpreter','latex')
    title(['Adaptive\_ON: $\gamma = ' num2str(gamma) '$'],'Interpreter','latex','FontSize',12);

    picturewidth = 25; % set this parameter and keep it forever
    hw_ratio = 0.45; % feel free to play with this ratio (1 is a square)
    set(gcf,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth]) % for setting inMATLAB size
    pause(0.5);
    exportgraphics(gcf,filenameInputAdaptive,'ContentType','vector')
end


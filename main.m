
clear
close all
clc

simulationType = input(['Choose simulation type: \n' ...
    '1: Regulation \n' ...
    '2: RegulationMultiple \n' ...
    '3: Tracking \n' ...
    'Simulation Type: ']);


%% Adaptive Control
Adaptive_OFF = input(['\nChoose: \n' ...
    '0: Adaptive_ON \n' ...
    '1: Adaptive_OFF \n' ...
    'Adaptive Type: ']);

% Load drone parameters
quad = droneParams;
busInfo = Simulink.Bus.createObject(quad);

%% Matrix definitions
np = 3*4;
m = 4;
n = np + m;  % 16

Lambda = eye(m);  % unknown pos. def. matrix
Lambda(1,1) = 0.4;

run('./provaMatrici.m');
Ap = Ap_numeric;
Bp = Bp_numeric;
Cp = zeros(m, np);
Cp(1,1) = 1; 
Cp(2,2) = 1; 
Cp(3,3) = 1;
Cp(4,6) = 1;


%% MRAc
Abar = [Ap zeros(np,m); Cp zeros(m,m)];
B = [Bp; zeros(m,m)];
Bc = [zeros(np,m); -eye(m)];
C = [Cp zeros(m,m)];

%% Load LQR parameters. Bryson's rule:
rho = 100000; % modify this
max_pos = 100;
max_ang = 2*pi;
max_vel = 100;
max_rate = 4*pi;
max_eyI = 0.01;  % integral of tracking error
max_states = [
    max_pos; max_pos; max_pos;
    max_ang; max_ang; max_ang;
    max_vel; max_vel; max_vel;
    max_rate; max_rate; max_rate;
    max_eyI;max_eyI;max_eyI;max_eyI;
    ];
max_inputs = [quad.U1_max; quad.U2_max; quad.U3_max; quad.U4_max];

Q = diag(1./max_states.^2);
R = diag(1./max_inputs.^2);
R = R.*rho;

[K,~,~] = lqr(Abar, B, Q, R);
%K(abs(K)<1e-8) = 0;
% Slow states modification
%K(:,1) = 0;  % x terms
%K(:,2) = 0;  % y terms
Kbl = -K;

%% Adaptive controller
p = m+n+1;
gamma = 1000; % modify this
Gamma = eye(p)*gamma; 

Kx = -lqr(Abar, B, eye(n), eye(m));
Am = Abar - B*K;
%eigs(Am)  % has to be Hurwitz (stable)
P = lyap(Am.',eye(n));
check_minusI = Am.'*P + P*Am;  % check that this is -I
check_minusI(abs(check_minusI) < 1e-8) = 0;

%% Setting Simulation
switch simulationType
    case 1
        t_failure = 12;
        StopTime = 18;
    case 2
        t_failure = 55;
        StopTime = 60;
    case 3
        t_failure = 60;
        StopTime = 50;
end

%% Start Simulation
sim("simulation.slx",'StopTime',num2str(StopTime));

%% Plotting 
run('plot_Final.m');

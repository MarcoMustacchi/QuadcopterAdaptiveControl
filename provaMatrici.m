
% Passo 1: Definisci le variabili simboliche
syms x y z phi theta psi dx dy dz dphi dtheta dpsi
syms U1 U2 U3 U4
syms Ix Iy Iz M g L % parametri del sistema

% Definisci il vettore di stato e il vettore di controllo
xp = [x; y; z; phi; theta; psi; dx; dy; dz; dphi; dtheta; dpsi]; % stato
u = [U1; U2; U3; U4]; % ingresso

% Passo 2: Definisci le equazioni differenziali
% Definizione delle equazioni in base all'immagine
ddx = g*theta;
ddy = -g*phi;
ddz = U1/M;
ddphi = L/Ix * U2;
ddtheta = L/Iy * U3;
ddpsi = 1/Iz * U4;

% Definisci il vettore delle derivate del vettore di stato (xp_dot) nel
% medesimo ordine del vettore di stato
xp_dot = [
    dx;          % dx/dt
    dy;          % dy/dt
    dz;          % dz/dt
    dphi;        % dφ/dt
    dtheta;      % dθ/dt
    dpsi;        % dψ/dt
    ddx;         % d²x/dt²
    ddy;         % d²y/dt²
    ddz;         % d²z/dt²
    ddphi;       % d²φ/dt²
    ddtheta;     % d²θ/dt²
    ddpsi        % d²ψ/dt²
];

% Passo 3: Calcola le matrici Ap e Bp usando le derivate parziali
Ap = jacobian(xp_dot, xp);  % Matrice Ap = ∂(xp_dot)/∂xp
Bp = jacobian(xp_dot, u);   % Matrice Bp = ∂(xp_dot)/∂u

% Passo 4: Visualizza le matrici Ap e Bp
disp('Matrice Ap:');
disp(Ap);

disp('Matrice Bp:');
disp(Bp);

% Passo 5: Definizione dei parametri del drone
quad = droneParams;

% Passo 6a: Esegui la sostituzione dei parametri nella matrice Ap
Ap_numeric = subs(Ap, ...
    g, ...  % Lista dei simboli
    quad.g ...  % Lista dei valori
);

% Passo 6b: Esegui la sostituzione dei parametri nella matrice Bp
Bp_numeric = subs(Bp, ...
    [Ix, Iy, Iz, M, L], ...
    [quad.Ix, quad.Iy, quad.Iz, quad.M, quad.d]);

% Passo 7a: Converti Ap_numeric in matrice numerica
Ap_numeric = double(Ap_numeric);  % Usa double per ottenere una matrice numerica

% Visualizza la matrice Ap con i valori numerici
disp('Matrice Ap con i parametri numerici:');
disp(Ap_numeric);

% Passo 7b: Converti Bp_numeric in matrice numerica
Bp_numeric = double(Bp_numeric);  % Usa double per ottenere una matrice numerica

% Visualizza la matrice Ap con i valori numerici
disp('Matrice Bp con i parametri numerici:');
disp(Bp_numeric);



% Definizione delle variabili simboliche
syms phi theta psi phi_dot theta_dot psi_dot U1 U2 U3 U4 m g L Iy Iz Ix Jr omegar real

% Velocità derivata rispetto al tempo
vel_dot_x = U1 .* (sin(phi) .* sin(psi) + cos(phi) .* cos(psi) .* sin(theta)) ./ m;
vel_dot_y = U1 .* (cos(phi) .* sin(psi) .* sin(theta) - cos(psi) .* sin(phi)) ./ m;
vel_dot_z = U1 .* (cos(phi) .* cos(theta)) ./ m - g;

% Tassi di variazione angolari
rate_dot_x = ((Iy - Iz) .* psi_dot .* theta_dot - Jr .* theta_dot .* omegar + L .* U2) ./ Ix;
rate_dot_y = ((Iz - Ix) .* phi_dot .* psi_dot + Jr .* phi_dot .* omegar + L .* U3) ./ Iy;
rate_dot_z = ((Ix - Iy) .* phi_dot .* theta_dot + U4) ./ Iz;

% Small angle approximation
% sin(θ)≈θ,  cos(θ)≈1
% sin(𝜙)≈𝜙,  cos(𝜙)≈1
% sin(ϕ)≈ϕ,  cos(ϕ)≈1
% sin(𝜓)≈𝜓,  cos(𝜓)≈1
% sin(ψ)≈ψ,   cos(ψ)≈1
angle = [sin(phi), cos(phi), sin(theta), cos(theta), sin(psi), cos(psi)]; 
small_angle = [phi, 1, theta, 1, psi, 1];

% Sostituzione nelle espressioni delle velocità angolari
vel_dot_x_approx = subs(vel_dot_x, angle, small_angle)
vel_dot_y_approx = subs(vel_dot_y, angle, small_angle)
vel_dot_z_approx = subs(vel_dot_z, angle, small_angle)

% Sostituzione nelle espressioni dei tassi di variazione angolari
rate_dot_x_approx = subs(rate_dot_x, angle, small_angle)
rate_dot_y_approx = subs(rate_dot_y, angle, small_angle)
rate_dot_z_approx = subs(rate_dot_z, angle, small_angle)


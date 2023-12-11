% Paramètres mécaniques
masse_roue = 10; % (kg) Masse de la roue
masse_corps = 85; % (kg) Masse du corps humain
inertie_roue = 0.1; % (kg.m^2) Inertie de la roue
inertie_corps = 0.1; % (kg.m^2) Inertie du corps humain
longueur = 1; % (m) Longueur
rayon = 0.25; % (m) Rayon
vitesse = 5 * 1000/3600; % (m/s) La vitesse nominale est fixée à 10 (km/h).

% Conditions initiales
% couple=1;
position_x = 0;
angle_theta_20 = 5*3.14/180;
vitesse_0 = 1;
vitesse_angulaire_omega_20 = 0;

% Temps de simulation
Tf = 1;

% Simuler
simOut = sim('Modele_Segway_PT', 'SimulationMode', 'normal', 'StopTime', num2str(Tf));

% Extraire les données de simOut
temps = simOut.tout;
position_x = simOut.x;
angle_theta_2 = simOut.theta_2;
vitesse = simOut.v;
vitesse_angulaire_omega_2 = simOut.omega_2;
C = simOut.C;

angle_theta_2 = angle_theta_2 * 180 / 3.14;

% Définir les quantités
gravite = 9.81;
d_11 = (masse_roue + masse_corps) * rayon^2 + inertie_roue;
d_12 = masse_corps * rayon * longueur .* cos(angle_theta_2);
d_22 = masse_corps * longueur^2 + inertie_corps;
h_1 = -masse_corps * rayon * longueur .* sin(angle_theta_2) .* vitesse_angulaire_omega_2.^2;
h_2 = -masse_corps * gravite * longueur .* sin(angle_theta_2);
Delta = d_11 * d_22 - d_12.^2;

% Figures pour les positions angulaires
figure
title('Positions pour le système linéarisé')
subplot(211)
plot(temps, position_x, 'g', 'Linewidth', 2);
ylabel('Position (m)', 'Interpreter', 'Latex')
subplot(212)
plot(temps, angle_theta_2, 'g', 'Linewidth', 2);
ylabel('\theta_2 (degrés)', 'Interpreter', 'Latex')
xlabel('Temps (s)', 'Interpreter', 'Latex')

% Figures pour les vitesses angulaires
figure
title('Vitesses angulaires')
subplot(211)
plot(temps, vitesse, 'Linewidth', 2);
ylabel('v (m/s)', 'Interpreter', 'Latex')
subplot(212)
plot(temps, vitesse_angulaire_omega_2, 'Linewidth', 2);
ylabel('\omega_1 (rad/s)', 'Interpreter', 'Latex')
xlabel('Temps (s)', 'Interpreter', 'Latex')

function dx_sortie = dynamique_Segway_NonLineaire(vecteur_entree)
    % Extraire les entrées de vecteur_entree
    position_x = vecteur_entree(1); % Position
    angle_theta_2 = vecteur_entree(2); % Position
    vitesse_v = vecteur_entree(3); % Vitesse
    vitesse_angulaire_omega_2 = vecteur_entree(4); % Vitesse
    couple_tau = vecteur_entree(5); % Couple
    masse_m_1 = vecteur_entree(6); % Masse
    masse_m_2 = vecteur_entree(7); % Masse
    inertie_I_1 = vecteur_entree(8); % Inertie
    inertie_I_2 = vecteur_entree(9); % Inertie
    longueur_L = vecteur_entree(10); % Longueur
    rayon_r = vecteur_entree(11); % Rayon

    % Définir les quantités
    gravite_g = 9.81;
    d_11 = (masse_m_1 + masse_m_2) * rayon_r^2 + inertie_I_1;
    d_12 = masse_m_2 * rayon_r * longueur_L * cos(angle_theta_2);
    d_22 = masse_m_2 * longueur_L^2 + inertie_I_2;
    Delta = d_11 * d_22 - d_12^2;

    % Implémenter l'équation (15) avec l'approximation des petits angles
    dx_vitesse = vitesse_v;
    dtheta_2 = vitesse_angulaire_omega_2;

    % Utiliser l'approximation des petits angles pour les termes gravitationnels et centrifuges
    h_1 = -masse_m_2 * rayon_r * longueur_L * angle_theta_2 * vitesse_angulaire_omega_2^2;
    h_2 = -masse_m_2 * gravite_g * longueur_L * angle_theta_2;

    dvitesse_v = (d_22 * (couple_tau - h_1) + d_12 * (0 + h_2)) / rayon_r * Delta;
    dvitesse_angulaire_omega_2 = (-d_12 * (couple_tau - h_1) - d_11 * (0 + h_2)) / Delta;

    % Sortie dx_sortie
    dx_sortie = [dx_vitesse; dtheta_2; dvitesse_v; dvitesse_angulaire_omega_2];
end


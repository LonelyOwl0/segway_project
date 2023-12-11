function sortie_dynamique = dynamiqueSegway(parametresEntree)
    % Extraire les entrées de parametresEntree
    position = parametresEntree(1); % Position
    angle = parametresEntree(2); % Position
    vitesse_lineaire = parametresEntree(3); % Vitesse
    vitesse_angulaire = parametresEntree(4); % Vitesse
    couple = parametresEntree(5); % Couple
    masse_roue = parametresEntree(6); % Masse
    masse_corps = parametresEntree(7); % Masse
    inertie_roue = parametresEntree(8); % Inertie
    inertie_corps = parametresEntree(9); % Inertie
    longueur_corps = parametresEntree(10); % Longueur
    rayon_roue = parametresEntree(11); % Rayon

    % Définir les constantes
    gravite = 9.81;
    d_11 = (masse_roue + masse_corps) * rayon_roue^2 + inertie_roue;
    d_12 = masse_corps * rayon_roue * longueur_corps * cos(angle);
    d_22 = masse_corps * longueur_corps^2 + inertie_corps;
    determinant = d_11 * d_22 - d_12^2;

    % Implémenter Eq. (15) avec l'approximation des petits angles
    dposition = vitesse_lineaire;
    dangle = vitesse_angulaire;

    % Utiliser l'approximation des petits angles pour les termes gravitationnels et centrifuges
    h_1 = -masse_corps * rayon_roue * longueur_corps * sin(angle) * vitesse_angulaire^2;
    h_2 = -masse_corps * gravite * longueur_corps * sin(angle);

    dvitesse_lineaire = (d_22 * (couple - h_1) + d_12 * (0 + h_2)) / rayon_roue * determinant;
    dvitesse_angulaire = (-d_12 * (couple - h_1) - d_11 * (0 + h_2)) / determinant;

    % Sortie sortie_dynamique
    sortie_dynamique = [dposition; dangle; dvitesse_lineaire; dvitesse_angulaire];
end

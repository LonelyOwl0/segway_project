function dx = nonlinear_Segway_PT(input_vector)
    % Extract inputs from input_vector
    x = input_vector(1); % Position
    theta_2 = input_vector(2); % Position
    v = input_vector(3); % Velocity
    omega_2 = input_vector(4); % Velocity
    tau = input_vector(5); % Torque
    m_1 = input_vector(6); % Mass
    m_2 = input_vector(7); % Mass
    I_1 = input_vector(8); % Inertia
    I_2 = input_vector(9); % Inertia
    L = input_vector(10); % Length
    r = input_vector(11); % Radius

    % Define quantities
    g = 9.81;
    d_11 = (m_1 + m_2) * r^2 + I_1;
    d_12 = m_2 * r * L*cos(theta_2);
    d_22 = m_2 * L^2 + I_2;
    Delta = d_11 * d_22 - d_12^2;

    % Implement Eq. (15) with small angles approximation
    dx = v;
    dtheta_2 = omega_2;

    % Use small angles approximation for gravitational and centrifugal terms
    h_1 = -m_2 * r * L * theta_2 * omega_2^2;
    h_2 = -m_2 * g * L * theta_2;

    dv = (d_22 * (tau - h_1) + d_12 * (0+ h_2)) / r*Delta;
    domega_2 = (-d_12 * (tau - h_1) - d_11 * (0 + h_2)) / Delta;

    % Output dx
    dx = [dx; dtheta_2; dv; domega_2];
end

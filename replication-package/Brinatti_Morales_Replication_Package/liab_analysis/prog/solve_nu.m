function x = solve_nu(beta_val)
    % Function to solve for x in the equation:
    % beta = Gamma(1 - 2/x) / (Gamma(1 - 1/x))^2 - 1

    % Define the equation as a function handle
    equation = @(x) (gamma(1 - 2/x) / (gamma(1 - 1/x)^2)) - (beta_val + 1);
    
    % Initial guess for x (you may need to adjust this)
    initial_guess = 3; 
    
    % Use fsolve to find the root of the equation
    options = optimset('Display', 'off'); % Suppress output
    x = fsolve(equation, initial_guess, options);
    
    % Display result
    fprintf('The value of x for beta_val = %.4f is: %.4f\n', beta_val, x);
end
function y = Somm_2deg(c,d)
% This function generates the two-argument function.
% Specific to HED case only
%% Global Parameters
global i % index number of the distance array
global p % distance
global nu % Switch for TE/TM case (alpha = 0 -> TE, else -> TM)
global f omega 
global ep1 ep2 
global k1 k2 
% Courtesy of Mazin M Mustafa

kp = c + d;

% Material Parameters
% f = 25e12;
% omega = 2*pi*f;
% ep1 = 1;
% ep2 = -.3113 + 1i*.0005;
% mu0 = 4*pi*1e-7;
% ep0 = 8.854e-12;
% k1 = omega*sqrt(mu0*ep0*ep1);
% k2 = omega*sqrt(mu0*ep0*ep2);

% When the singularity lies near the upper limit
% if sing == 0
%     if d >= 0
%         kz1 = ((k1 + kp) ^0.5) * ((k1 - kp) ^0.5);
%     else
%         kz1 = ((k1 + kp) ^0.5) * ((d) ^0.5);
%     end
%
%     % When singularity lies near the lower limit
% else
%     if d >= 0
%         kz1 =  sqrt(-1) * ((k1 + kp) ^0.5) * (d ^0.5);
%     else
%         kz1 = ((k1 + kp) ^0.5) * ((k1 - kp) ^0.5) ;
%     end
% end


kz1 = sqrt(k1 ^2 - kp ^2);

kz2 = sqrt(k2 ^2 - kp ^2);

% end



% Satisfying Radiation Condition
if imag(kz2) > 0
    kz2 = conj(kz2);
end
if imag(kz1) > 0
    kz1 = conj(kz1);
end

gamma_1h = -(kz2 - kz1) / (kz2 + kz1);
gamma_1e = (kz2 / ep2 - kz1) / (kz2 / ep2 + kz1);

G_1 = k1 * (gamma_1h) / (1i * kz1) ; % Green's function for TE case
G_2 = k1 / kp * (gamma_1e - gamma_1h) ; % Green's function for TM case
G_3 = k1 * (gamma_1e) / (1i * kz1) ;

if nu == 0 % TE case
    y = G_1 * besselj(nu, kp * p(i)) * kp; % Sommerfeld Integrand for G_xx
%     y = G_3 * besselj(0, kp * p(i)) * kp; % Green's function for G_zz
else
    y = G_2 * besselj(nu, kp * p(i)) * kp; % Green's function for G_zx
    
end


end

clear all;close all
%% Global Parameters
tol = 1e-6;

% Generate the integrand of eq. (80) from [1]
nu = 1;
tau = 1;
q = 3e-8; %Index Spacing
alpha = .5;
zeta = 0;

%% HED
f = 10e9;
omega = 2*pi*f;
ep1 = 1;
ep2 = 10 - 1i*18;
mu0 = 4*pi*1e-7;
ep0 = 8.854e-12;
k1 = omega*sqrt(mu0*ep0*ep1);
k2 = omega*sqrt(mu0*ep0*ep2);
kz1 = @(c,d) sqrt(k1^2 - (c+d).^2);
% kz1 = @(x) sqrt(k1^2 - (x).^2);
kz2 = @(c,d) sqrt(k2^2 - (c+d).^2);
% kz2 = @(x) sqrt(k2^2 - (x).^2);
gamma_1h = @(c,d) -(kz2(c,d) - kz1(c,d))./(kz2(c,d) +kz1(c,d));
% gamma_1h = @(x) -(kz2(x) - kz1(x))./(kz2(x) +kz1(x));
gamma_1e = @(c,d) (kz2(c,d)/ep2 - kz1(c,d))./(kz2(c,d)/ep2 +kz1(c,d));
G_2 = @(c,d) k1./((c+d)).*(gamma_1e(c,d) - gamma_1h(c,d));
p = linspace(1e-3/k1,1e1/k1,250);
a = 2*k1; % According to paper
% %% Integral
for i = 1 : length(p)
%     
%     %     f = @(c,d) exp(-(c+d)*z(i)).*besselj(nu, rho*(c+d))...
%     %         .*besselj(3/2, tau*(c+d)).*(c+d).^.5;
    f = @(c,d) G_2(c,d).*besselj(nu, p(i)*(c+d)).*(c+d);
%     %     f = @(x) exp(-(x)*z(i)).*besselj(nu, rho*(x))...
%     %         .*besselj(3/2, tau*(x)).*(x).^.5;
    yy(i) = PE(f,a,tol, q, zeta, alpha);
%     
end
% 
% %% Plot
loglog(k1*p,abs(yy)/k1)
% % axis([1e-3 1e1 1e-3 2e-0]) % Closest to Michalski's paper
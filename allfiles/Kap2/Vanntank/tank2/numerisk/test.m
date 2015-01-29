% Program test
% Avsnitt 2.4.1 : Sylindrisk vanntank
% med konstant veggtykkelse.
% Finner forskyvning, skj�rkraft og moment ved bruk
% av skyteteknikk.
% Denne versjonen beregner beta fra gitte parametre.
%
% Ligning : w''''(x) + 4*beta^4*w(x)= -4*beta^4*(1-x)
% Randbetingelser : w(0) = 0, w'(0) = 0, w''(1)=0, w'''(1) = 0
% Ligningen er line�r, men er stiv n�r beta er stor.
%
clear
% === Data ===
R = 8.5; % Radius[m]
H = 7.95; % H�yde[m]
t = 0.35; % Tykkelse[m]
ny = 0.2; % Poissons tall
beta = H*(3*(1-ny^2)/(R*t)^2)^0.25;
fprintf('     beta = %7.4f\n',beta);
beta4 = beta^4;
xspan = [0  1.0];
s = [0 0 1];  r = [0 1 0];
options = odeset('Reltol',1.0e-7,'AbsTol', 1.0e-7);
% ===== Skyter tre ganger for � finne s* og r* =====
for k = 1:3   
   y0 = [0.0; 0.0 ; s(k) ; r(k)]; 
   [x,y] = ode45(@fcntank,xspan,y0,options,beta4);
   phi(k) = y(end,3); psi(k) = y(end,4);
end
nev = (psi(3)-psi(1))*(phi(2)-phi(1)) - (phi(3) - phi(1))*(psi(2)-psi(1));
rstar= (phi(3)*psi(1) - psi(3)*phi(1))/nev;
sstar = (psi(2)*phi(1) - phi(2)*psi(1))/nev;
fprintf('     r* = %12.5e  s* = %12.5e \n\n',rstar,sstar);
% % ===== Tabell over forskyvning w ,helning dw/dx osv. =====
% xspan = [0: 0.05 :1.0];
% y0 = [0.0 ;0.0 ;sstar; rstar];
% [x,y] = ode45(@fcntank,xspan,y0,options,beta4);
% y(:,3) = -y(:,3); y(:,4)= -y(:,4);
% fprintf('       x         w             dw/dx           m(x)            v(x)\n\n');
% fprintf( '%10.3f  %13.5e  %13.5e   %13.5e  %13.5e \n',[x y]');
% m = y(:,3)/beta; v = y(:,4)/beta^2;
% % ====== Plotting av m(x)/beta og v(x)/beta^2 =====
% clf
% plot(x,m,'k-',x,v,'k-.','LineWidth',1.25);
% grid on
% xlabel('x','FontSize',14)
% st = sprintf('Vanntank. \\beta = %6.4f',beta);
% title(st,'Fontsize',14)
% legend('m(x)/\beta','v(x)/\beta^2')




  
 
%%
% *Part 5: Chrip Signals and Frequency Modulation* 


Dur= 2.0;
Ts = 0.0001;
t = linspace(0, Dur, Dur * 10000);
phase = 0;
%--2500Hz to 500Hz
f0 = 2500;
f1 = 500;
u = (f1-f0)/(2*Dur);
x5 = cos(2*pi*u.*(t.^2)+2*pi*f0.*t+phase);



figure;
plot(t,x5);
xlabel('Time(s)');
ylabel('x5(t)');
title('Chrip Signal from 2500 Hz to 500 Hz');
xlim([0 2]);
ylim([-1 1]);
grid on; 

soundsc(x5,10000);
pause(3);

%-- 500Hz to 2500Hz
f0 = 500;
f1 = 2500;
Dur= 2.0;
u = (f1-f0)/(2*Dur);

x5 = cos(2*pi*u.*(t.^2)+2*pi*f0.*t+phase);



figure;
plot(t,x5);
xlabel('Time(s)');
ylabel('x5(t)');
title('Chrip Signal from 500 Hz to 2500 Hz');
xlim([0 2]);
ylim([-1 1]);
grid on; 

soundsc(x5,10000);
pause(3);

%-- 3000 to -2000
f0 = 3000;
f1 = -2000;
Dur= 3.0;
Ts = 0.001;
t = linspace(0, Dur, Dur * 10000 );
u = (f1-f0)/(2*Dur);

x5 = cos(2*pi*u.*(t.^2)+2*pi*f0.*t+phase);



figure;
plot(t,x5);
xlabel('Time(s)');
ylabel('x5(t)');
title('Chrip Signal from 3000 Hz to -2000 Hz');
xlim([0 2]);
ylim([-1 1]);
grid on; 

soundsc(x5,10000);
pause(3);

%-----------------


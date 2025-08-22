%%
% *Part 1: Fundamental Frequency and the Harmonics* 

f0 = 440;
Ts = 0.0001;
dur = 3.0;
t = 0:Ts:dur; %time vector

%--f0

x1 = sin(2*pi*f0*t);


figure;
plot(t,x1);
xlabel('Time(s)');
ylabel('Amplitude x1[n]');
title('Discrete Sinusoidal Signal (f0 = 440Hz)');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 


soundsc(x1,10000);
pause(3);

%--2f0
f = 2*f0;
x1 = sin(2*pi*(f)*t);


figure;
plot(t,x1);
xlabel('Time(s)');
ylabel('Amplitude x1[n]');
title('Discrete Sinusoidal Signal (2*f0 = 880Hz)');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 


soundsc(x1,10000);
pause(3);

%-- 4f0
f = 4*f0;
x1 = sin(2*pi*(f)*t);


figure;
plot(t,x1);
xlabel('Time(s)');
ylabel('Amplitude x1[n]');
title('Discrete Sinusoidal Signal (4*f0 = 1760Hz)');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 


soundsc(x1,10000);
pause(3);

%-- Csharp note
fcsh = 554;

x1 = sin(2*pi*(fcsh)*t);


figure;
plot(t,x1);
xlabel('Time(s)');
ylabel('Amplitude x1[n]');
title('Discrete Sinusoidal Signal (C sharp note)');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 


soundsc(x1,10000);
pause(3);


%-- E nore

fe = 659;

x1 = sin(2*pi*(fe)*t);


figure;
plot(t,x1);
xlabel('Time(s)');
ylabel('Amplitude x1[n]');
title('Discrete Sinusoidal Signal (E note)');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 


soundsc(x1,10000);
pause(3);


%-- Major Triad

s = sin(2*pi*440*t)+sin(2*pi*554*t)+sin(2*pi*659*t);

figure;
plot(t,s);
xlabel('Time(s)');
ylabel('s(t)');
title('Major Triad (A + C# + E)');

grid on; 


soundsc(s);
%-----------------------------------------------

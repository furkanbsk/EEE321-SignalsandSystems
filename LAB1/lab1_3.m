%%
% *Part 3: Sinusoid with Exponentially Decaying Envelope* 


Ts = 0.0001;
inifreq = 440;
dur = 3.0;
t = 0:Ts:dur;


%-- a=2
a=2;

x3 = exp(-(a^2+2)*t) .* cos(2*pi*inifreq*t);



figure;
plot(t,x3);
xlabel('Time(s)');
ylabel('Amplitude');
title('Sinusoid with Exponentially Decaying Envelope when a = 2');
xlim([0 3]);
ylim([-1 1]);
grid on; 


soundsc(x3,10000);
pause(3);

%-- a=1
a=1;

x3 = exp(-(a^2+2)*t) .* cos(2*pi*inifreq*t);



figure;
plot(t,x3);
xlabel('Time(s)');
ylabel('Amplitude');
title('Sinusoid with Exponentially Decaying Envelope when a = 1');
xlim([0 3]);
ylim([-1 1]);
grid on; 


soundsc(x3,10000);
pause(3);

%-- a=3
a=3;

x3 = exp(-(a^2+2)*t) .* cos(2*pi*inifreq*t);



figure;
plot(t,x3);
xlabel('Time(s)');
ylabel('Amplitude');
title('Sinusoid with Exponentially Decaying Envelope when a = 3');
xlim([0 3]);
ylim([-1 1]);
grid on; 


soundsc(x3,10000);
pause(3);

%---------------------------------
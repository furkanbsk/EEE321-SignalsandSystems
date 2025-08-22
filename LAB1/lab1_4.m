%%
% *Part 4: Beat Notes and Amplitude Modulation* 

Ts = 0.0001;
dur = 3.0;
t = linspace(0, dur, dur * 1/Ts);

%-- f1=10Hz, f2= 1KHz

f1 = 10;
f2 = 1000;

x4 = cos(2*pi*f1*t) .* cos(2*pi*f2*t);


figure;
plot(t,x4);
xlabel('Time(s)');
ylabel('Amplitude');
title('Beat Notes and Amplitude Modulation x4[n] f1=10Hz, f2= 1KHz');
xlim([0 3]);
ylim([-1 1]);
grid on; 


soundsc(x4, 1/Ts);
pause(3);



%-- f1=5Hz, f2= 1KHz

f1_1 = 5;
f2 = 1000;

x4_1 = 0.5 * (cos(2*pi*(f1_1+f2)*t) + cos(2*pi*(f2-f1_1)*t));


figure;
plot(t,x4_1);
xlabel('Time(s)');
ylabel('Amplitude');
title('Beat Notes and Amplitude Modulation x4[n] f1=5Hz, f2= 1KHz');
xlim([0 3]);
ylim([-1 1]);
grid on; 


soundsc(x4_1, 1/Ts);
pause(3);

%-- f1=15Hz, f2= 1KHz

f1_2 = 15;
f2 = 1000;

x4_2 = 0.5 * (cos(2*pi*(f1_2+f2)*t) + cos(2*pi*(f2-f1_2)*t));


figure;
plot(t,x4_2);
xlabel('Time(s)');
ylabel('Amplitude');
title('Beat Notes and Amplitude Modulation x4[n] f1=15Hz, f2= 1KHz');
xlim([0 3]);
ylim([-1 1]);
grid on; 


soundsc(x4_2, 1/Ts);
pause(3);

%----------------------
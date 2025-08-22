%%
% *Part 2: The Effect of Phase* 

f0 = 587;
Ts = 0.0001;
dur = 3.0;
t = 0:Ts:dur;



%--phase0

phase =0;

x2 = cos(2*pi*f0*t + phase);


figure;
plot(t,x2);
xlabel('Time(s)');
ylabel('Amplitude x2[n]');
title('Discrete Signal x2 with phase "𝜙" = 0  ');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 



soundsc(x2,10000);
pause(3);


%--phase pi/4

phase = pi/4;

x2_1 = cos(2*pi*f0*t + phase);


figure;
subplot(4,1,1);
plot(t,x2);
xlabel('Time(s)');
ylabel('Amplitude x2[n]');
title('Discrete Signal x2 with phase "𝜙" = pi/4  ');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 



soundsc(x2_1,10000);
pause(3);


%--phase pi/2

phase = pi/2;

x2_2 = cos(2*pi*f0*t + phase);



subplot(4,1,2);
plot(t,x2_2);
xlabel('Time(s)');
ylabel('Amplitude x2[n]');
title('Discrete Signal x2 with phase "𝜙" = pi/2  ');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 


soundsc(x2_2,10000);
pause(3);

%--phase 3pi/4

phase = 3*pi/4;

x2_3 = cos(2*pi*f0*t + phase);



subplot(4,1,3);
plot(t,x2_3);
xlabel('Time(s)');
ylabel('Amplitude x2[n]');
title('Discrete Signal x2 with phase "𝜙" = 3*pi/4  ');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 


soundsc(x2_3,10000);
pause(3);

%--phase pi

phase = pi;

x2_4 = cos(2*pi*f0*t + phase);



subplot(4,1,4);
plot(t,x2_4);
xlabel('Time(s)');
ylabel('Amplitude x2[n]');
title('Discrete Signal x2 with phase "𝜙" = pi  ');
xlim([0 0.01]);
ylim([-1 1]);
grid on; 


soundsc(x2_4,10000);
pause(3);

%-----------------------------------------
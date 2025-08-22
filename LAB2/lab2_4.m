
%variables
y = [0,1,2,3,4,5,6,7,8,9];
ID = 22002097;
p = [2,0];
lamda = [1,3,4,5,6,8];

%lenghts
Np = length(p);
Nlamda = length(lamda);

delta = mod(ID,7);
deltap = mod(delta,Np)+1;
deltalamda = mod(delta,Nlamda)+1;

%n1 and n2
n1 = 2;
n2 = 8;

f_s= 8192;
bitsample = 16;
channel = 1; 



figure;

%---my recorded ID and its n1 part
sgtitle('my recorded ID and its n1 part');
[ID, fs] = audioread("ID_record.flac");
%t = 0:length(ID) - 1 / fs;
subplot(2, 1, 1);
title("mine ID");
%soundsc(ID,fs)
Ts2 = 1/f_s;
Temptau2 = 1:length(ID);
t_2 = Temptau2 * Ts2;
plot(t_2,ID);


%----set boundaries of n1 in recorded ID

 t0 =find(t_2 >= 1.7, 1);
 t1 =find(t_2<= 2.25,1,'last');


% Extract the instance into another .flac file
mine_n1 = ID(t0:t1);
audiowrite('n1_mineee.flac', mine_n1, f_s);

%---

soundsc(mine_n1, f_s);
subplot(2,1,2);
t_1 = (0: length(mine_n1)-1) * (1/f_s);
plot(t_1, mine_n1);
title("N1 part");


%---get TotalNumber and googles n1 and n2

figure;

[n1_bot_2, fs_1] = audioread("2.flac");
[n2_bot, fs_2] = audioread("8.flac" );


[bot, FS] = audioread("TotalNumber.flac");
%soundsc(bot,FS)
Ts1 = 1/24000;
Temptau1 = 1:length(bot);
tau1 = Temptau1 * Ts1;
plot(tau1,bot);




figure;
%cross concolution transformation of convolution
flp_mine_n1 =fliplr (transpose(mine_n1));
out_1 = convFUNC(transpose(ID), flp_mine_n1);

%n1 cross convolution in recorded ID, and exponents of the output


sgtitle('n1 cross convolution in recorded ID, and exponents of the output');

t_5 = (0: length(out_1)-1) * (1/f_s);
subplot(3,1,1);
plot(t_5,abs(out_1));
ylabel("\psi [x]");
xlabel("x");
subplot(3,1,2);
plot(t_5,abs(out_1.^2));
ylabel("\psi [x]^2");
xlabel("x")
subplot(3,1,3);
plot(t_5,abs(out_1.^4))
ylabel("\psi [x]^4");
xlabel("x");

%convolution of n2 with TotalNumber
flp_n2_bot = fliplr(transpose(n2_bot));
out_3 = convFUNC(transpose(bot), flp_n2_bot);


% Plot of text-to-speech n1 in recorded ID
figure;
%cross concolution transformation of convolution
flp_n1_bot_2 = fliplr(transpose(n1_bot_2));
out_4 = convFUNC(transpose(ID), flp_n1_bot_2);

sgtitle('text-to-speech n1 in recorded ID');
t_8 = (0: length(out_4)-1) * (1/fs);
subplot(3,1,1);
plot(t_8,abs(out_4));
ylabel("\psi [x]");
xlabel("x");
subplot(3,1,2);
plot(t_8,abs(out_4.^2));
ylabel("\psi [x]^2");
xlabel("x")
subplot(3,1,3);
plot(t_8,abs(out_4.^4))
ylabel("\psi [x]^4");
xlabel("x");

%Plot of Recorded n1 in TotalNumber

figure;
%cross concolution transformation of convolution
flp_mine_n1 = fliplr(transpose(n1_bot_2));
out_5 = convFUNC(transpose(bot), flp_mine_n1);

sgtitle('Recorded n1 in TotalNumber');
t_9 = (0: length(out_5)-1) * (1/FS);
subplot(3,1,1);
plot(t_9,abs(out_5));
ylabel("\psi [x]");
xlabel("x");
subplot(3,1,2);
plot(t_9,abs(out_5.^2));
ylabel("\psi [x]^2");
xlabel("x")
subplot(3,1,3);
plot(t_9,abs(out_5.^4))
ylabel("\psi [x]^4");
xlabel("x");


%Plot of Text to speech in n1 TotalNumber
figure;
%cross concolution transformation of convolution
flp_n1_bot_2 = fliplr(transpose(n1_bot_2));
out_6 = convFUNC(transpose(bot), flp_n1_bot_2);


sgtitle('Text to speech in n1 TotalNumber');
t_9 = (0: length(out_6)-1) * (1/FS);
subplot(3,1,1);
plot(t_9,abs(out_6));
ylabel("\psi [x]");
xlabel("x");
subplot(3,1,2);
plot(t_9,abs(out_6.^2));
ylabel("\psi [x]^2");
xlabel("x")
subplot(3,1,3);
plot(t_9,abs(out_6.^4))
ylabel("\psi [x]^4");
xlabel("x");


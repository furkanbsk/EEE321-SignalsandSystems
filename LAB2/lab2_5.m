[audio_array, FS] = audioread("TotalNumber.flac" );
t_3 = (0: length(audio_array)-1) * (1/FS);

%soundsc(audio_array, FS);
audio_len = length(audio_array);



%power calculations
p_signal = (1/audio_len) * sum(audio_array.^2);
p_noise_SNR10 = p_signal / 10;
display(p_signal);
display(p_noise_SNR10);

disp(p_signal);

rng (5)
awgn = sqrt ( p_noise_SNR10 ) .* randn ([ audio_len , 1]) ;

noisy_audio = audio_array + awgn;

%soundsc(noisy_audio, FS); pause(10);

%SNR = 10
subplot(3, 1, 1);
plot(t_3, noisy_audio);
title("SNR = 10");
xlabel("t");
ylabel("noisy audio");

%SNR = 0.1
p_noise_SNR01 = p_signal / 0.1;
display(p_noise_SNR01);
rng(5);
awgn_2 = sqrt(p_noise_SNR01) .* randn([audio_len, 1]);
noisy_audio_2 = audio_array + awgn_2;

soundsc(noisy_audio_2, FS); pause(10);
subplot(3, 1, 2);
plot(noisy_audio_2);
title("SNR = 0.1");
xlabel("t");
ylabel("noisy audio");


%SNR = 0.001
p_noise_SNR0001 = p_signal / 0.001;
display(p_noise_SNR0001);
rng(5);
awgn_3 = sqrt(p_noise_SNR0001) .* randn([audio_len, 1]);

noisy_audio_3 = audio_array + awgn_3;

soundsc(noisy_audio_3, FS);
subplot(3, 1, 3);
plot(noisy_audio_3);
title("SNR = 0.001");
xlabel("t");
ylabel("noisy audio");

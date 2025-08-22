[audio_array,FS] = audioread("TotalNumber.flac");
addpath('C:\Users\furka\Desktop\Sinyal\LAB2');
[fltr, f_fltr] = audioread("2.flac");
audio_len = length(audio_array);


p_signal = 2/audio_len*sum(audio_array.^2);
disp(p_signal);

figure;

%for loop for SNR dependent plot
for i = 1:10

 snr = 0.011-0.001*i;
 p_noise = p_signal / snr;
 rng(5)
 awgn = sqrt(p_noise) .* randn([audio_len, 1]);
 noisy_audio = awgn + audio_array;

%cross-convolution operation
 filterr = convFUNC(transpose(noisy_audio), fliplr(transpose(fltr)));

 t = (0: length(filterr)-1) * 1/FS;
 sgtitle('Cross convolution with n1 and noisy TotalNumber wtr.changing SNR Values');
 subplot(5,2,i);
 plot(t, abs(filterr));
 title(['Plot of SNR',num2str(snr)]);
 xlabel('Time(s)');
 ylabel('Amplitude');
end
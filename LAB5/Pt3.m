clear

T_duration = 0.5;
sampling_rate = 4000;
Ts = 1 / sampling_rate;

note_frequencies = zeros(1,12);
for idx = 1:12
    note_frequencies(idx) = 440 * 2^((idx - 1) / 12);
end

detected_notes = zeros(1,50/T_duration);
time_vector = 0:Ts:T_duration - Ts;

load MA2_songdata.mat

for seg = 1:50/T_duration
    segment = transpose(songdata((seg - 1)*T_duration*sampling_rate + 1 : seg*T_duration*sampling_rate));
    projection = zeros(1,12);
    for nf = 1:12
        projection(nf) = abs(sum(Ts * segment .* sin(2 * pi * note_frequencies(nf) * time_vector)));
    end
    [~, best_match] = max(projection);
    detected_notes(seg) = note_frequencies(best_match);
end

qsong = zeros(200000,1);
for seg = 1:50/T_duration
    note_waveform = sin(2 * pi * detected_notes(seg) * time_vector);
    qsong((seg - 1)*T_duration*sampling_rate + 1 : seg*T_duration*sampling_rate) = transpose(note_waveform);
end

%sound(qsong, sampling_rate)


sigma_values = 1:10;
for sigma = sigma_values
    figure()
    noisy_song = songdata + sigma * randn(length(songdata),1) / 100;
    time_range = transpose(0:Ts:50-Ts);
    
    subplot(1,2,1)
    plot(time_range, songdata)
    xlim([0 50])
    ylim([-0.8 0.8])
    title("Actual Song")
    
    subplot(1,2,2)
    plot(time_range, noisy_song)
    xlim([0 50])
    ylim([-0.8 0.8])
    title("Corrupted Song")
    
    sgtitle("\sigma = " + sigma + " Comparison")
end



chosen_sigma = 7;
noisy_song = songdata + chosen_sigma * randn(length(songdata),1) / 100;
detected_noisy_notes = zeros(1,50/T_duration);

for seg = 1:50/T_duration
    segment = transpose(noisy_song((seg - 1)*T_duration*sampling_rate + 1 : seg*T_duration*sampling_rate));
    projection = zeros(1,12);
    for nf = 1:12
        projection(nf) = abs(sum(Ts * segment .* sin(2 * pi * note_frequencies(nf) * time_vector)));
    end
    [~, best_match] = max(projection);
    detected_noisy_notes(seg) = note_frequencies(best_match);
end

reconstructed_song = zeros(200000,1);
for seg = 1:50/T_duration
    note_waveform = sin(2 * pi * detected_noisy_notes(seg) * time_vector);
    reconstructed_song((seg - 1)*T_duration*sampling_rate + 1 : seg*T_duration*sampling_rate) = transpose(note_waveform);
end

%sound(reconstructed_song, sampling_rate)

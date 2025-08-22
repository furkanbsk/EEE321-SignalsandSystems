%%
% *Part 6: Composing Music* 

notename = {'A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#'};

song = {'E', 'G', 'A', 'E', 'G', 'A', 'B', 'D', 'C', 'B', 'A', 'E', 'G', 'A', 'B', 'D', 'C', 'B', 'A', 'G', 'E', 'G', 'A', 'E'};


songidx = zeros(1, length(song));
for k1 = 1:length(song)
    idx = strcmp(song{k1}, notename);
    songidx(k1) = find(idx);
end


durations = [0.3, 0.3, 0.3, 0.2, 0.2, 0.2, 0.4, 0.4, 0.4, 0.3, 0.3, 0.3, ...
             0.5, 0.2, 0.2, 0.3, 0.3, 0.3, 0.4, 0.4, 0.4, 0.3, 0.3, 0.5];

dur = round(durations * 8192); % Scale with sampling rate


songnote = [];
for k1 = 1:length(songidx)
    note_wave = notecreate(songidx(k1), dur(k1));
    songnote = [songnote; [note_wave zeros(1, 50)]']; % Short silence
end


soundsc(songnote, 8192);

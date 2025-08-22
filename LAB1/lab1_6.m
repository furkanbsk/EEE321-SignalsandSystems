
% Array of note names
notename = {'A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#'};
% Specify the song notes and their durations
song = {'E', 'G', 'A', 'E', 'G', 'A', 'B', 'D', 'C', 'B', 'A', 'E', 'G', 'A', 'B', 'D', 'C', 'B', 'A', 'G', 'E', 'G', 'A', 'E'};
for k1 = 1:length(song)
    idx = strcmp(song{k1}, notename);
    songidx(k1) = find(idx);
end

% Set the duration for each note
%dur = round(0.3*8192);


% Generate the waveform for each note and concatenate
songnote = [];
for k1 = 1:length(songidx)
    songnote = [songnote; [notecreate(songidx(k1), dur) zeros(1, 75)]'];
end

% Play the composed song
soundsc(songnote, 8192);
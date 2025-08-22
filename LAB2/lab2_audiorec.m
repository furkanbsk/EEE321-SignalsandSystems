recObj = audiorecorder(8192, 16, 1);

recDuration = 10;
disp("Recording Start.")
recordblocking(recObj,recDuration);
disp("File ID_record.flac recorded.")

play(recObj);

audioData = getaudiodata(recObj);

audiowrite('ID_recordd.flac', audioData, 8192);
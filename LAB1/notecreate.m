function [note] = notecreate(frqno, dur)
    % Generate a sine wave for the given frequency and duration
    note = sin(2*pi*[1:dur]/8192 * (440 * 2.^((frqno-1)/12)));
end
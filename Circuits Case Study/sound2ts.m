% This function imports a sound file and expresses it as a timeseries of
% the specified duration. If the sound file is shorter than the specified
% duration, it will be extended with blank samples (zeros). If it is
% longer, it will truncate it to the duration specified.

% The function returns two arguments, the constructed time series and the
% sample rate of the sound file.
function [ts, Fs] = sound2ts(filename, simDuration, warnings)
    [audio, Fs] = audioread(filename);
    t = (0:1/Fs:(simDuration-1/Fs))';
    if length(audio)<length(t)
        if warnings
            warning("Audio file " + filename + " extended from " + length(audio) + " samples to " + length(t) + " samples to fit Simulation Time.")
        end
        audio = [audio' zeros(1, length(t)-length(audio))]';
    elseif length(audio)>length(t)
        if warnings
            warning("Audio file " + filename + " truncated from " + length(audio) + " samples to " + length(t) + " samples to fit Simulation Time.")
        end
        audio = audio(1:length(t));
    end
    ts = timeseries(audio,t);
end


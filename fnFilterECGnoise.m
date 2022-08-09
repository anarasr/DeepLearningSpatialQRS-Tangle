function [signal] = fnFilterECGnoise(signal, fs, order, fc)
%FNFILTERECGNOISE Removes baseline wandering and high frequency noise from
%an ECG. It filters first with high-pass and then with a low-pass
%filter Butterworth filters.
%-------------------------------------------------------------------------
%   INPUTS:
%-------------------------------------------------------------------------
%   1) signal: MxL matrix containing the ECG with L leads.
%   2) fs: sampling frequency.
%   3) order: An 1x2 cell containing the order of the High- and Low-pass
%   filters (e.g. {3,5} indicates an 3rd order high- and 5th order low-pass
%   filter).
%   4) fc: An 1x2 cell containing the cut-off frequencies of the high- and
%   low-pass filters (e.g. {0.5, 100} indicates a cut-off frequency of
%   0.5Hz (high-pass) and 100Hz (low-pass).
%-------------------------------------------------------------------------
%   OUTPUTS:
%-------------------------------------------------------------------------
%   1) signal: MxL matrix containing the filtered signal.
%-------------------------------------------------------------------------
%   NECESSARY FUNCTIONS:
%-------------------------------------------------------------------------
%   None.
%-------------------------------------------------------------------------
% Written by: Ana Rodrigues (ana.rodrigues@ktu.lt)
%-------------------------------------------------------------------------

% Set the signal in the correct form (collumn vectors)
[R_temp,K_temp] = size(signal);
if R_temp < K_temp
    signal = signal';
end
% Get the Nyquist frequency
Nf = fs/2;

% Remove baseline wandering
Cf      = fc{1}/Nf;         % Cutoff freq.
% High pass filter
[bh,ah] = butter(order{1},Cf,'high');   
signal  = filtfilt(bh,ah,signal);

% Remove high-frequency noise
Cf      = fc{2}/Nf;           % Cutoff freq
[bl,al] = butter(order{2},Cf,'low');    % Low pass filter
signal  = filtfilt(bl,al,signal);

end
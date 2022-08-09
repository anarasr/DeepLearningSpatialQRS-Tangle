function [ECG_filtered, Pks] = fnAnnotateECGwithECGDeli(ecg, Fs, LEAD_INFO)
%FNANNOTATEECGWITHECGDELI The function uses the ECGDeli toolbox to annotate
%ECG signals. If more than one lead is provided, it returns the multi-lead
%decision as well.
%   The code is implemented by the authors of the ECGDeli toolbox, which
%   should be downloaded from their GitHub:
%   https://github.com/KIT-IBT/ECGdeli. Do not forget to add the toolbox to
%   your path. 
% When using this resource, please cite the original authors:
%   [1] Nicolas Pilia, Claudia Nagel, Gustavo Lenis, Silvia Becker, 
%   Olaf Dössel, Axel Loewe. "ECGdeli - An open source ECG delineation toolbox 
%   for MATLAB". SoftwareX, Volume 13, 2021. DOI: 10.1016/j.softx.2020.100639
%-------------------------------------------------------------------------
%   INPUTS:
%-------------------------------------------------------------------------
%   1) ecg: MxL matrix containing the ECG with L leads. It should be
%   filtered.
%   2) Fs: sampling frequency.
%   3) LEAD_INFO: 1xL vector specifying which columns correspond to each
%   lead.
%-------------------------------------------------------------------------
%   OUTPUTS:
%-------------------------------------------------------------------------
%   1) ECG_filtered: MxL matrix containing the filtered signal (after
%   isoline correction).
%   2) Pks: A struct containing the annotation of the ECG signal. It
%   contains the annotation for multi-lead decision (Pks.multi) and for
%   each individual lead (Pks.(LEAD), e.g. PKs.i). It returns P-wave,
%   QRS-wave, and T-wave annotations.
%-------------------------------------------------------------------------
%   NECESSARY FUNCTIONS:
%-------------------------------------------------------------------------
%   None.
%-------------------------------------------------------------------------

% Get ECG info
[ORIGINAL_ECG_LEN, NUM_OF_LEADS] = size(ecg);
% As per recommendation of the authors in [1], if the signal is very small, 
% extend it to ~30 beats (here, ~30s).
if ORIGINAL_ECG_LEN/Fs < 30
    ecg = [ecg; repmat(ecg, [fix(30/(ORIGINAL_ECG_LEN/Fs)) - 1, 1])];
end

% Isoline correction [1]
[ecg_filtered_isoline,~,~,~]    = Isoline_Correction(ecg);

% Feature calculation
% Decisio should be made only with 12-leads
[FPT_MultiChannel,FPT_Cell]     = Annotate_ECG_Multi(...
    ecg_filtered_isoline(:, 1:min(12, NUM_OF_LEADS)),Fs);

% Get original ECG
ecg = ecg(1:ORIGINAL_ECG_LEN,:);
ECG_filtered = ecg_filtered_isoline(1:ORIGINAL_ECG_LEN,:);

% Find where the last peak is for all leads
i_end = FPT_MultiChannel(:,12) <= ORIGINAL_ECG_LEN;
FPT_MultiChannel = FPT_MultiChannel(i_end,:);

% Prepare struct
fields = {"Pon"; "Pp"; "Poff"; "QRSon"; "Q"; "R"; "S"; "QRSoff"; "J"; "Ton"; "Tp"; "Toff"};
for i = 1:length(fields)
    Pks.multi.(fields{i}) = FPT_MultiChannel(:,i);
end

for j = 1:min(12,NUM_OF_LEADS)
    for i = 1:length(fields)
        P = FPT_Cell{j};
        P = P(i_end,:);
        Pks.(LEAD_INFO{j}).(fields{i}) = P(:,i);
    end
end

end
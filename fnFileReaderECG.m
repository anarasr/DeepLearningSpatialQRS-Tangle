function [ecg_raw] = fnFileReaderECG(ecg_id, PTBXL_DATABASE, DATA_DIR)
%FNFILEREADERECG Reads the raw ECG files from the PTB-XL Database.
%   The function reads the raw files (in '.dat') format and loads it to
%   MATLAB environment. It is built to make it easier to access within a
%   loop.
%-------------------------------------------------------------------------
%   INPUTS:
%-------------------------------------------------------------------------
%   1) ecg_id: 1x1 double containing the ECG ID provided in the PTB-XL
%   table.
%   2) PTBXL_DATABASE: Table containing the information regarding all
%   the recordings of PTB-XL database.
%   3) DATA_DIR: A char or string specifying the directory of raw data.
%-------------------------------------------------------------------------
%   OUTPUTS:
%-------------------------------------------------------------------------
%   1) ecg_raw: Mx12 double containing the 12-lead ECGs.
%-------------------------------------------------------------------------
%   NECESSARY FUNCTIONS:
%-------------------------------------------------------------------------
%   None.
%-------------------------------------------------------------------------
% Written by: Ana Rodrigues (ana.rodrigues@ktu.lt)
%-------------------------------------------------------------------------

global CURRENT_DIR

% Fix DATA_DIR format
DATA_DIR = char(DATA_DIR);
if DATA_DIR(end) ~= '/'
    DATA_DIR = [DATA_DIR, '/'];
end

% Find full directory of the given 'ecg_id'
sig_dir     = cellstr(split(string(PTBXL_DATABASE(PTBXL_DATABASE.ecg_id == ecg_id,:).filename_hr), "/"));
% Get the recording name and folders
[mainfolder, subfolder, recording_name]= deal(sig_dir{:});

% Switch the environment
cd([DATA_DIR, mainfolder, '/', subfolder, '/'])
% Read file
fid        = fopen([recording_name, '.dat']);
% Get the raw ECG and convert to volts
ecg_raw    = transpose(fread(fid, [12 inf], 'int16'))./1000;
% Close file
fclose(fid);
% Get back to current environment
cd(CURRENT_DIR);

end
clear all; close all; clc

global CURRENT_DIR

% Declare directories and paths
CURRENT_DIR     = pwd;
DATA_DIR        = '/Users/ana/Desktop/QRS-Ta/Signals PTB-XL/';
% Toolboxes and functions
addpath(genpath([CURRENT_DIR,'/', 'Toolboxes/']));

% Declare other important variables
fs              = 500;       % Sampling frequency
SQI_THRESH      = 0.8;       % Threshold for Signal-Quality-Index (SQI)
% Leads per column, according to the PTB-XL documentation
LEAD_INFO       = ["i", "ii", "iii", "avl", "avr", "avf", "v1", ...
    "v2", "v3", "v4", "v5", "v6"];  

% Get table of recording info (Download in the PTB-XL Physionet page)
PTBXL_DATABASE = readtable("ptbxl_database.csv");
SCP_STATEMENTS = readtable("scp_statements.csv");

% Select ECG to read
ecg_id      = 13000;
ECG_raw     = fnFileReaderECG(ecg_id, PTBXL_DATABASE, DATA_DIR);

%% ------------------------------------------------------------
%                   A. SIGNAL PROCESSING
% -------------------------------------------------------------
% ---------------------------------------
% A.1. VCG Transformation
% ---------------------------------------
% Construction of X,Y,Z vector beat using Kor's transformation matrix
VCG_raw     = fnEcg2Vcg(ECG_raw, LEAD_INFO);
% Concatenate signals
Signals_raw = [ECG_raw, VCG_raw];

% ---------------------------------------
% A.2. Filtering
% ---------------------------------------
% We use the ECGDeli toolbox for this step. Neverthless, other any 
% other filters can be used.



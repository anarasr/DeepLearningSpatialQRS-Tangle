function [vcg] = fnEcg2Vcg(ecg, LEAD_INFO)
%FNECG2VCG Converts an ECG to Frank's VCG using the Kors' regression
%matrix.
%   The Frank's vectocardiogram (VCG) can be derived from the standard
% electrocardiogram (ECG) using the Kors' regression matrix described in:
%
%   [1] Kors JA, van Herpen G, Sittig AC, van Bemmel JH. 
% Reconstruction of the Frank vectorcardiogram from standard 
% electrocardiographic leads: diagnostic comparison of different methods. 
% Eur Heart J. 1990 Dec;11(12):1083-92. 
% doi: 10.1093/oxfordjournals.eurheartj.a059647.
%-------------------------------------------------------------------------
%   INPUTS:
%-------------------------------------------------------------------------
%   1) ecg: MxL matrix containing the ECG with L leads. L >= 7. If L == 7,
%   then the function assumes that L=1 is lead 'I', L=2 is lead 'II', and
%   L=[3,...,7] are leads 'V1,..., V6'. If L > 7, please provide LEAD_INFO.
%   2) LEAD_INFO: 1xL vector specifying which columns correspond to each
%   lead. LEAD_INFO is mandatory if L > 7. 
%-------------------------------------------------------------------------
%   OUTPUTS:
%-------------------------------------------------------------------------
%   1) vcg: Mx3 matrix containing the VCG (X, Y, and Z leads).
%-------------------------------------------------------------------------
%   NECESSARY FUNCTIONS:
%-------------------------------------------------------------------------
%   None.
%-------------------------------------------------------------------------
% Written by: Ana Rodrigues (ana.rodrigues@ktu.lt)
%-------------------------------------------------------------------------

if size(ecg,2) < 8
    error("Not enough leads provided to convert the ECG to VCG.")
end

% Leads to convert the ECG to VCG according to Kors' [1]:
VCG_LEADS = ["i", "ii", "v1", "v2", "v3", "v4", "v5", "v6"];

if nargin < 2 || isempty(LEAD_INFO)
    % Only allow LEAD_INFO to not be given as input if enough leads to
    % transform the ECG to VCG are provided
    if size(ecg,2) ~= length(VCG_LEADS)
        error("Please provide information about leads.");
    else
        LEAD_INFO = VCG_LEADS;
    end
end

% Find the right leads before conversion
iVCG_leads = sum(cell2mat(arrayfun(@(x) strcmpi(VCG_LEADS(x), LEAD_INFO), ...
    1:length(VCG_LEADS), 'UniformOutput', false)'));

% Load Kors' regression matrix [1]:
c      = [];
c(1,:) = [0.380	-0.070 -0.130 0.050 -0.010 0.140 0.060	0.540];
c(2,:) = [-0.070 0.930 0.060 -0.020 -0.050 0.060 -0.170 0.130];
c(3,:) = [0.110 -0.230 -0.430 -0.060 -0.140	-0.200 -0.110 0.310];
% Construct
vcg = (c*ecg(:, find(iVCG_leads))')';

end
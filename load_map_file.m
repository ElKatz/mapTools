function [map] = load_map_file(fileName)
%   [map] = load_map_file(fileName)
%
% Loads an alphaLab .mat file and performs basic processing.
% The AlphaLab SNR system (Alpha Omega) records data and outputs .map/mpx
% files on the AlphaLab PC. User must use alphaLab "mapConversion" software
% to convert the .map/mpx files to a .mat file to use this funciton.
% * Important: user must choose the "convert channels as struct" option in
% the conversion software otherwise, well, you'll see.
%
% INPUT:
%   fileName - full path to map/mpx file
% OUTPUT:
%   map      - strcut of electrophysiological goodies

% 20170114 - lnk.


%%
clear all

% option 1
% fileName = '/Users/leorkatz/Dropbox/Code/krauzlislab_code/mpx_files/testing_conversion_software/vProbe_in_saline_struct.mat');
% option 2
% fileName = '/Users/leorkatz/Dropbox/Code/krauzlislab_code/mpx_files/testing_conversion_software/mapfile0025_struct.mat');
% option 3
if nargin < 1
    fileName = '/Users/leorkatz/Dropbox/Code/krauzlislab_code/mpx_files/testing_conversion_software/mapfile0027_struct.mat';
end

load(fileName);
[~, name, ~] = fileparts(fileName);
disp(['processing ' name])
clear name


%%

% Channel_ID_Name_Map has the info for channels:
info.channelName  = arrayfun(@(x) x.Name, Channel_ID_Name_Map, 'UniformOutput', 0);
info.channelID    = arrayfun(@(x) x.ID, Channel_ID_Name_Map);

%% AI:
idxAI       = cellfun(@(x) ~isempty(x), strfind(info.channelName, 'CAI'));
if any(idxAI)
    chName  = info.channelName(idxAI);
    nCh     = numel(chName);
    ai = repmat(struct(...
        'name', [], ...
        'number', [], ...
        'id', [], ...
        'samples', [], ...
        'bitResolution', [], ...
        'gain', [], ...
        'KHz', [], ...
        'KHzOriginal', [], ...
        'timeBegin', [], ...
        'timeEnd', []), ...
        [1, nCh]);
    
    for iCh = 1:nCh
        ai(iCh).name            = chName{iCh};
        ai(iCh).number          = str2num(chName{iCh}(end-2:end));
        eval(['ai(iCh).id              = ' chName{iCh} '.ID;']);
        eval(['ai(iCh).samples         = ' chName{iCh} '.Samples;']);
        eval(['ai(iCh).bitResolution   = ' chName{iCh} '.BitResolution;'])
        eval(['ai(iCh).gain            = ' chName{iCh} '.Gain;'])
        eval(['ai(iCh).KHz             = ' chName{iCh} '.KHz;'])
        eval(['ai(iCh).KHzOriginal     = ' chName{iCh} '.KHz_Orig;'])
        eval(['ai(iCh).timeBegin       = ' chName{iCh} '.TimeBegin;'])
        eval(['ai(iCh).timeEnd         = ' chName{iCh} '.TimeEnd;'])
    end
else 
    ai = nan;
end

%% LFP:
idxLFP       = cellfun(@(x) ~isempty(x), strfind(info.channelName, 'CLFP'));
if any(idxLFP)
    chName  = info.channelName(idxLFP);
    nCh     = numel(chName);
    lfp = repmat(struct(...
        'name', [], ...
        'number', [], ...
        'id', [], ...
        'samples', [], ...
        'bitResolution', [], ...
        'gain', [], ...
        'KHz', [], ...
        'KHzOriginal', [], ...
        'timeBegin', [], ...
        'timeEnd', []), ...
        [1, nCh]);
    
    for iCh = 1:nCh
        lfp(iCh).name            = chName{iCh};
        lfp(iCh).number          = str2num(chName{iCh}(end-2:end));
        eval(['lfp(iCh).id              = ' chName{iCh} '.ID;']);
        eval(['lfp(iCh).samples         = ' chName{iCh} '.Samples;']);
        eval(['lfp(iCh).bitResolution   = ' chName{iCh} '.BitResolution;'])
        eval(['lfp(iCh).gain            = ' chName{iCh} '.Gain;'])
        eval(['lfp(iCh).KHz             = ' chName{iCh} '.KHz;'])
        eval(['lfp(iCh).KHzOriginal     = ' chName{iCh} '.KHz_Orig;'])
        eval(['lfp(iCh).timeBegin       = ' chName{iCh} '.TimeBegin;'])
        eval(['lfp(iCh).timeEnd         = ' chName{iCh} '.TimeEnd;'])
    end
else
    lfp = nan;
end

%% SPK:
idxSPK       = cellfun(@(x) ~isempty(x), strfind(info.channelName, 'CSPK'));
if any(idxSPK)
    chName  = info.channelName(idxSPK);
    nCh     = numel(chName);
    spk = repmat(struct(...
        'name', [], ...
        'number', [], ...
        'id', [], ...
        'samples', [], ...
        'bitResolution', [], ...
        'gain', [], ...
        'KHz', [], ...
        'KHzOriginal', [], ...
        'timeBegin', [], ...
        'timeEnd', []), ...
        [1, nCh]);
    
    for iCh = 1:nCh
        spk(iCh).name            = chName{iCh};
        spk(iCh).number          = str2num(chName{iCh}(end-2:end));
        eval(['spk(iCh).id              = ' chName{iCh} '.ID;']);
        eval(['spk(iCh).samples         = ' chName{iCh} '.Samples;']);
        eval(['spk(iCh).bitResolution   = ' chName{iCh} '.BitResolution;'])
        eval(['spk(iCh).gain            = ' chName{iCh} '.Gain;'])
        eval(['spk(iCh).KHz             = ' chName{iCh} '.KHz;'])
        eval(['spk(iCh).KHzOriginal     = ' chName{iCh} '.KHz_Orig;'])
        eval(['spk(iCh).timeBegin       = ' chName{iCh} '.TimeBegin;'])
        eval(['spk(iCh).timeEnd         = ' chName{iCh} '.TimeEnd;'])
    end
else 
    spk = nan;
end

%% SEG:
idxSEG       = cellfun(@(x) ~isempty(x), strfind(info.channelName, 'CSEG'));
if any(idxSEG)
    chName  = info.channelName(idxSEG);
    nCh     = numel(chName);
    seg = repmat(struct(...
        'name', [], ...
        'number', [], ...
        'id', [], ...
        'samples', [], ...
        'bitResolution', [], ...
        'gain', [], ...
        'KHz', [], ...
        'KHzOriginal', [], ...
        'level', [], ...
        'levelSeg', [], ...
        'template', [], ...
        'templateSeg', [], ...
        'timeBegin', [], ...
        'timeEnd', []), ...
        [1, nCh]);
    
    for iCh = 1:nCh
        seg(iCh).name            = chName{iCh};
        seg(iCh).number          = str2num(chName{iCh}(end-2:end));
        eval(['seg(iCh).id              = ' chName{iCh} '.ID;']);
        eval(['seg(iCh).samples         = ' chName{iCh} '.Samples;']);
        eval(['seg(iCh).bitResolution   = ' chName{iCh} '.BitResolution;'])
        eval(['seg(iCh).gain            = ' chName{iCh} '.Gain;'])
        eval(['seg(iCh).KHz             = ' chName{iCh} '.KHz;'])
        eval(['seg(iCh).KHzOriginal     = ' chName{iCh} '.KHz_Orig;'])
        eval(['seg(iCh).level           = ' chName{iCh} '.LEVEL;'])
        eval(['seg(iCh).levelSeg        = ' chName{iCh} '.LEVEL_SEG;'])
        eval(['seg(iCh).template        = ' chName{iCh} '.Template;'])
        eval(['seg(iCh).templateSeg     = ' chName{iCh} '.Template_SEG;'])
        eval(['seg(iCh).timeBegin       = ' chName{iCh} '.TimeBegin;'])
        eval(['seg(iCh).timeEnd         = ' chName{iCh} '.TimeEnd;'])
    end
else
    seg = nan;
end

%% Ports

% Ports_ID_Name_Map has the info for ports:
info.portName  = arrayfun(@(x) x.Name, Ports_ID_Name_Map, 'UniformOutput', 0);
info.portID    = arrayfun(@(x) x.ID, Ports_ID_Name_Map);

port = struct;
for iP = 1:numel(info.portName)
    if exist(info.portName{iP}, 'var')
        eval(['port.(info.portName{iP}) = ' info.portName{iP} ';']);
    end
end
if isempty(fieldnames(port))
    port = nan;
end

%% SF
sf = struct;
sfName = whos('SF_*');
for iSf = 1:numel(sfName)
    eval(['sf. ' lower(sfName(iSf).name) ' = ' sfName(iSf).name ';']);
end
if isempty(fieldnames(sf))
    sf = nan;
end


%% PACK UP:

map.info    = info;
map.ai      = ai;
map.lfp     = lfp;
map.spk     = spk;
map.seg     = seg;
map.port    = port;
map.sf      = sf;





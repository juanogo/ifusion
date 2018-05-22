function R_points = extractEndDiastole(angioinfo)
% R_points = extractEndDiastole(angioinfo)
%
% SYNOPSIS: Extract End-Diasole points (Q points) from an ECG signal and
%           converts them to frame positions.
%
% INPUT:    angioinfo: the DICOM info of the X-Ray angiography video
%
% OUTPUT:   R_points:  a vector containing the indexes of frames
%           corresponding to End-Diastole points.
%
% REF:      
%
% COMMENTS:
%

visualize = false;
%visualize = true;

%
% Extract the ECG signal from the DICOM info, if present
%
try
    ECG_signal = double(angioinfo.CurveData_0);
catch
    %
    % if the fiels 'Curva_Data_0' is not present, the function returns the 
    % indices of all the frames in the DICOM file
    %
    R_points = 1:angioinfo.NumberOfFrames;
    return
end

if visualize
    figure, plot(ECG_signal);
end

%
% Smooth out the ECG signal using a low pass butterworth filter
%
[b,a] = butter(10,(1/8),'low');
ECG_signal = filtfilt(b,a,ECG_signal);

if visualize
    hold on, plot(ECG_signal,'r');
end

%
% normalize to [0 1]
%
ECG_signal = ECG_signal - min(ECG_signal(:));
ECG_signal = ECG_signal / max(ECG_signal(:));

%
% Find values above 0.5 i.e. S points
%
S_points = find(ECG_signal > 0.5);
S_wave   = zeros(size(ECG_signal,1),1);
S_wave(S_points) = 1;

%
% Find local maxima (+1) and minima (-1)
%
le = (sign(imfilter(ECG_signal,[-1 1 0]','same')) + sign(imfilter(ECG_signal,[0 1 -1]','same')))/2;

%
% Remove local maxima not corresponding to the S wave
%
lm = le.* S_wave;

%
% Find S points
%
indexes = find(lm == 1);

if visualize
    figure, plot(ECG_signal,'b'), hold on, plot(indexes,ECG_signal(indexes),'ro');
end

%
% For each S point, find the previous local minima
%
for i=1:size(indexes,1)
    j = indexes(i);
    while (le(j) ~= -1)
        j = j - 1;
        %
        % This 'if' statement checks if we are at the beginning of the
        % ECG signal: avoids reading le(0).
        %
        if (j == 0)
            R_points(i) = 1;
            le(1) = -1;
            j = 1;
        end
    end
    R_points(i) = j;
end

if visualize
    hold on, plot(R_points,ECG_signal(R_points),'ko');
end

%
% Converts R points from ECG sampling rate to DICOM frame rate.
%
R_points = round(R_points*(angioinfo.NumberOfFrames / size(ECG_signal,1)));

%
% Converts an eventual '0' (due to the previous conversion) to '1' to avoid
% errors in reading a '0' index.
%
R_points(R_points == 0) = 1;




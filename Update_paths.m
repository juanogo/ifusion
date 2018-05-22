function Update_paths(name)
% Update_paths(name)
%
% SYNOPSIS: Change the path of store cases (actually change variable of a
%           given .mat file).
%
% INPUT:    name: a string containing the patient file name without path neither extention
%           
%           path1 is the path of the BPL angio
%           path2 is the path of the BPR angio
%           path3 is the path of the APR angio
%           path4 is the path of the APL angio
%           path5 is the path of the Coronography angio
%           path6 is the path of the Pullback IVUS
%
% OUTPUT:   None. It modifies the MATLAB archive 'name'.
%
% REF:
%
% COMMENTS:
%

roots=['BP_L';'BP_R';'AP_R';'AP_L';'Ivus'];

load (name)

for i=1:6
    path = input(['Enter the new path for ' roots(i,:) ' (path+filename): '], 's');
    eval(['path' num2str(i) '=path']);
end

save(name)
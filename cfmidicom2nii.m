function newniinames = cfmidicom2nii(basename, imanames, newdir)

% This script converts DICOM *.IMA files to *.nii format using SPM's
% spm_dicom_convert.m script and renames them to the string input
% "basename". If multiple scans are selected, then they will be numbered,
% e.g., basename_001.nii, basename_002.nii, ....
%
% If no inputs are entered, the spm_select function is used to select DICOM
% files and an output directory, and command line input is used to enter a basename.
% You will need these SPM functions in your MATLAB path:
%    spm.m
%    spm_select.m
%    spm_dicom_headers.m
%    spm_dicom_convert.m
%
% FORMAT: cfmidicom2nii(basename, imanames, newdir)
%
% INPUT:
%    basename = name you want for your nifti file (string); if multiple files are
%            entered, then they will be numbered automagically.
%    imanames = pathnames of files to convert (cell array of strings)
%    newdir = directory in which to move *.nii files.
%
% OUTPUT:
%    newniinames = Character array (number of files x filename length)
%            containing the names of the files that have been converted to
%            NIfTI.
%
% Please note that this script writes a temporary directory (named 'temp')
% in the output directory. This temp directory should get deleted before
% the script stops running; however, if there is an error you may end up
% with a temporary directory and possibly some NIfTI files inside it named
% automatically by spm_dicom_convert.m
%
% Tested on spm5 and spm8 with MATLAB 7.11.0.584 (R2010b)

spm('Defaults','fmri')

if nargin < 2
    imanames = spm_select(Inf, 'any', 'Select DICOM files to convert');
else
    imanames = strvcat(imanames{:});
end

if nargin < 1
    basename = input('Enter a name for the NIfTI file(s) (e.g. Subj001_TaskA) :  ', 's');
end

if nargin < 3
    newdir = spm_select(1, 'dir', 'Select directory for NIfTI files');
end

olddir = pwd;
disp('Switching to temp directory to convert files.')
tempdir = fullfile(newdir,'temp');
mkdir(tempdir);
cd(tempdir)

% convert DICOMs to .nii
disp('Reading DICOM headers...')
hdr = spm_dicom_headers(imanames);
disp('Converting to NIfTI format...')
spm_dicom_convert(hdr,'all','flat','nii');
oldniinames = dir(fullfile(tempdir,'*.nii'));
oldniinames = [{oldniinames.name}]';
disp('Switching back to original directory.')
cd(olddir)

%rename files
disp('Renaming files...')
if numel(oldniinames) > 1
    newniinames = [repmat(fullfile(newdir, [basename  '_']), numel(oldniinames), 1) num2str([1:numel(oldniinames)]','%03d') repmat('.nii', numel(oldniinames), 1)];
    for i=1:numel(oldniinames)
        movefile(fullfile(tempdir,oldniinames{i}), newniinames(i,:));
    end
    disp('Removing temp directory');
    rmdir(tempdir);
else %only one file to convert, so don't add numbers to the basename.
    newniinames = fullfile(newdir, [basename '.nii']);
    movefile(fullfile(tempdir,oldniinames{1}), newniinames);
    disp('Removing temp directory');
    rmdir(tempdir);
end

disp(['Finished writing ' num2str(size(newniinames,1)) ' NIfTI files to ' newdir])


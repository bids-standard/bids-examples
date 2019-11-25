%This function loads EEGLAB *.set files into the ALLEEG structure. This is
%useful for loading segmented files that are ready to create a STUDY
%structure. The fnamefile input is a text file containing the filenames
%with paths to each of the *.set files to be loaded (one file per line).
%From a bash terminal these file name text files can be created as follows:
%for example...
%'find . -type f -name "*-SEG*.set" > derivatives/seg_face_noise/code/misc/fnames.txt

function [EEG,ALLEEG,CURRENTSET]=loadfnames(EEG,fnamefile)

fid=fopen(fnamefile,'r');
fnd=fread(fid);
fclose(fid);
cr_ind=find(fnd==10);
for i=1:length(cr_ind);
   if i==1;
      c_fname{i}=deblank(char(fnd(3:cr_ind(i))'));
      %EEG=eeg_checkset(EEG);
      %ALLEEG(i)=EEG;
   else
      c_fname{i}=deblank(char(fnd(cr_ind(i-1)+3:cr_ind(i))'));
      %EEG=eeg_checkset(EEG);
      %ALLEEG(i)=EEG;
   end
end
ALLEEG = pop_loadset('filename',c_fname);
CURRENTSET=i;
EEG=eeg_checkset(EEG);
eeglab redraw

mk_dataset_description;
savejson('',dataset_description,'dataset_description.json');
% Taking the below file construction out as it is never going to be something to automate as part of the bids procedure.
% participants = mk_participants('participants.tsv');
% Following line will create an empty tsv in the proper directory.
system('touch participants.tsv');
disp('-----------------------------------');

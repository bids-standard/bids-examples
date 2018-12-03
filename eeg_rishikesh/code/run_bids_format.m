% files = {
% {'expert'     [0 0]    'M' 32 'Alan-Deci.bdf' 'Alan2-Deci.bdf' }
% {'novice'     [0]      'M' 47 'Caroline-Deci.bdf' }
% {'novice'     [0 0]    'M' 52 'Corine-Deci.bdf' 'Corine2-Deci.bdf'}
% {'novice'     [0]      'M' 78 'Curnel-Deci.bdf'}
% {'novice'     [0 0]    'M' 77 'Emeliana-Deci.bdf' 'Emeliana2-Deci.bdf'}
% {'novice'     [0 0]    'M' 32 'Geeta-Deci.bdf' 'Geeta2-Deci.bdf'}
% {'expert'     [0 0]    'M' 35 'John-Deci.bdf' 'John2-Deci.bdf'}
% {'expert'     [0 0]    'F' 41 'Litza-Deci.bdf' 'Litza2-Deci.bdf'}
% {'novice'     [0 0]    'F' 00 'Magda-Deci.bdf' 'Magda2-Deci.bdf'}
% {'expert'     [0 0]    'M' 29 'Marco-Deci.bdf' 'Marco2-Deci.bdf'}
% {'expert'     [0 0]    'F' 34 'Maria-Deci.bdf' 'Maria2-Deci.bdf'}
% {'novice'     [0]      'F' 42 'Marilou-Deci.bdf'}
% {'badsubject' [0]      'F' 00 'Maryone-Deci.bdf'}
% {'expert'     [0 0]    'M' 32 'Michael-Deci.bdf' 'Michael2-Deci.bdf'}
% {'badsubject' [0]      'F' 00 'Pamela-Deci.bdf'}
% {'expert'     [0 0]    'M' 32 'Pravin-Deci.bdf' 'Pravin2-Deci.bdf'}
% {'expert'     [0]      'M' 32 'RamPakash-Deci.bdf'}
% {'expert'     [0 0]    'M' 43 'Randy-Deci.bdf' 'Randy2-Deci.bdf'}
% {'novice'     [0]      'F' 41 'Sonia-Deci.bdf'}
% {'expert'     [0 0]    'M' 33 'Souesh-Deci.bdf' 'Souesh2-Deci.bdf'}
% {'expert'     [1 1]    'M' 62 'Stoma-Deci.bdf' 'Stoma2-Deci.bdf'}
% {'expert'     [1]      'M' 65 'SwamiMarada-Deci.bdf'}
% {'novice'     [1]      'F' 41 'Sylvia-Deci.bdf'}
% {'novice'     [0 0 1]  'F' 31 'Tracy1-Deci.bdf' 'Tracy2-Deci.bdf' 'Tracy3-Deci.bdf'}
% {'novice'     [0 0]    'M' 50 'Winthrop-Deci.bdf' 'Winthrop2-Deci.bdf'}
% {'novice'     [0]      'F' 38 'Yvonne-Deci.bdf' } };

clear;

files = { 
    {'/Users/arno/temp/BIDS_delorme/sub-Expert01/ses-01/eeg/sub-Expert01_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert01/ses-02/eeg/sub-Expert01_ses-02_task-medprobe_eeg.bdf' }

{'/Users/arno/temp/BIDS_delorme/sub-Expert02/ses-01/eeg/sub-Expert02_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert02/ses-02/eeg/sub-Expert02_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert03/ses-01/eeg/sub-Expert03_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert03/ses-02/eeg/sub-Expert03_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert04/ses-01/eeg/sub-Expert04_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert04/ses-02/eeg/sub-Expert04_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert05/ses-01/eeg/sub-Expert05_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert05/ses-02/eeg/sub-Expert05_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert06/ses-01/eeg/sub-Expert06_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert06/ses-02/eeg/sub-Expert06_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert07/ses-01/eeg/sub-Expert07_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert07/ses-02/eeg/sub-Expert07_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert08/ses-01/eeg/sub-Expert08_ses-01_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert09/ses-01/eeg/sub-Expert09_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert09/ses-02/eeg/sub-Expert09_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert10/ses-01/eeg/sub-Expert10_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert10/ses-02/eeg/sub-Expert10_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert11/ses-01/eeg/sub-Expert11_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Expert11/ses-02/eeg/sub-Expert11_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Expert12/ses-01/eeg/sub-Expert12_ses-01_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice01/ses-01/eeg/sub-Novice01_ses-01_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice02/ses-02/eeg/sub-Novice02_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice03/ses-01/eeg/sub-Novice03_ses-01_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice04/ses-01/eeg/sub-Novice04_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Novice04/ses-02/eeg/sub-Novice04_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice05/ses-01/eeg/sub-Novice05_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Novice05/ses-02/eeg/sub-Novice05_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice06/ses-01/eeg/sub-Novice06_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Novice06/ses-02/eeg/sub-Novice06_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice07/ses-01/eeg/sub-Novice07_ses-01_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice08/ses-01/eeg/sub-Novice08_ses-01_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice09/ses-01/eeg/sub-Novice09_ses-01_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice10/ses-01/eeg/sub-Novice10_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Novice10/ses-02/eeg/sub-Novice10_ses-02_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Novice10/ses-03/eeg/sub-Novice10_ses-03_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice11/ses-01/eeg/sub-Novice11_ses-01_task-medprobe_eeg.bdf'
'/Users/arno/temp/BIDS_delorme/sub-Novice11/ses-02/eeg/sub-Novice11_ses-02_task-medprobe_eeg.bdf'}

{'/Users/arno/temp/BIDS_delorme/sub-Novice12/ses-01/eeg/sub-Novice12_ses-01_task-medprobe_eeg.bdf' } };

% bids_format_eeglab_old('/Users/arno/temp/rishikesh', files, 'meditation');
generalInfo.Name = 'Meditation study';

pInfo = { 'gender'   'age'   'group'; % from file mw_expe_may28_2015 and convert_files_to_bids.m
'M'	32 'expert';
'M'	35 'expert';
'F'	41 'expert';
'M'	29 'expert';
'F'	34 'expert';
'M'	32 'expert';
'M'	32 'expert';
'M'	32 'expert';
'M'	43 'expert';
'M'	33 'expert';
'M'	62 'expert';
'M'	65 'expert';
'F'	47 'novice';
'F'	52 'novice';
'F'	78 'novice';
'M'	77 'novice';
'F'	32 'novice';
'F'	'n/a' 'novice';
'F'	42 'novice';
'F'	41 'novice';
'F'	41 'novice';
'F'	31 'novice';
'M'	50 'novice';
'F'	38 'novice' };
       
pInfoDesc.gender.LongName = 'gender, classified as male or female';
pInfoDesc.participant_id.LongName = 'unique participant identifier';
pInfoDesc.age.LongName = 'age in years';
pInfoDesc.group.LongName = 'group, expert or novice meditators';
pInfoDesc.group.Levels.expert = 'expert meditator';
pInfoDesc.group.Levels.novice = 'novice meditator';

eInfoDesc.onset.LongName = 'Event onset';
eInfoDesc.onset.Units = 'second';
eInfoDesc.duration.LongName = 'Event duration';
eInfoDesc.duration.Units = 'second';
eInfoDesc.event_sample.LongName = 'Event sample (Matlab convention starting at 1)';
eInfoDesc.event_type.LongName = 'Type of event (different from EEGLAB convention)';
eInfoDesc.event_value.LongName = 'Value of event (numerical or text)';

README = sprintf( [ 'This meditation experiment contains 24 subjects. Subjects were\n' ...
                    'meditating and were interupted about every 2 minutes to indicate\n' ...
                    'their level of concentration and mind wandering. The scientific\n' ...
                    'article (see Reference) contains all methodological details\n\n' ...
                    '- Arnaud Delorme (October 17, 2018)' ]);
CHANGES = sprintf([ 'Revision history for meditation dataset\n\n' ...
                    '0.1 2018-10-17\n' ...
                    ' - Initial release\n' ]);
stimuli = {'/data/matlab/tracy_mw/rate_mw.wav' 
    '/data/matlab/tracy_mw/rate_meditation.wav'
    '/data/matlab/tracy_mw/rate_tired.wav'
    '/data/matlab/tracy_mw/expe_over.wav'
    '/data/matlab/tracy_mw/mind_wandering.wav'
    '/data/matlab/tracy_mw/self.wav'
    '/data/matlab/tracy_mw/time.wav'
    '/data/matlab/tracy_mw/valence.wav'
    '/data/matlab/tracy_mw/depth.wav'
    '/data/matlab/tracy_mw/resume.wav'
    '/data/matlab/tracy_mw/resumed.wav'
    '/data/matlab/tracy_mw/resumemed.wav'
    '/data/matlab/tracy_mw/cancel.wav'
    '/data/matlab/tracy_mw/starting.wav' };

code = { '/data/matlab/tracy_mw/run_mw_experiment6.m' '/data/matlab/bids_matlab/rishikesh_study/bids_format_eeglab.m' '/data/matlab/bids_matlab/rishikesh_study/run_bids_format.m' };

tInfo.InstitutionAddress = 'Centre de Recherche Cerveau et Cognition, Place du Docteur Baylac, Pavillon Baudot, 31059 Toulouse, France';
tInfo.InstitutionName = 'Paul Sabatier University';
tInfo.InstitutionalDepartmentName = 'Centre de Recherche Cerveau et Cognition';
tInfo.PowerLineFrequency = 50;
tInfo.ManufacturersModelName = 'ActiveTwo';

bids_format_eeglab(files, 'taskName', 'meditation', 'gInfo', generalInfo, 'pInfo', pInfo, 'pInfoDesc', pInfoDesc, 'eInfoDesc', eInfoDesc, 'README', README, 'CHANGES', CHANGES, 'stimuli', stimuli, 'codefiles', code, 'tInfo', tInfo);

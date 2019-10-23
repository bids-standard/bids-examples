#!/bin/bash
set -e
#OMPI_MCA_mpi_cuda_support=0
#export OMPI_MCA_mpi_cuda_support

module unload intel
module load intel/2017.1
module load imkl/2017.1.132

sbatch --job-name=s02_amica_init_sub-001_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-001_task-faceFO_eeg.log --dependency=afterok:19977161 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-001/eeg/sub-001_task-faceFO_init.param
')
sbatch --job-name=s02_amica_init_sub-002_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-002_task-faceFO_eeg.log --dependency=afterok:19977162 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-002/eeg/sub-002_task-faceFO_init.param
')
sbatch --job-name=s02_amica_init_sub-003_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-003_task-faceFO_eeg.log --dependency=afterok:19977163 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-003/eeg/sub-003_task-faceFO_init.param
')
sbatch --job-name=s02_amica_init_sub-004_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-004_task-faceFO_eeg.log --dependency=afterok:19977164 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-004/eeg/sub-004_task-faceFO_init.param
')
sbatch --job-name=s02_amica_init_sub-005_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-005_task-faceFO_eeg.log --dependency=afterok:19977165 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-005/eeg/sub-005_task-faceFO_init.param
')
sbatch --job-name=s02_amica_init_sub-006_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-006_task-faceFO_eeg.log --dependency=afterok:19977166 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-006/eeg/sub-006_task-faceFO_init.param
')
sbatch --job-name=s02_amica_init_sub-007_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-007_task-faceFO_eeg.log --dependency=afterok:19977167 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-007/eeg/sub-007_task-faceFO_init.param
')
sbatch --job-name=s02_amica_init_sub-008_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-008_task-faceFO_eeg.log --dependency=afterok:19977168 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-008/eeg/sub-008_task-faceFO_init.param
')
sbatch --job-name=s02_amica_init_sub-009_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-009_task-faceFO_eeg.log --dependency=afterok:19977170 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_init.param
')
sbatch --job-name=s02_amica_init_sub-010_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s02_amica_init-2019-10-01T14-35-11/sub-010_task-faceFO_eeg.log --dependency=afterok:19977171 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-010/eeg/sub-010_task-faceFO_init.param
')
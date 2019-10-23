#!/bin/bash
set -e
#OMPI_MCA_mpi_cuda_support=0
#export OMPI_MCA_mpi_cuda_support

module unload intel
module load intel/2017.1
module load imkl/2017.1.132

sbatch --job-name=s04c_amica_sub-001_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-001_task-faceFO_eeg.log --dependency=afterok:19977194 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-001/eeg/sub-001_task-faceFO_C.param
')
sbatch --job-name=s04c_amica_sub-002_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-002_task-faceFO_eeg.log --dependency=afterok:19977195 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-002/eeg/sub-002_task-faceFO_C.param
')
sbatch --job-name=s04c_amica_sub-003_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-003_task-faceFO_eeg.log --dependency=afterok:19977196 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-003/eeg/sub-003_task-faceFO_C.param
')
sbatch --job-name=s04c_amica_sub-004_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-004_task-faceFO_eeg.log --dependency=afterok:19977197 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-004/eeg/sub-004_task-faceFO_C.param
')
sbatch --job-name=s04c_amica_sub-005_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-005_task-faceFO_eeg.log --dependency=afterok:19977198 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-005/eeg/sub-005_task-faceFO_C.param
')
sbatch --job-name=s04c_amica_sub-006_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-006_task-faceFO_eeg.log --dependency=afterok:19977199 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-006/eeg/sub-006_task-faceFO_C.param
')
sbatch --job-name=s04c_amica_sub-007_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-007_task-faceFO_eeg.log --dependency=afterok:19977200 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-007/eeg/sub-007_task-faceFO_C.param
')
sbatch --job-name=s04c_amica_sub-008_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-008_task-faceFO_eeg.log --dependency=afterok:19977201 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-008/eeg/sub-008_task-faceFO_C.param
')
sbatch --job-name=s04c_amica_sub-009_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-009_task-faceFO_eeg.log --dependency=afterok:19977202 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_C.param
')
sbatch --job-name=s04c_amica_sub-010_task-faceFO_eeg --output=derivatives/BIDS-Lossless-EEG/log/s04c_amica-2019-10-01T14-35-11/sub-010_task-faceFO_eeg.log --dependency=afterok:19977203 --mem-per-cpu=2000m --time=02:00:00 --cpus-per-task=8 --account=def-bucanl <(echo -e '#!/bin/bash\nsrun derivatives/BIDS-Lossless-EEG/code/dependencies/eeglab_lossless/plugins/amica/amica15 derivatives/BIDS-Lossless-EEG/./sub-010/eeg/sub-010_task-faceFO_C.param
')
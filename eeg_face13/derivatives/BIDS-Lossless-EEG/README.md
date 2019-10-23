# The Lossless EEG Pipeline

![photo](https://www.cosc.brocku.ca/~tk11br/pipelineGraphic.png)

This repository contains the lossless EEG pipeline package that contains everything you need to get started processing EEG data.

## Documentation
A reference manual for the pipeline can be found on the [Wiki](https://github.com/BUCANL/BIDS-Lossless-EEG/wiki)

A tutorial for using the pipeline with a sample dataset can be found [here](https://bucanl.github.io/SDC-LOSSLESS/)

## How to Run
This installation assumes familiarity with the bash terminal, paths, and Matlab console use, as well as requires the use of a remote computer cluster and git. These setup steps can be run to set up the pipeline for use with the Face13 sample dataset during the tutorial or for use with your own data.

**Local Setup**
1. If necessary, create a derivatives folder within your project folder (this will be the Face13 folder if you are doing the tutorial): `mkdir derivatives`
2. Change directory into the derivatives folder: `cd derivatives`
3. Within the derivatives folder, clone the pipeline locally: `git clone --recursive https://github.com/BUCANL/BIDS-Lossless-EEG.git`

**Remote Setup**

4. Navigate to your remote computer cluster and create a remote project folder: `mkdir project_name`
5. In the project_name folder, create a derivatives folder: `mkdir derivatives`
6. Change directory into the derivatives folder: `cd derivatives`
7. Within the derivatives folder, clone the pipeline on the remote: `git clone --recursive https://github.com/BUCANL/BIDS-Lossless-EEG.git`
8. Navigate back to the project root: `cd ..`
9. Run the remote setup and follow the on screen prompts: `bash derivatives/BIDS-Lossless-EEG/code/install/setup-remote.sh`

**Running Files Through the Pipeline**

10. Copy files from local to remote. Instructions for copying files can be found in the [Face13 tutorial](https://bucanl.github.io/SDC-LOSSLESS/03-submit/index.html)
11. Point Matlab to your project_name folder (Face13 folder if you are doing the tutorial)
12. In the Matlab console execute: `addpath derivatives/BIDS-Lossless-EEG/code/install`
13. In the Matlab console execute: `lossless_path`
14. In the Matlab console execute: `eeglab`
15. Run history files s01-s05, with batch context configuration files c01-c05, and an appropriate context configuration on selected data files in a history template batch. Information on how to set up a context configuration and load the history template batch can be found in the [Face13 tutorial](https://bucanl.github.io/SDC-LOSSLESS/03-submit/index.html)
16. Copy completed files from remote to local. Instructions for copying files can be found in the [Face13 tutorial](https://bucanl.github.io/SDC-LOSSLESS/03-submit/index.html)

## Contact / Issues
Feel free to make an issue in the [Issue Tracker](https://github.com/BUCANL/BIDS-Lossless-EEG/issues)
or [contact us directly](https://github.com/BUCANL/BIDS-Lossless-EEG/wiki/Contacting-Us)

## License / Copyright

Copyright (C) 2017 James Desjardins and others
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with this program (LICENSE.txt file in the root directory); if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

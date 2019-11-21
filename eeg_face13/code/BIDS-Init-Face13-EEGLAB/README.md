# BIDS-Init-Face13-EEGLAB
Root BIDS level initialization and BIDSification tool suite

## How to Run
This installation assumes familiarity with the bash terminal, paths, and Matlab console use.
1. Download Face13 sourcedata folder, [here](https://drive.google.com/open?id=1xq85woDpAYXhCtzdgjkXpjjjggiWSKtc)
2. Create a project folder: `mkdir Face13`
3. Move the sourcedata into the project folder and rename as `sourcedata`. This step may differ based on download location and platform.
4. Enter the project folder: `cd Face13`
5. Create a code folder: `mkdir code`
6. Enter code folder: `cd code`
7. Use: `git clone --recursive https://github.com/BUCANL/BIDS-Init-Face13-EEGLAB.git` inside of the code folder
8. Point Matlab to project folder. In our case, Face13.
9. In the Matlab console execute: `addpath code/BIDS-Init-Face13-EEGLAB`
10. In the Matlab console execute: `addpath code/BIDS-Init-Face13-EEGLAB/eeglab`
11. In the Matlab console execute: `eeglab`
12. At this point the familiar eeglab window should appear.
13. To merge and relabel bdf files run: `init_script.m`
14. To BIDSify run: `bids_face13.m`
15. Select the project directory with the file chooser
16. Visualize your data!

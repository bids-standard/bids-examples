#!/bin/bash

set -u
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
functionsource="$DIR/../misc/bashfunc"

cat <<HEAD
Copyright (C) 2017 Brock University Cognitive and Affective Neuroscience Lab

Code written by Mae Kennedy

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program (LICENSE.txt file in the root directory); if not, 
write to the Free Software Foundation, Inc., 59 Temple Place,
Suite 330, Boston, MA  02111-1307  USA

******************************************************************************
This is an interactive program designed to help you setup the remote side
of this pipeline. You need to copy this folder structure to your remote
server/cluster then from within the directory run ./setup-remote.sh from
the root of the project folder (eeg_pipe_asr_amica by default you SHOULD
change the name of this directory).

We will test some things to ensure your environment is setup correctly
and provide steps you may take in order to get your environment in the
correct state to run the pipeline.

HEAD


echo "Moving to root of the project folder.."
cd "$(dirname $BASH_SOURCE)"
echo "Now in `pwd`"

echo "Loading extra bash functions.."
source "$functionsource"

bold "Begin Setup\n"

bold "INFO:"; echo "Verify project submodules have been cloned"
depend="$DIR/../dependencies"
msg="You likely need to run git clone --recursive"
test_dir_exit "$depend/eeglab_lossless" "$msg"
test_dir_exit "$depend/eeglab_lossless/plugins/amica" "$msg"
test_dir_exit "$depend/eeglab_lossless/plugins/batch_context" "$msg"
test_dir_exit "$depend/eeglab_lossless/plugins/vised_marks" "$msg"
test_dir_exit "$depend/eeglab_lossless/plugins/interp_mont" "$msg"

#test_dir_warn "analysis/data/1_init" "Have you copied your data files?"

bold "INFO:"; echo "Making required directories"
logDir="$DIR/../../log"
mkdir -p "$logDir"

if checkset "executable-files" ; then
    bold "INFO:" echo "Ensuring files are executable"
    test_exec "$depend/eeglab_lossless/plugins/amica/amica15"
    set_lockset "executable-files"
fi

if checkset "amica-make" ; then
    bold "INFO:"; echo "Entering amica-make section.."
    # Avoid poluting the environment with subshell
    (
    sesinit="`request_init amica`"
    source "${sesinit}"
    bold "INFO:"; echo "Checking for required programs for building amica"
    test_which "make" "You need GNU/Make (make) in your path to compile"
    test_which "ifort" "You need Intel Fortran compiler in your path to compile"
    test_which "mpif90" "You need mpif90 in order to compile with MPI"

    bold "INFO:"; echo "Moving to $depend/eeglab_lossless/plugins/amica.."
    cd "$depend/eeglab_lossless/plugins/amica"
    bold "INFO:"; echo "Making default target.."
    make amica15-default

	hasavx2=`grep flags /proc/cpuinfo | head -n 1 | grep -o avx2 || true`
    if [ ${hasavx2} ] ; then
        bold "INFO:"; echo "You have avx2 support, we will compile avx2 binaries"
        make amica15-avx2
    fi
    # Probably not required to move back but lets do it anyway
    cd - 
    )
    set_lockset "amica-make"
fi

if checkset "octave-pkgs" ; then
    # Avoid poluting the environment with subshell
    (
    sesinit="`request_init octave`"
    source "${sesinit}"
    bold "INFO:"; echo "Checking for octave"
    test_which "octave" "Octave is required to verify we have the correct packages"

    bold "INFO:"; echo "Checking if we have control, signal, struct, and parallel"
    test_octave_pkg "control" "control-3.0.0.tar.gz"
  
    bold "INFO:" ; echo "This will take some time, please wait patiently"
    test_octave_pkg "signal" "signal-1.3.2.tar.gz"

    bold "INFO:" ; echo "This will take some time, please wait patiently"
    test_octave_pkg "struct" "struct-1.0.14.tar.gz"

    bold "INFO:" ; echo "This will take some time, please wait patiently"
    test_octave_pkg "parallel" "parallel-3.1.1.tar.gz"

    bold "INFO:" ; echo "This will take some time, please wait patiently"
    test_octave_pkg "io" "io-2.4.12.tar.gz"

    )
    set_lockset "octave-pkgs"
fi

if checkset "fieldtrip-made" ; then
    (
    sesinit="`request_init octave`"
    source "${sesinit}"
    bold "INFO:"; echo "Rebuilding Fieldtrip"
    pwd
    cd "$(dirname "$(find ../.. -type d -name 'Fieldtrip*' | head -1)")"/Fieldtrip*
    make clean OCTAVE=`which octave`
    mkdir -p engine/private
    make mex OCTAVE=`which octave`
    cd -
    )
    set_lockset "fieldtrip-made"
fi

good "Completed!"

#!/usr/bin/env bash
#
#  Patches the blocks world domains in the experiments 
# so that they can be parsed by Fast Downward
#  patch-blocks-world.sh
#  Planning-PlanRecognition-Experiments
#
#  Created by Felipe Meneguzzi on 2018-12-27.
#  Copyright 2018 Felipe Meneguzzi. All rights reserved.
#

echo -n "Fixing solution names. Please wait. "

patch_grid() {
    if [[ -d easy-ipc-grid-$1-old-noisy ]]; then
        pushd easy-ipc-grid-$1-old-noisy
        for o in 10 30 50 70 100; do
            pushd $o
            for FILE in *.tar.bz2; do
                NEW_FILE="${FILE/p010/p10}"
                NEW_FILE="${NEW_FILE/p05/p5}"
                NEW_FILE="${NEW_FILE/-5_hyp/-5_p01_hyp}"
                NEW_FILE="${NEW_FILE/-10_hyp/-10_p01_hyp}"
                mv $FILE $NEW_FILE
            done
            popd
        done
        popd
    fi
}

patch_grid optimal
patch_grid suboptimal

echo "Done"
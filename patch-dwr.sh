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

patch_dwr() {
    if [[ -d dwr-$1-old-noisy ]]; then
        pushd dwr-$1-old-noisy
        for o in 10 30 50 70 100; do
            pushd $o
            for FILE in *.tar.bz2; do
                NEW_FILE="${FILE/_100_/_full_}"
                NEW_FILE="${NEW_FILE/pb/p0}"
		mv $FILE $NEW_FILE
            done
            popd
        done
        popd
    fi
}

patch_dwr optimal
patch_dwr suboptimal

echo "Done"

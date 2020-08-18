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

echo -n "Fixing domain.pddl in all experiments. Please wait. "

patch_blocks() {
    if [[ -d $1-old-noisy ]]; then
        pushd $1-old-noisy
        for o in 10 30 50 70 100; do
            pushd $o
            for FILE in *.tar.bz2; do
                FOLDER=${FILE::-8}
                # echo $FOLDER
                mkdir $FOLDER
                tar -jxf $FILE -C $FOLDER
                pushd $FOLDER
                # echo "Editing $FOLDER"
                if [[ `uname` == "Darwin" ]]
                then
                    sed -i .orig 's/-block/- block/g' domain.pddl
                    rm domain.pddl.orig
                elif [[ `uname` == "Linux" ]]
                then
                    sed -i 's/-block/- block/g' domain.pddl
                fi
                tar -jcf ../$FILE .
                popd
                rm -rf $FOLDER
            done
            #for FILE in *.solution; do
            #    NEW_FILE="${FILE/blocksworld/blocks-world}"
            #    mv $FILE $NEW_FILE
            #done
            popd
        done
        popd
    fi
}

patch_blocks depots
patch_blocks driverlog
patch_blocks dwr 
patch_blocks easy-ipc-grid
patch_blocks ferry
patch_blocks logistics
patch_blocks miconic
patch_blocks rovers
patch_blocks satellite
patch_blocks sokoban
patch_blocks zeno-travel
#patch_blocks suboptimal
#patch_blocks optimal-noisy
#patch_blocks suboptimal-noisy

echo "Done"
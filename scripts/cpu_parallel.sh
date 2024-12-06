#!/bin/bash

# Sbatch params
c=8
time=2:00:00
mem=16GB

# Environment setup
source /h/cdoumont/miniconda3/etc/profile.d/conda.sh
conda activate vanillaBO
script_dir="/h/cdoumont/vanilla_bo_in_highdim/"
cd $script_dir || exit

# Task and seed setup
SEEDS="1 2 3 4 5 6 7 8 9 10"
TASKS="lasso_dna mopta svm"  # ant humanoid swimmer

# Loop over tasks and seeds
for task in $TASKS; do
    for seed in $SEEDS; do
        cmd="python3 main.py benchmark=$task seed=$seed debug=False"
        sbatch --wrap="$cmd" --cpus-per-task=$c --mem=$mem --time=$time \
               --output="output.log" --qos=cpu_qos --partition=cpu
    done
done
#!/bin/bash

#SBATCH --job-name=lifelong_poet
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1

# Must be one less that the total number of nodes
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
echo ${nodes_array[@]}

id="x"

experiment=poet_$id

mkdir -p ~/ipp/$experiment
mkdir -p ~/logs/$experiment

# Activate the virtual environment
conda activate poet
echo "Virtual environment activated."

# Run
srun --nodes=1 --ntasks=1 -w ${nodes_array[0]} python3.11 -u original/master.py \
  ~/logs/$experiment \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=256 \
  --eval_batch_size=1 \
  --eval_batches_per_step=5 \
  --master_seed=24582922 \
  --noise_std=0.1 \
  --noise_decay=0.999 \
  --noise_limit=0.01 \
  --normalize_grads_by_noise_std \
  --returns_normalization=centered_ranks \
  --envs stump pit roughness \
  --max_num_envs=25 \
  --adjust_interval=8 \
  --propose_with_adam \
  --steps_before_transfer=25 \
  --num_workers 32 \
  --n_iterations=50000 2>&1 | tee ~/ipp/$experiment/run.log

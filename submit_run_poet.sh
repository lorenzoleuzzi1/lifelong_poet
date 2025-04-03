#!/bin/bash

#SBATCH --job-name=lifelong_poet
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=48

# Get the node names
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST)
nodes_array=( $nodes )
echo "Nodes allocated: ${nodes_array[@]}"

id="task_1"

experiment=lifelong_poet_$id

mkdir -p ~/ipp/$experiment
mkdir -p ~/logs/$experiment

export FIBER_LOG_DIR=~/logs/$experiment
export FIBER_LOG_FILE=~/logs/$experiment/fiber.log
mkdir -p $FIBER_LOG_DIR

# Activate the virtual environment
eval "$(conda shell.bash hook)"
conda activate poet
echo "Virtual environment activated."

# Run
srun -w ${nodes_array[0]} python3.11 -u master.py \
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
  --num_workers=48 \
  --n_iterations=1000 \
  --task '{"motors_torque": 60, "speed_hip": 2, "speed_knee": 8, "leg_w": 8, "leg_h": 34, "terrain_color": [0.5, 0.5, 0.5]}' 2>&1 | tee ~/ipp/$experiment/run.log
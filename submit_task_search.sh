#!/bin/bash

#SBATCH --job-name=lifelong_poet
#SBATCH --nodes=10
#SBATCH --tasks-per-node=10

task1='{"motor_torque": 60, "speed_hip": 2, "speed_knee": 6}'
task2='{"motor_torque": 60, "speed_hip": 2, "speed_knee": 8}'
task3='{"motor_torque": 70, "speed_hip": 2, "speed_knee": 6}'
task4='{"motor_torque": 70, "speed_hip": 2, "speed_knee": 8}'
task5='{"motor_torque": 80, "speed_hip": 2, "speed_knee": 6}'
task6='{"motor_torque": 80, "speed_hip": 2, "speed_knee": 8}'
task7='{"motor_torque": 90, "speed_hip": 2, "speed_knee": 6}'
task8='{"motor_torque": 90, "speed_hip": 2, "speed_knee": 8}'
task9='{"motor_torque": 100, "speed_hip": 2, "speed_knee": 6}'
task10='{"motor_torque": 100, "speed_hip": 2, "speed_knee": 8}'
tasks=("$task1" "$task2" "$task3" "$task4" "$task5" "$task6" "$task7" "$task8" "$task9" "$task10")

# Must be one less that the total number of nodes
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
echo ${nodes_array[@]}

id="task_search"

experiment=poet_$id

# Activate the virtual environment
conda activate poet
echo "Virtual environment activated."

echo "Task $task1"
mkdir -p ~/ipp/${experiment}_1
mkdir -p ~/logs/${experiment}_1
srun --nodes=1 --ntasks=1 -w ${nodes_array[0]} python3.11 -u master.py \
  ~/logs/${experiment}_1 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=4 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task1 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_1/run.log &

echo "Task $task2"
mkdir -p ~/ipp/${experiment}_2
mkdir -p ~/logs/${experiment}_2
srun --nodes=1 --ntasks=1 -w ${nodes_array[1]} python3.11 -u master.py \
  ~/logs/${experiment}_2 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task2 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_2/run.log &

echo "Task $task3"
mkdir -p ~/ipp/${experiment}_3
mkdir -p ~/logs/${experiment}_3
srun --nodes=1 --ntasks=1 -w ${nodes_array[2]} python3.11 -u master.py \
  ~/logs/${experiment}_3 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task3 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_3/run.log &

echo "Task $task4"
mkdir -p ~/ipp/${experiment1}_4
mkdir -p ~/logs/${experiment}_4
srun --nodes=1 --ntasks=1 -w ${nodes_array[3]} python3.11 -u master.py \
  ~/logs/${experiment}_4 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task4 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_4/run.log &

echo "Task $task5"
mkdir -p ~/ipp/${experiment1}_5
mkdir -p ~/logs/${experiment}_5
srun --nodes=1 --ntasks=1 -w ${nodes_array[4]} python3.11 -u master.py \
  ~/logs/${experiment}_5 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task5 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_5/run.log &

echo "Task $task6"
mkdir -p ~/ipp/${experiment1}_6
mkdir -p ~/logs/${experiment}_6
srun --nodes=1 --ntasks=1 -w ${nodes_array[5]} python3.11 -u master.py \
  ~/logs/${experiment}_6 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task6 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_6/run.log &

echo "Task $task7"
mkdir -p ~/ipp/${experiment1}_7
mkdir -p ~/logs/${experiment}_7
srun --nodes=1 --ntasks=1 -w ${nodes_array[6]} python3.11 -u master.py \
  ~/logs/${experiment}_7 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task7 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_7/run.log &

echo "Task $task8"
mkdir -p ~/ipp/${experiment1}_8
mkdir -p ~/logs/${experiment}_8
srun --nodes=1 --ntasks=1 -w ${nodes_array[7]} python3.11 -u master.py \
  ~/logs/${experiment}_8 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task8 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_8/run.log &

echo "Task $task9"
mkdir -p ~/ipp/${experiment1}_9
mkdir -p ~/logs/${experiment}_9
srun --nodes=1 --ntasks=1 -w ${nodes_array[8]} python3.11 -u master.py \
  ~/logs/${experiment}_9 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task9 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_9/run.log &

echo "Task $task10"
mkdir -p ~/ipp/${experiment1}_10
mkdir -p ~/logs/${experiment}_10
srun --nodes=1 --ntasks=1 -w ${nodes_array[9]} python3.11 -u master.py \
  ~/logs/${experiment}_10 \
  --init=random \
  --learning_rate=0.01 \
  --lr_decay=0.9999 \
  --lr_limit=0.001 \
  --batch_size=1 \
  --batches_per_chunk=56 \
  --eval_batch_size=4 \
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
  --num_workers 56 \
  --task=$task10 \
  --n_iterations=2000 2>&1 | tee ~/ipp/${experiment}_10/run.log &

wait # Wait for all background jobs to finish

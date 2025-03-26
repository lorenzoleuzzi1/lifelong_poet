from poet_distributed.niches.box2d.model import Model, make_model, simulate
from collections import namedtuple
import numpy as np

Env_config = namedtuple('Env_config', [
    'name',
    'ground_roughness',
    'pit_gap',
    'stump_width',  'stump_height', 'stump_float',
    'stair_height', 'stair_width', 'stair_steps'
])

Game = namedtuple('Game', ['env_name', 'time_factor', 'input_size',
                           'output_size', 'layers', 'activation', 'noise_bias',
                           'output_noise'])
TRASHOLD = 100
MODEL_PATH = "/Users/lorenzoleuzzi/Desktop/poet_logs/logs/default/poet_default.r1.5.p0.0_1.2.b1_0.2_0.6.best.json"
txt_file = open("results.txt", "w")
txt_file.write("torque,hip,knee,reward,time\n")
results = []

motors_torque_values = [60, 70, 80, 90, 100]
speed_hip_values = [2, 3, 4, 5, 6]
speed_knee_values = [4, 5, 6, 7, 8]

# Intersection of the above values
for torque in motors_torque_values:
    for hip in speed_hip_values:
        for knee in speed_knee_values:
            task = {
                "motor_torque": torque,
                "speed_hip": hip,
                "speed_knee": knee
            }
            DEFAULT_ENV = Env_config(
                name='default_env',
                ground_roughness=0,
                pit_gap=[],
                stump_width=[],
                stump_height=[],
                stump_float=[],
                stair_height=[],
                stair_width=[],
                stair_steps=[])
            bipedhard_custom = Game(env_name='BipedalWalkerCustom-v0',
                                    input_size=24,
                                    output_size=4,
                                    time_factor=0,
                                    layers=[40, 40],
                                    activation='tanh',
                                    noise_bias=0.0,
                                    output_noise=[False, False, False],
                                    )
            model = make_model(bipedhard_custom)
            model.make_env(42, env_config=DEFAULT_ENV, task_config=task, render_mode=False)
            model.load_model(MODEL_PATH)
            r, t = simulate(model, 14, render_mode=False)
            r = np.mean(r)
            t = np.mean(t)
            results.append((torque, hip, knee, r, t))
            txt_file.write(f"{torque},{hip},{knee},{r},{t}\n")

# Select only the config below trashold, meaning different enough task
results = [result for result in results if result[3] < TRASHOLD]
txt_file.write("\n\n")
txt_file.write("Below trashold of 100:\n")
txt_file.write("torque,hip,knee,reward,time\n")
for result in results:
    txt_file.write(f"{result[0]},{result[1]},{result[2]},{result[3]},{result[4]}\n")
txt_file.close()
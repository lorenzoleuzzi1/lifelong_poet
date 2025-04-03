from poet_distributed.niches.box2d.model import Model, make_model, simulate
from collections import namedtuple

Env_config = namedtuple('Env_config', [
    'name',
    'ground_roughness',
    'pit_gap',
    'stump_width',  'stump_height', 'stump_float',
    'stair_height', 'stair_width', 'stair_steps'
])

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

folder = "logs"

name_exp_1 = "lifelong_poet_task_1"
terrain_1 = "flat"
path_1 = f"/home/n.pitzalis/logs/lifelong_poet_task_1/"


name_exp_2 = "lifelong_poet_task_2"
terrain_2 = "r1.5.p0.0_1.2.b1_0.2_0.6"
path_2 = f"/home/n.pitzalis/logs/lifelong_poet_task_2/"

# Load env config from json
path_config = path_1 + f"{name_exp_1}.{terrain_1}.env.json" # "/Users/lorenzoleuzzi/logs/poet_a/poet_a.flat.env.json" # path_1 + f"poet_{name_exp_1}.{terrain_1}.env.json"
import json
with open(path_config, 'r') as f:
    env_config_json = json.load(f)
print(env_config_json)
env_config = Env_config(**env_config_json["config"])
if "task" in env_config_json:
    task = env_config_json["task"]
path_model = path_1 + f"{name_exp_1}.{terrain_1}.best.json" # "/Users/lorenzoleuzzi/logs/poet_a/poet_a.flat.best.json" # path_2 + f"poet_{name_exp_2}.{terrain_2}.best.json"


Game = namedtuple('Game', ['env_name', 'time_factor', 'input_size',
                           'output_size', 'layers', 'activation', 'noise_bias',
                           'output_noise'])

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
model.make_env(42, env_config=env_config, task_config=task, render_mode=True)
model.load_model(path_model)
r, t = simulate(model, 14, render_mode=True)
print(r, t)
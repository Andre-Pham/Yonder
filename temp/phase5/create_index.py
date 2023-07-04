
import os
import plistlib
import json
from PIL import Image
import psutil
import shutil

absolute = os.path.dirname(os.path.realpath(__file__))

ENEMY_METADATA_DIR = os.path.join(absolute, "enemy_metadata")
NPC_METADATA_DIR = os.path.join(absolute, "npc_metadata")

all_foe_ids = []
all_interactors_ids = []

all_filenames = os.listdir(ENEMY_METADATA_DIR)
all_filenames.sort() # Just for consistency between different Mac/Win
for filename in all_filenames:
    period_index = filename.rfind(".")
    id = filename[0:period_index]
    all_foe_ids.append(id)

all_filenames = os.listdir(NPC_METADATA_DIR)
all_filenames.sort() # Just for consistency between different Mac/Win
for filename in all_filenames:
    period_index = filename.rfind(".")
    id = filename[0:period_index]
    all_interactors_ids.append(id)

json_text = {
    "foe_ids": all_foe_ids,
    "interactor_ids": all_interactors_ids,
}
json_object = json.dumps(json_text, indent=4)
with open(os.path.join(absolute, "NPC-DATA-INDEX.json"), "w") as outfile:
    outfile.write(json_object)
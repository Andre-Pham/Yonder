import os
import plistlib
import json
from PIL import Image
import psutil
import shutil

absolute = os.path.dirname(os.path.realpath(__file__))

ENEMY_METADATA_DIR = os.path.join(absolute, "enemy_metadata")
ENEMY_PNGDATA_DIR = os.path.join(absolute, "enemy_pngdata")
ENEMY_PNGS_DIR = os.path.join(absolute, "enemy_pngs")

NPC_METADATA_DIR = os.path.join(absolute, "npc_metadata")
NPC_PNGDATA_DIR = os.path.join(absolute, "npc_pngdata")
NPC_PNGS_DIR = os.path.join(absolute, "npc_pngs")

def print_dictionary(dictionary, by_key=False, reverse=True):
    sorted_items = sorted(dictionary.items(), key=lambda x: x[0 if by_key else 1], reverse=reverse)
    for key, value in sorted_items:
        print(f'{key}: {value}')

def sum_ints_in_dict(dictionary):
    total_sum = 0
    for value in dictionary.values():
        total_sum += value
    return total_sum

print("========== ENEMIES ==========")
enemy_types = {}
for filename in os.listdir(ENEMY_METADATA_DIR):
    file = os.path.join(ENEMY_METADATA_DIR, filename)
    with open(file, "r") as json_file:
        json_object = json.load(json_file)
        type = json_object["type"]
        if type == "divine" or type == "faction1" or type == "faction3" or type == "assassin" or type == "arcane":
            print(">>> DEPRECIATED TYPE FOUND FOR: " + json_object["id"])
        if type in enemy_types:
            enemy_types[type] += 1
        else:
            enemy_types[type] = 1
print_dictionary(enemy_types)
print(">>> NUMBER OF ENEMIES: " + str(sum_ints_in_dict(enemy_types)))

print("========== NPCS ==========")
npc_types = {}
for filename in os.listdir(NPC_METADATA_DIR):
    file = os.path.join(NPC_METADATA_DIR, filename)
    with open(file, "r") as json_file:
        json_object = json.load(json_file)
        type = json_object["type"]
        if type == "divine" or type == "faction1" or type == "faction3" or type == "assassin" or type == "arcane":
            print(">>> DEPRECIATED TYPE FOUND FOR: " + json_object["id"])
        if type in npc_types:
            npc_types[type] += 1
        else:
            npc_types[type] = 1
print_dictionary(npc_types)
print(">>> NUMBER OF NPCS: " + str(sum_ints_in_dict(npc_types)))

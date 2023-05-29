import os
import plistlib
import json
from PIL import Image
import psutil
import shutil

absolute = os.path.dirname(os.path.realpath(__file__))

PREVIEW_DIR = os.path.join(absolute, "..", "src_filtered", "previews")
METADATA_SRC_DIR = os.path.join(absolute, "..", "src_filtered", "metadata")
PNG_SRC_DIR = os.path.join(absolute, "..", "src_filtered", "pngs")
PNGDATA_SRC_DIR = os.path.join(absolute, "..", "src_filtered", "pngdata")

ENEMY_METADATA_DIR = os.path.join(absolute, "enemy_metadata")
ENEMY_PNGDATA_DIR = os.path.join(absolute, "enemy_pngdata")
ENEMY_PNGS_DIR = os.path.join(absolute, "enemy_pngs")

NPC_METADATA_DIR = os.path.join(absolute, "npc_metadata")
NPC_PNGDATA_DIR = os.path.join(absolute, "npc_pngdata")
NPC_PNGS_DIR = os.path.join(absolute, "npc_pngs")

class Metadata:
    def __init__(self):
        self.id = ""
        self.name = ""
        self.description = ""
        self.type = ""
        self.brute = None
        self.thief = None

class EnemyMetadata:
    def __init__(self):
        self.id = ""
        self.name = ""
        self.description = ""
        self.type = ""
        self.brute = None
        self.thief = None
        self.acute = None
        self.obtuse = None

class NPCMetadata:
    def __init__(self):
        self.id = ""
        self.name = ""
        self.description = ""
        self.type = ""
        self.roles = []
        self.shopKeeperTags = []
        self.restorerTags = []
        self.friendlyTags = []
        self.enhancerTags = []
        self.enemyName = ""
        self.enemyType = ""
        self.brute = None
        self.thief = None

all_completed_codes = []
all_completed_id_nums = []

def calibrate():
    codes = all_completed_codes
    for directory in [ENEMY_METADATA_DIR, NPC_METADATA_DIR]:
        for filename in os.listdir(directory):
            file_dir = os.path.join(directory, filename)
            if os.path.isfile(file_dir):
                period_index = filename.rfind(".")
                id = filename[0:period_index]
                id_num = int(id[1:5])
                all_completed_id_nums.append(id_num)
                with open(file_dir, "r") as json_file:
                    json_object = json.load(json_file)
                    code = json_object["code"]
                    codes.append(code)
    removed = read_removed()
    codes += removed
    if len(all_completed_id_nums) == 0:
        set_global_id(0)
    else:
        set_global_id(max(all_completed_id_nums))

def read_global_dir():
    global_id_dir = os.path.join(absolute, "global_id.txt")
    file = open(global_id_dir, "r")
    line = file.read()
    global_id = int(line)
    file.close()
    return global_id

def increment_global_dir():
    global_id_dir = os.path.join(absolute, "global_id.txt")
    new = read_global_dir() + 1
    file = open(global_id_dir, "w")
    file.write(str(new))
    file.close()

def set_global_id(new):
    global_id_dir = os.path.join(absolute, "global_id.txt")
    file = open(global_id_dir, "w")
    file.write(str(new))
    file.close()

def get_npc_id():
    increment_global_dir()
    global_id = str(read_global_dir())
    while len(global_id) < 4:
        global_id = "0" + global_id
    return "N" + global_id

def get_enemy_id():
    increment_global_dir()
    global_id = str(read_global_dir())
    while len(global_id) < 4:
        global_id = "0" + global_id
    return "E" + global_id

def read_removed():
    dir = os.path.join(absolute, "removed.txt")
    file = open(dir, "r")
    content = file.read()
    return content.split('\n')

def add_removed(card_name):
    dir = os.path.join(absolute, "removed.txt")
    file = open(dir, "r")
    content = file.read()
    content += card_name + "\n"
    file.close()
    file = open(dir, "w")
    file.write(content)
    file.close()

def add_boss_candidate(id, card_name, type):
    dir = os.path.join(absolute, "boss_candidates.txt")
    file = open(dir, "r")
    content = file.read()
    content += id + " | " + card_name + " (" + type + ")" + "\n"
    file.close()
    file = open(dir, "w")
    file.write(content)
    file.close()

calibrate()
all_filenames = os.listdir(METADATA_SRC_DIR)
all_filenames.sort() # Just for consistency between different Mac/Win
for filename in all_filenames:
    file_dir = os.path.join(METADATA_SRC_DIR, filename)
    if os.path.isfile(file_dir):
        period_index = filename.rfind(".")
        card_name = filename[0:period_index]
        if card_name in all_completed_codes:
            print("SKIPPING " + card_name + " - ALREADY COMPLETED")
            continue
        # Open the json file
        with open(file_dir, "r") as metadata_file:
            metadata_json = json.load(metadata_file)
            metadata = Metadata()
            metadata.name = metadata_json["name"]
            metadata.description = metadata_json["description"]
            if metadata_json["faction"] == None:
                metadata.type = metadata_json["type"]
            else:
                metadata.type = "faction" + str(metadata_json["faction"])
            metadata.brute = metadata_json["brute"]
            if metadata_json["thief"] == None:
                metadata.thief = False
            else:
                metadata.thief = metadata_json["thief"]
            print("==========  " + metadata.name + " (" + metadata.type + ") " + "(" + card_name + ".png) " + "  ==========")
            if metadata.name.lower() == "removed":
                print("SKIPPING " + card_name + " - REMOVED")
                add_removed(card_name)
                continue
            image = Image.open(os.path.join(PREVIEW_DIR, card_name + ".png"))
            try:
                image.show()
            except:
                print(">>> [ERROR] Could not automatically open:\n> " + os.path.join(PREVIEW_DIR, card_name + ".png"))
            is_npc = None
            while is_npc not in ["y", "n", "removed", "boss"]:
                is_npc = input("NPC? (y/n) (or type 'boss') (or type 'removed')\n")
            if is_npc == "removed":
                print("SKIPPING " + card_name + " - REMOVED")
                add_removed(card_name)
                continue
            # CREATE NPC
            if is_npc == "y":
                npc_metadata = NPCMetadata()
                new_name = input("New name (enter to keep '" + metadata.name + "'):\n")
                if len(new_name) != 0:
                    npc_metadata.name = new_name
                else:
                    npc_metadata.name = metadata.name
                npc_metadata.description = ""
                new_type = None
                while new_type not in ["y", "n"]:
                    if metadata.type == "divine" or metadata.type == "faction1" or metadata.type == "faction3" or metadata.type == "assassin" or metadata.type == "arcane":
                        new_type = "y"
                        print("TYPE AUTOMATICALLY SET TO: ALL")
                    else:
                        new_type = input("Is type 'all'? (n to keep " + metadata.type + ")\n")
                if new_type == "y":
                    npc_metadata.type = "all"
                else:
                    npc_metadata.type = metadata.type
                possible_roles = ["shop", "friendly", "restorer", "enhancer"]
                print("Available roles: " + str(possible_roles))
                for role in possible_roles:
                    is_role = None
                    while is_role not in ["y", "n"]:
                        is_role = input(role + "?\n")
                    if is_role == "y":
                        npc_metadata.roles.append(role)
                # Shop keepers don't have tags
                # Enhancers don't have tags
                if "restorer" in npc_metadata.roles:
                    possible_restorer_tags = ["health", "armor"]
                    for tag in possible_restorer_tags:
                        has_tag = None
                        while has_tag not in ["y", "n"]:
                            has_tag = input("restorer tag: " + tag + "?\n")
                        if has_tag == "y":
                            npc_metadata.restorerTags.append(tag)
                if "friendly" in npc_metadata.roles:
                    possible_friendly_tags = ["sacrifice", "curse", "shop", "trade", "generous"]
                    # print("Available tags: " + str(possible_friendly_tags))
                    friendly_tag_descriptions = {
                        "sacrifice": "Requires the player to sacrifice something, for example health, permanent health",
                        "curse": "Requires the player to get cursed, for example a permanent 5% damage decrease buff",
                        "shop": "Trading gold for (potentially special) items",
                        "trade": "Anything that requires the player to give up items",
                        "generous": "The player just gets something for free"
                    }
                    tag_setting = None
                    while tag_setting not in ["kind", "mean", "all"]:
                        tag_setting = input("Is the npc kind, mean or all?\n")
                    if tag_setting == "mean" or tag_setting == "all":
                        npc_metadata.friendlyTags.append("sacrifice")
                        npc_metadata.friendlyTags.append("curse")
                    elif tag_setting == "kind" or tag_setting == "all":
                        npc_metadata.friendlyTags.append("shop")
                        npc_metadata.friendlyTags.append("trade")
                        npc_metadata.friendlyTags.append("generous")
                    # for tag in possible_friendly_tags:
                    #     has_tag = None
                    #     while has_tag not in ["y", "n"]:
                    #         has_tag = input("friendly tag: " + tag + "?\n(" + friendly_tag_descriptions[tag] + ")\n")
                    #     if has_tag == "y":
                    #         npc_metadata.friendlyTags.append(tag)
                print("=========================================")
                npc_metadata.id = get_npc_id()
                npc_metadata.enemyName = metadata.name
                npc_metadata.enemyType = metadata.type
                npc_metadata.brute = metadata.brute
                npc_metadata.thief = metadata.thief
                json_text = {
                    "id": npc_metadata.id,
                    "code": card_name,
                    "name": npc_metadata.name,
                    "description": npc_metadata.description,
                    "type": npc_metadata.type,
                    "roles": npc_metadata.roles,
                    "shopTags": npc_metadata.shopKeeperTags,
                    "restorerTags": npc_metadata.restorerTags,
                    "friendlyTags": npc_metadata.friendlyTags,
                    "enhancerTags": npc_metadata.enhancerTags,
                    "enemyName": npc_metadata.enemyName,
                    "enemyType": npc_metadata.enemyType,
                    "brute": npc_metadata.brute,
                    "thief": npc_metadata.thief
                }
                json_object = json.dumps(json_text, indent=4)
                with open(os.path.join(NPC_METADATA_DIR, npc_metadata.id + ".json"), "w") as outfile:
                    outfile.write(json_object)
                    shutil.copy2(os.path.join(PNG_SRC_DIR, card_name + ".png"), os.path.join(NPC_PNGS_DIR, "IMG-" + npc_metadata.id + ".png"))
                    shutil.copy2(os.path.join(PNGDATA_SRC_DIR, card_name + ".json"), os.path.join(NPC_PNGDATA_DIR, "FRAMES-" + npc_metadata.id + ".json"))
            # CREATE ENEMY
            else:
                enemy_metadata = NPCMetadata()
                if metadata.type == "divine" or metadata.type == "faction1" or metadata.type == "faction3" or metadata.type == "assassin" or metadata.type == "arcane":
                    new_type = None
                    while new_type not in ["dungeon", "cavern", "forest", "frost", "mech", "nether", "shadow", "desert", "none"]:
                        new_type = input("New type (dungeon, cavern, forest, frost, mech, nether, shadow, desert, none):\n")
                    enemy_metadata.type = new_type
                else:
                    enemy_metadata.type = metadata.type
                enemy_metadata.id = get_enemy_id()
                if is_npc == "boss":
                    add_boss_candidate(enemy_metadata.id, card_name, enemy_metadata.type)
                enemy_metadata.name = metadata.name
                enemy_metadata.brute = metadata.brute
                enemy_metadata.thief = metadata.thief
                is_acute = None
                while is_acute not in ["y", "n"]:
                    is_acute = input("Acute?\n")
                enemy_metadata.acute = is_acute == "y"
                is_obtuse = None
                if is_acute == "y":
                    is_obtuse = "n"
                else:
                    while is_obtuse not in ["y", "n"]:
                        is_obtuse = input("Obtuse?\n")
                enemy_metadata.obtuse = is_obtuse == "y"
                json_text = {
                    "id": enemy_metadata.id,
                    "code": card_name,
                    "name": enemy_metadata.name,
                    "description": enemy_metadata.description,
                    "type": enemy_metadata.type,
                    "brute": enemy_metadata.brute,
                    "thief": enemy_metadata.thief,
                    "acute": enemy_metadata.acute,
                    "obtuse": enemy_metadata.obtuse
                }
                json_object = json.dumps(json_text, indent=4)
                with open(os.path.join(ENEMY_METADATA_DIR, enemy_metadata.id + ".json"), "w") as outfile:
                    outfile.write(json_object)
                    shutil.copy2(os.path.join(PNG_SRC_DIR, card_name + ".png"), os.path.join(ENEMY_PNGS_DIR, "IMG-" + enemy_metadata.id + ".png"))
                    shutil.copy2(os.path.join(PNGDATA_SRC_DIR, card_name + ".json"), os.path.join(ENEMY_PNGDATA_DIR, "FRAMES-" + enemy_metadata.id + ".json"))

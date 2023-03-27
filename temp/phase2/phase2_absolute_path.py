import os
import plistlib
import json
from PIL import Image
import psutil
import shutil

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
    for directory in ['D:\\Yonder\\Assets Phase 2\\enemy_metadata', 'D:\\Yonder\\Assets Phase 2\\npc_metadata']:
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
                    all_completed_codes.append(code)
    if len(all_completed_id_nums) == 0:
        set_global_id(0)
    else:
        set_global_id(max(all_completed_id_nums))

def read_global_dir():
    global_id_dir = 'D:\\Yonder\\Assets Phase 2\\global_id.txt'
    file = open(global_id_dir, "r")
    line = file.read()
    global_id = int(line)
    file.close()
    return global_id

def increment_global_dir():
    global_id_dir = 'D:\\Yonder\\Assets Phase 2\\global_id.txt'
    new = read_global_dir() + 1
    file = open(global_id_dir, "w")
    file.write(str(new))
    file.close()

def set_global_id(new):
    global_id_dir = 'D:\\Yonder\\Assets Phase 2\\global_id.txt'
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

calibrate()
directory = 'D:\\Yonder\\Assets Phase 2\\OLD_METADATA_OUTPUT'
for filename in os.listdir(directory):
    file_dir = os.path.join(directory, filename)
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
            image = Image.open("OLD_PNG_OUTPUT\\" + card_name + ".png")
            with open("OLD_JSON_OUTPUT\\" + card_name + ".json", "r") as json_file:
                json_object = json.load(json_file)
                width = json_object["frame_width"]
                height = json_object["frame_height"]
                x = json_object["breathing_coords"][0]["x"]
                y = json_object["breathing_coords"][0]["y"]
                cropped = image.crop((x, y, x+width, y+width))
                cropped = cropped.resize((width*50, height*50), Image.NEAREST)
                cropped.show()
            print("==========  " + metadata.name + "  ==========")
            is_npc = None
            while is_npc not in ["y", "n"]:
                is_npc = input("NPC?\n")
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
                    new_type = input("Is type 'all'? (n to keep " + metadata.type + ")\n")
                if new_type == "y":
                    npc_metadata.type = "all"
                else:
                    npc_metadata.type = metadata.type
                possible_roles = ["shop", "friendly", "restorer", "enhancer"]
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
                    friendly_tag_descriptions = {
                        "sacrifice": "Requires the player to sacrifice something, for example health, permanent health",
                        "curse": "Requires the player to get cursed, for example a permanent 5% damage decrease buff",
                        "shop": "Trading gold for (potentially special) items",
                        "trade": "Anything that requires the player to give up items",
                        "generous": "The player just gets something for free"
                    }
                    for tag in possible_friendly_tags:
                        has_tag = None
                        while has_tag not in ["y", "n"]:
                            has_tag = input("friendly tag: " + tag + "?\n(" + friendly_tag_descriptions[tag] + ")\n")
                        if has_tag == "y":
                            npc_metadata.friendlyTags.append(tag)
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
                with open("npc_metadata\\" + npc_metadata.id + ".json", "w") as outfile:
                    outfile.write(json_object)
            # CREATE ENEMY
            else:
                enemy_metadata = NPCMetadata()
                enemy_metadata.id = get_enemy_id()
                enemy_metadata.name = metadata.name
                enemy_metadata.type = metadata.type
                enemy_metadata.brute = metadata.brute
                enemy_metadata.thief = metadata.thief
                is_acute = None
                while is_acute not in ["y", "n"]:
                    is_acute = input("Acute?\n")
                enemy_metadata.acute = is_acute == "y"
                is_obtuse = None
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
                with open("enemy_metadata\\" + enemy_metadata.id + ".json", "w") as outfile:
                    outfile.write(json_object)



# for filename in os.listdir(directory):
#     f = os.path.join(directory, filename)
#     if os.path.isfile(f):
#         period_index = filename.rfind(".")
#         if filename[period_index+1:period_index+4] == "png":
#             card_name = filename[0:period_index]
#             metadata = Metadata()
#             image = Image.open('PNG_OUTPUT\\' + card_name + '.png')
#             cropped = image
#             if "_tier2" in card_name:
#                 old_card_name = card_name.replace("tier2", "")
#                 shutil.copyfile(os.path.join("D:\\Yonder\\Assets\\Enemies\\METADATA_OUTPUT\\" + old_card_name + ".json"), os.path.join("D:\\Yonder\\Assets\\Enemies\\METADATA_OUTPUT\\" + card_name + ".json"))
#                 print("copied " + old_card_name + " into " + card_name)
#                 continue
#             elif os.path.isfile(os.path.join("D:\\Yonder\\Assets\\Enemies\\METADATA_OUTPUT\\" + card_name + ".json")):
#                 print("skipping " + card_name)
#                 continue
#             with open('JSON_OUTPUT\\' + card_name + '.json', 'r') as openfile:
#                 json_object = json.load(openfile)
#                 width = json_object["frame_width"]
#                 height = json_object["frame_height"]
#                 x = json_object["breathing_coords"][0]["x"]
#                 y = json_object["breathing_coords"][0]["y"]
#                 cropped = image.crop((x, y, x+width, y+width))
#                 cropped = cropped.resize((width*50, height*50), Image.NEAREST)
#                 cropped.show()
#             print("==========  " + card_name + "  ==========")
#             if card_name in names:
#                 print("Real Name:")
#                 print(names[card_name])
#             metadata.name = input("NAME:\n").title()
#             if metadata.name == "Removed":
#                 metadata.type = "removed"
#                 print("> type automatically set to 'removed'")
#             if card_name[0] == "f" and metadata.name != "Faction":
#                 metadata.faction = int(card_name[1])
#             if metadata.name == "Faction":
#                 print("> removed faction")
#                 metadata.name = input("NAME:\n").title()
#             if metadata.faction == None:
#                 metadata.type = input("TYPE: (dungeon, cavern, forest, frost, mech, nether, divine, assassin, shadow, desert, arcane, removed, none)\n").lower()
#                 while not (metadata.type in ["dungeon", "cavern", "forest", "frost", "mech", "nether", "divine", "assassin", "shadow", "desert", "arcane", "removed", "none"]):
#                     print("Invalid type")
#                     metadata.type = input("TYPE: (dungeon, cavern, forest, frost, mech, nether, divine, assassin, shadow, desert, arcane, removed, none)\n").lower()
#             while metadata.brute == None:
#                 set = input("BRUTE?\n").title()
#                 if set == "True":
#                     metadata.brute = True
#                 if set == "False":
#                     metadata.brute = False
#             if (metadata.brute == False):
#                 while metadata.thief == None:
#                     set = input("THIEF?\n").title()
#                     if set == "True":
#                         metadata.thief = True
#                     if set == "False":
#                         metadata.thief = False
#                 else:
#                     metadata.theif = False
#             # while metadata.boss == None:
#             #     set = input("BOSS?\n").title()
#             #     if set == "True":
#             #         metadata.boss = True
#             #     if set == "False":
#             #         metadata.boss = False
#             print("=========================================")
#             json_text = {
#                 "name": metadata.name,
#                 "description": metadata.description,
#                 "faction": metadata.faction,
#                 "type": metadata.type,
#                 "brute": metadata.brute,
#                 "thief": metadata.thief
#             }
#             json_object = json.dumps(json_text, indent=4)
#             with open("METADATA_OUTPUT\\" + card_name + ".json", "w") as outfile:
#                 outfile.write(json_object)

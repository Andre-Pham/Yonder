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

absolute = os.path.dirname(os.path.realpath(__file__))
all_removed = []

directory = os.path.join(absolute, "OLD_METADATA_OUTPUT")
all_filenames = os.listdir(directory)
all_filenames.sort() # Just for consistency between different Mac/Win
for filename in all_filenames:
    file_dir = os.path.join(directory, filename)
    if os.path.isfile(file_dir):
        period_index = filename.rfind(".")
        card_name = filename[0:period_index]
        with open(file_dir, "r") as metadata_file:
            metadata_json = json.load(metadata_file)
            is_removed = metadata_json["name"].lower() == "removed" or metadata_json["type"].lower() == "removed"
            if is_removed:
                all_removed.append(card_name)
                frame_dir = os.path.join(absolute, "OLD_JSON_OUTPUT", card_name + ".json")
                metadata_dir = os.path.join(absolute, "OLD_METADATA_OUTPUT", card_name + ".json")
                png_dir = os.path.join(absolute, "OLD_PNG_OUTPUT", card_name + ".png")
                os.remove(frame_dir)
                os.remove(metadata_dir)
                os.remove(png_dir)

file_output = "\n".join(all_removed)
dir = os.path.join(absolute, "removed.txt")
file = open(dir, "w")
file.write(file_output)
file.close()

print("FILTERED OUT: " + str(len(all_removed)))
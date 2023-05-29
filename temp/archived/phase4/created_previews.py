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
directory = os.path.join(absolute, "..", "phase3", "OLD_METADATA_OUTPUT")
png_directory = os.path.join(absolute, "..", "phase3", "OLD_PNG_OUTPUT")
frame_directory = os.path.join(absolute, "..", "phase3", "OLD_JSON_OUTPUT")
all_filenames = os.listdir(directory)
all_filenames.sort() # Just for consistency between different Mac/Win
for filename in all_filenames:
    file_dir = os.path.join(directory, filename)
    if os.path.isfile(file_dir):
        period_index = filename.rfind(".")
        card_name = filename[0:period_index]
        print(card_name)
        with open(file_dir, "r") as metadata_file:
            metadata_json = json.load(metadata_file)

            image = Image.open(os.path.join(png_directory, card_name + ".png"))
            with open(os.path.join(frame_directory, card_name + ".json"), "r") as json_file:
                json_object = json.load(json_file)
                width = json_object["frame_width"]
                height = json_object["frame_height"]
                x = json_object["breathing_coords"][0]["x"]
                y = json_object["breathing_coords"][0]["y"]
                cropped = image.crop((x, y, x+width, y+width))
                cropped = cropped.resize((width*50, height*50), Image.NEAREST)
                new_dir = os.path.join(absolute, "previews", card_name + ".png")
                cropped.save(new_dir)
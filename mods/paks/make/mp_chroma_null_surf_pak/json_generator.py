import os
import json

BASE_TEXTURE_PATH = "texture/world/floors/"
BASE_MATERIAL_PATH = "material/world/floors/"
OUTPUT_FOLDER = "generated_materials"


def generate_material_json(base_dir):
    os.makedirs(OUTPUT_FOLDER, exist_ok=True)

    for root, _, files in os.walk(base_dir):
        for file in files:
            if not file.lower().endswith(".png"):
                continue
            if "_col" not in file.lower():
                continue

            name_no_ext = os.path.splitext(file)[0]
            base_name = name_no_ext.replace("_col", "")

            output_path = os.path.join(OUTPUT_FOLDER, base_name + "_wld.json")

            data = {
                "name": f"world/floors/{base_name}",
                "width": 512,
                "height": 512,
                "depth": 0,
                "glueFlags": "0x72000000",
                "glueFlags2": "0x100000",
                "blendStates": [
                    "0xF0138004",
                    "0xF0138004",
                    "0xF0138004",
                    "0x138004",
                    "0x0",
                    "0x0",
                    "0x0",
                    "0x0"
                ],
                "blendStateMask": "0x4",
                "depthStencilFlags": "0x17",
                "rasterizerFlags": "0x6",
                "uberBufferFlags": "0x0",
                "features": "0x40D33E8F",
                "samplers": "0x1D0300",
                "surfaceProp": "tile",
                "surfaceProp2": "",
                "shaderType": "wld",
                "shaderSet": "0x52BE72F84BF38F30",

                "$textures": {
                    "0": f"{BASE_TEXTURE_PATH}{name_no_ext}.rpak",
                    "1": "texture/world/floors/floor_linoleum_white_nml.rpak",
                    "2": "texture/defaults/default_gls.rpak",
                    "3": "texture/defaults/default_spc.rpak"
                },

                "$textureTypes": {
                    "0": "albedoTexture",
                    "1": "normalTexture",
                    "2": "glossTexture",
                    "3": "specTexture"
                },

                "$depthShadowMaterial": "0x7EB9E904C412E925",
                "$depthPrepassMaterial": "0xADAA49F661747114",
                "$depthVSMMaterial": "0x89C878A01CE5CCF8",
                "$depthShadowTightMaterial": "0x0",
                "$colpassMaterial": "material/world/floors/floor_linoleum_white_colpass_wld.rpak",
                "$textureAnimation": "0x0"
            }

            with open(output_path, "w", encoding="utf-8") as f:
                json.dump(data, f, indent=4)

            print(f"Generated: {output_path}")


if __name__ == "__main__":
    folder = input("Enter directory to scan: ").strip('"')
    generate_material_json(folder)

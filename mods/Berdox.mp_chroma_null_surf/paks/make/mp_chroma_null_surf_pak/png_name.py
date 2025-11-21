import os

OUTPUT_FILE = "col_names.txt"

def collect_col_names(base_dir):
    collected = []

    for root, _, files in os.walk(base_dir):
        for file in files:
            lower = file.lower()

            if lower.endswith(".png") and "_col" in lower:
                name_no_ext = os.path.splitext(file)[0]
                cleaned = name_no_ext.replace("_col", "")
                collected.append(cleaned)

    # Write list
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        for name in collected:
            f.write(name + "\n")

    print(f"Saved {len(collected)} names to {OUTPUT_FILE}")


if __name__ == "__main__":
    folder = input("Enter directory to scan: ").strip('"')
    collect_col_names(folder)

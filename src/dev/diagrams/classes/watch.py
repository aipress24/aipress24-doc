import os

from watchgod import watch

for changes in watch("."):
    print(changes)
    for change in changes:
        filename = change[1]
        if filename.endswith(".puml"):
            cmd = f"plantuml {filename}"
            print(f"Running {cmd}...")
            os.system(cmd)
            print("... done")

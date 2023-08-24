import pandas as pd
from pathlib import Path

root = Path(__file__).parent.parent

# list event.tsv

events_tsv = root.glob("sub-*/func/*task-*_events.tsv")

for event in events_tsv:
    df = pd.read_csv(event, sep="\t")
    # remove rows with "n/a" in the "onset" column
    df = df[df["onset"] != "n/a"]
    # save
    df.to_csv(event, sep="\t", index=False)
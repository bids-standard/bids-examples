import pandas as pd
from pathlib import Path
from rich import print

root = Path(__file__).parent.parent

# list event.tsv

events_tsv = root.glob("sub-*/func/*task-*_events.tsv")

for event in events_tsv:
    # replace "n/a" with "NaN"
    df = pd.read_csv(event, sep="\t", na_values="n/a")
    print(df)
    # # remove rows with NaN in the "onset" column
    df = df.dropna(subset=["onset"])
    # save replacing NaN with "n/a" and with 3 decimal places
    df.to_csv(event, sep="\t", na_rep="n/a", float_format="%.3f", index=False)
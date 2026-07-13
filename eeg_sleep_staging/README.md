# Parallel sleep staging annotations

This synthetic EEG example shows manual and automated sleep staging in one
`events.tsv` file.

Each annotation is stored as a separate row. Rows may therefore overlap when
two scorers or methods label the same interval. This avoids forcing annotations
with different coverage or time resolution into one wide table.

The HED sidecar keeps overlapping annotations in separate groups. In other
words, two labels with the same onset are still treated as two annotations.

The example includes:

- manual consensus and automated labels for the same 30-second epochs;
- a disagreement between the two sources;
- explicit R&K stage 3 and stage 4 labels mapped to N3;
- movement and unscored intervals kept separate from sleep stages;
- channels used for scoring; and
- confidence values where the automated method provides them.

The data are synthetic. The empty EDF file is included only to provide a
lightweight BIDS structure.

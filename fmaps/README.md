# EPI fieldmap metadata test

The total readout time is necessary to translate between deflections
in the magnetic field and displacements induced by susceptibility artifacts.

There are several ways to calculate the total readout time, given a BIDS
dataset, and this example exists to demonstrate them.
In particular this dataset SHOULD NOT emit `TOTAL_READOUT_TIME_MUST_DEFINE` errors.

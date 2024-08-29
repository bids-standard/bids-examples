# fMRS in Pain

Contact: <jea4025@med.cornell.edu>

Data availability: <https://www.nitrc.org/projects/fmrs_2020/>

Publications:

- <https://doi.org/10.1038/s41598-020-76263-3>

## Dataset Description

This dataset includes anatomical and functional MRS data for 15 participants (see demographics in participants.tsv).
The data were collected using a 3T Philips Achieva scanner (Best, Netherlands) with a
single-channel transmit-receive head coil, using the PRESS sequence.

Baseline: TE/TR = 22/4000 ms, NSA = 32, scan time = 3:12 min, and 16 non-water suppressed spectra were acquired.

Functional: TE/TR = 22/4000 ms, NSA = 16, scan time = 22:40 min; ACC voxel size = 30 × 25 × 15 mm<sup>3</sup>, second-order shimming, 16-step phase cycle with water suppression using the excitation option – a Philips variant of CHESS; a non-water suppressed acquisition preceded each complete phase-cycle for absolute metabolite quantification and water signal monitoring.

The during the functional MRS scan participants had capsaicin cream on the forearm for the entire duration, and heat was applied for 4 min after 8 min of data collection, which corresponds to shots 128-192.

## Stimulation Paradigm

The pain model consisted of the application of 0.075% topical capsaicin and heat activation via a thermo-pad on the volar surface of the right forearm (~8 × 5 cm<sup>2</sup>). Capsaicin was applied immediately after baseline acquisition of MRS alongside a neutral thermo-pad without removing the participants from the scanner. The thermo-pad was fixed to the skin and covered the area where capsaicin was applied, and was activated by the influx of hot water via plastic tubing conveyed via the penetration panel. A non-heat conducting flexible brace was used to fasten the position of the thermo-pad. The functional MRS followed by acquiring 16 shots every 1.08 min (total = 22.4 min). After 9 min, the thermo-pad was activated by circulating heated water to reach a temperature of approximately 41°C at the forearm. Capsaicin was heat activated for a period of 4.4 min. Functional MRS was acquired continuously during heat application and for the reminder of the scan after the heat was removed.

Individual FIDs were pre-processed, which included: 0 order phase correction, eddy current correction, frequency alignment, and quality assurance was performed in MATLAB.

## Acknowledgment

If using these data, please cite Archibald J., MacMillan EL., Graf C., Kozlowsk P., Laule C., Kramer J.L.K. "Metabolite activity in the anterior cingulate cortex during a painful stimulus using functional MRS". Sci Reports. 10:19218  (2020). doi:10.1038/s41598-020-76263-3.

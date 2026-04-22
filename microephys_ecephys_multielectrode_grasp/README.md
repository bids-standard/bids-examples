# Reach-to-Grasp Multi-electrode Array Recordings (BEP032 Example)

Example dataset demonstrating the **BIDS Extension Proposal for Microelectrode Electrophysiology (BEP032)** format for multi-electrode array recordings from non-human primates.

## Source

Converted from the Reach-to-Grasp dataset: https://gin.g-node.org/INT/multielectrode_grasp
DOI: [10.12751/g-node.f83565](https://doi.org/10.12751/g-node.f83565)

## Electrode Configuration Notes

The Utah arrays have two Pt/Au reference wires physically separate from the 96 recording electrodes, placed under the dura rather than at grid positions.

- **sub-i:** Standard configuration with corners (1, 10, 91, 100) unconnected. Reference wires assigned to corners 1 and 100.
- **sub-l:** Custom configuration with all corners connected. Unconnected positions at 80, 90, 93, 95. Reference wire coordinates set to n/a (no available grid positions).

## Reference

Brochier et al. (2018). Massively parallel recordings in macaque motor cortex during an instructed delayed reach-to-grasp task. *Scientific Data*, 5, 180055. https://doi.org/10.1038/sdata.2018.55

## License

[CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/)

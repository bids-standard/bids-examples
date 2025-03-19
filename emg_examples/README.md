# EMG BIDS Examples Dataset

This dataset contains examples of different EMG recording setups to demonstrate various ways of documenting EMG data according to the BIDS specification. Each example includes metadata files in BIDS format describing the recording setup, electrode placement, and other relevant information. The examples follow a discussion of the [EMG metadata fields](https://docs.google.com/document/d/1s4SbStsm2VXqFbHEVF6Og7BCtjsRUDhzcZj9LO07r6Q) during the development of the BIDS-EMG extension. Each subject represents a different EMG recording configuration, showcasing different aspects of EMG metadata documentation.

## Dataset Structure

The dataset includes 6 example subjects showing different EMG recording configurations:

```shell
.
├── dataset_description.json
├── participants.json 
├── participants.tsv
├── sub-s1CustomBipolar/
├── sub-s2IndependentMod/
├── sub-s3CustomBipolarFace/
├── sub-s5TwoHDsEMG/
├── sub-s6MutliBodyParts/
└── sub-s8concurrentIndepndentUnits/
```

## Example Descriptions

### sub-s1CustomBipolar
Demonstrates documentation of a custom-made bipolar EMG system recording from flexors of the lower arm. Shows how to document:
- Single channel bipolar montage
- Precise electrode placement using anatomical landmarks
- Inter-electrode distance specifications

### sub-s2IndependentMod 
Shows documentation for commercial bipolar EMG modules recording from multiple muscles. Highlights:
- Multiple independent bipolar channels
- Wireless sensors
- Documentation of multiple target muscles

### sub-s3CustomBipolarFace
Illustrates recording from facial muscles with:
- Many-to-many mapping between sensors and muscles
- Functional localization for electrode placement
- Recording from muscles without bony landmarks

### sub-s5TwoHDsEMG
Demonstrates high-density EMG grid recordings from two body parts:
- Multiple HD-EMG grids
- Grid placement documentation
- Channel grouping specifications

### sub-s6MutliBodyParts
Shows recording from multiple body parts with:
- Different types of electrodes
- Multiple amplifier configurations
- Complex electrode placement schemes

### sub-s8concurrentIndepndentUnits
Illustrates concurrent recording with:
- Multiple independent recording units
- Different sampling rates
- Synchronization between units

## Purpose

This dataset serves as a reference implementation showing how different EMG recording setups can be documented in BIDS format. Each example demonstrates specific aspects of EMG metadata documentation including:

- Electrode placement methods
- Montage types
- Channel configurations
- Target muscle documentation
- Recording system specifications
- Spatial relationships between electrodes

## Usage

These examples can be used as templates when converting EMG data to BIDS format. The metadata fields and documentation approaches shown here cover common EMG recording scenarios.
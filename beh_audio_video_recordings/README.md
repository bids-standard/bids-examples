# Behavioral audio/video recordings

This dataset provides a minimal example of behavioral **audio** and **video** recordings stored in the `beh/` directory.

It is intended to accompany the proposal to add audio/video recordings to behavioral experiments (see [bids-specification PR #2231](https://github.com/bids-standard/bids-specification/pull/2231)).

Note: media files are small placeholder files for example purposes. In a real dataset, these would be actual media files containing the recorded data.

## Dataset description

This dataset contains behavioral audio and video recordings from 2 participants performing various tasks:

### Subject 01

- **Speech task**: audio recording of participant describing a picture (WAV format) with accompanying events/annotations
- **Resting state**: video recording of participant sitting comfortably (MP4 format)

### Subject 02

- **Stroop task**: multiple simultaneous video recordings from different angles (face close-up and room view)
- **Vocalization task**: two runs of audio recordings (FLAC format) with accompanying events/annotations

## Key features demonstrated

1. **Audio file formats**: WAV and FLAC
2. **Video file formats**: MP4
3. **Multiple recording angles**: using the `recording` entity to distinguish simultaneous recordings
4. **Multiple runs**: using the `run` entity for repeated tasks
5. **Metadata**: JSON sidecar files with device information and audio/video technical specifications
6. **Events files**: annotations for the speech/vocalization tasks with timing information
7. **Timing alignment**: `scans.tsv` files for synchronization across recordings

## Validation

When validated with a schema that includes the PR #2231 rules, this dataset should produce no errors (warnings for recommended metadata keys may remain).

## Privacy considerations

When working with real audio and video recordings of human subjects, ensure compliance with applicable privacy regulations (HIPAA, GDPR, etc.) as these files often contain personally identifiable information.

# Behavioral audio/video recordings

This dataset provides a minimal example of behavioral **audio**, **video**, **audiovideo**, and **image** recordings stored in the `beh/` directory.

It is intended to accompany the proposal to add audio/video recordings to behavioral experiments (see [bids-specification PR #2231](https://github.com/bids-standard/bids-specification/pull/2231)).

Note: media files are small placeholder files for example purposes. In a real dataset, these would be actual media files containing the recorded data.

## Dataset description

This dataset contains behavioral audio and video recordings from 2 participants performing various tasks:

### Subject 01

- **Speech task**: audio recording of participant describing a picture (WAV format) with accompanying events/annotations, plus a reference photo of the stimulus image
- **Resting state**: video recording of participant sitting comfortably (MP4 format)
- **Interview task**: combined audiovideo recording of participant being interviewed (MP4 format)

### Subject 02

- **Stroop task**: multiple simultaneous video recordings from different angles (face close-up and room view), plus a combined audiovideo recording with verbal responses, and a setup verification photo
- **Vocalization task**: two runs of audio recordings (FLAC format) with accompanying events/annotations

## Key features demonstrated

1. **Audio file formats**: WAV and FLAC
2. **Video file formats**: MP4
3. **Audiovideo format**: MP4 with combined audio and video streams
4. **Photo format**: JPG still images
5. **Multiple recording angles**: using the `recording` entity to distinguish simultaneous recordings
6. **Multiple runs**: using the `run` entity for repeated tasks
7. **Metadata**: JSON sidecar files with device information and audio/video/image technical specifications
8. **Events files**: annotations for the speech/vocalization tasks with timing information
9. **Timing alignment**: `scans.tsv` files for synchronization across recordings

## Validation

When validated with a schema that includes the PR #2231 rules, this dataset should produce no errors (warnings for recommended metadata keys may remain).

To test:

1. Clone the BIDS specification repository:

    ```bash
    git clone https://github.com/bids-standard/bids-specification.git
    cd bids-specification
    ```

2. Check out the branch that includes the audio/video recording proposal (until merged):

    ```bash
    git checkout audio-video-clean
    ```

3. Install the BIDS Validator (if not already installed):

    ```bash
    npm install -g bids-validator
    ```

4. Build the updated schema:

    ```bash
    bst -v export --schema src/schema --output src/schema.json
    ```

5. Install bids-validator-deno:

    ```bash
    pip install bids-validator-deno
    ```

5. Run the validator on this dataset with the updated schema:
    ```bash
    bids-validator-deno -s file:///path/to//bids-specification/src/schema.json /path/to/bids-examples/beh_audio_video_recordings
    ```

## Privacy considerations

When working with real audio and video recordings of human subjects, ensure compliance with applicable privacy regulations (HIPAA, GDPR, etc.) as these files often contain personally identifiable information.

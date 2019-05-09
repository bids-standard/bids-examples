import logging
from datetime import timedelta

Logger = logging.getLogger(__name__)

"""
Plugin to eegBidsCreator
Extract task and session from subject id and performs 
various tests
"""


def RecordingEP(recording, argv=None, params=None):
    """
    Reads subject id and extract task and acquisition from it
    Checks if subject and task id are valid, and if recording
    is less than 1 hour.

    Returns 0 if sucessfull, or an code in [1-9] if errors has 
    been found
    """

    Logger.info('Running RecordingEP')
    Logger.debug("Surbject Id: " + recording.SubjectInfo.ID)
    sId = recording.SubjectInfo.ID.split(' - ')[0].split('_')

    if len(sId) < 4:
        Logger.error("Malformed subject Id: " + recording.SubjectInfo.ID)
        return 1

    if sId[0][0:3] != "COF":
        Logger.error("Not a COFITAGE file")
        return 1

    try:
        subNo = int(sId[0][3:])
    except Exception:
        Logger.error("Unable to get subject Id from line " + sId[0])
        return 2
    if subNo >= 1000:
        Logger.warning("Subject {} number too large".format(sId[0]))
        recording.SubjectInfo.ID = sId[0]
    else:
        recording.SubjectInfo.ID = "COF{:03d}".format(subNo)

    task = sId[1]

    if task not in ["HN", "BL", "ECG"]:
        Logger.error("Task {} not a valid COFITAGE task".format(task))
        return 2

    if recording.GetStartTime():
        ses = recording.GetStartTime().strftime("%d%m%y")
        acq = recording.GetStartTime().strftime("T%H%M")
        if recording.GetStopTime():
            dt = (recording.GetStopTime() - recording.GetStartTime())
            if dt < timedelta(hours=1):
                Logger.error("Recording duration {} is too short".format(dt))
                return 3
    else:
        Logger.warning("Unable to get start time from record")
        ses = sId[2]
        acq = sId[3]

    ses = ""
    recording.SetId(subject=recording.SubjectInfo.ID, session=ses, 
                    task=task, acquisition=acq)
    return 0


def ChannelsEP(record, argv=None, params=None):
    """
    Adapt name of channels to ones compatible with Fasst
    Drops channels that are not compatible

    Returns 0 if sucessfull, or an code in [1-9] if errors has 
    been found
    """

    Logger.info('Running ChannelsEP')
    i = 0
    channels = record.Channels
    while True:
        if i >= len(channels): break
        ch_type = channels[i].GetType()
        if channels[i].GetName() == 'EKG':
            channels[i].SetType('ECG')
        elif 'EOG' in ch_type:
            channels[i].SetType('EOG')
        elif 'EMG' in ch_type:
            channels[i].SetType('EMG')
        elif 'ECG' in ch_type:
            channels[i].SetType('ECG')
        elif 'EEG' in ch_type:
            channels[i].SetType('EEG')
        else:
            Logger.warning('Dropping channel {} of type {}'
                           .format(channels[i].GetName(), ch_type))
            del channels[i]
            continue
        i += 1
    record.InitChannels()
    return 0


def EventsEP(record, argv=None, params=None):
    """
    Checks if recording contains LIGHTS-OFF and LIGHTS-ON
    events. 

    Returns 0 if sucessfull, or an code in [1-9] if errors has
    been found
    """

    Logger.info('Running EventsEP')

    off_count = 0
    on_count = 0

    for ev in record.Events:
        if ev.GetName() == "LIGHTS-OFF": off_count += 1
        if ev.GetName() == "LIGHTS-ON": on_count += 1

    if off_count == 0 or on_count == 0:
        if off_count == 0:
            Logger.error("Missing LIGHTS-OFF marker")
        if on_count == 0:
            Logger.error("Missing LIGHTS-ON marker")
        return 1
    if off_count > 1 or on_count > 1:
        Logger.error("Multiple LIGHTS events found")
        return 2

    return 0

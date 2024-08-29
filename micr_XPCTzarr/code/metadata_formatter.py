import urllib.request
import json

"""
You may use the following command to prepare a Python 3.8+ environment for the download of the dataset: `pip install -r metadata_formatter_reqs.txt`
"""

# The following metadata file can be downloaded from https://human-organ-atlas.esrf.eu/datasets/572252538
metadata_txt_file_uri = 'https://ids.esrf.fr/ids/getData?sessionId=182d0a3b-de3b-4602-8caf-9bd91dc5b0e5&datafileIds=572252539' # This URI expires quite often

req = urllib.request.urlopen(metadata_txt_file_uri)

json_dict = {}

for line in urllib.request.urlopen(metadata_txt_file_uri):
    text = line.decode('utf-8')
    if text.startswith('#') or text == '\r\n':
        pass
    else:
        s = text.replace('\t','').replace('\r\n','').replace('"', '').replace('N.A.', 'n/a').split('=')
        
        try:
            s[1] = int(s[1])
        except:
            try:
                s[1] = float(s[1])
            except:
                pass
        json_dict[s[0]] = s[1]
json_obj = json.dumps(json_dict)
print(json_obj)

"""
The metadata has been split into several files:
  - micr_XPCTzarr/samples.json
  - micr_XPCTzarr/sub-LADAF-2020-31/sub-LADAF-2020-31_sessions.tsv
  - micr_XPCTzarr/sub-LADAF-2020-31/ses-01/micr/sub-LADAF-2020-31_ses-01_sample-brain_XPCT.json
Note that some fields are redundant. 
"""
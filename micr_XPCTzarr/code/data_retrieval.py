from pathlib import Path
import zarr.convenience
import dask.array
import ome_zarr, ome_zarr.io, ome_zarr.writer
from numcodecs import Blosc, Delta
import time

"""
You may use the following command to prepare a Python 3.8+ environment for the download of the dataset: `pip install -r data_retrieval_reqs.txt`
"""

data_path = Path("../sub-LADAF-2020-31/ses-01/micr/") # path to session
data_path.mkdir(exist_ok=True) # create directory

# short utility function
def zarr_array(url,selector):
    print('Retrieving data from', url)
    n5_store = zarr.N5FSStore(url)
    root = zarr.group(store=n5_store)
    return dask.array.from_zarr(root[selector])

dataset_full = zarr_array("gs://ucl-hip-ct-35a68e99feaae8932b1d44da0358940b/LADAF-2020-31/brain/25.08um_complete-organ_bm05/","s0") # get a dask.array.Array that points to the whole N5 dataset

# default filters and compressors made the script crash; the ones below work:
filters = [Delta(dtype='i4')]
compressor = Blosc(cname='zstd', clevel=1, shuffle=Blosc.SHUFFLE)

path_roi = data_path / "sub-LADAF-2020-31_ses-01_sample-brain_XPCT.ome.zarr" # full name of the dataset following BIDS specification

print('Writing in', str(path_roi))

tic = time.time()

store = ome_zarr.io.parse_url(path_roi,mode="a").store # NB: `mode="a"` should allow overwrite but it does not at the moment, see https://github.com/ome/ome-zarr-py/issues/376
root = zarr.group(store=store)
ome_zarr.writer.write_image(image=dataset_full,
                            group=root,
                            scaler=None,
                            axes=[
                                {
                                    "name": "z",
                                    "type": "space",
                                    "units": "micrometer" # voxel size is an isotropic 25.08 um
                                },
                                {
                                    "name": "y",
                                    "type": "space",
                                    "units": "micrometer" # voxel size is an isotropic 25.08 um
                                },
                                {
                                    "name": "x",
                                    "type": "space",
                                    "units": "micrometer" # voxel size is an isotropic 25.08 um
                                }
                            ], # axis order of the dataset following BIDS specification
                            coordinate_transformations=[
                                [
                                    {
                                        "scale": [
                                            25.08,
                                            25.08,
                                            25.08 
                                        ], # voxel size is an isotropic 25.08 um
                                        "type": "scale"
                                    }
                                ] 
                            ],
                            storage_options=dict(
                                chunks=(512,512,512), # this chunk size may be altered depending on someone's needs
                                filters=filters, # default filters made the script crash
                                compressor=compressor # default compressors made the script crash
                            )
                        )

toc = time.time()

print('Writing completed in', (toc - tic)/60, 'min!')
## Cloud Storage - Uploading and Downloading Objects



| Scenario                   | Solution                                                                                                  |
|----------------------------|-----------------------------------------------------------------------------------------------------------|
| Simple Upload              | Small files.  No object metadata                                                                          |
| Multipart upload           | Small files.  Object metadata is generated(for obvious reasons)                                           |
| Resumbable upload          |  Larger files.  Recommened for must use cases                                                             |
| Streaming transfers        | Upload an object of unknown size(streaming in practice involves file sizes of unknown size)               |
| Parallel composite uploads | File divided up to 32 chunks and uploaded in parallel.  Faster given enough bandwidth and computing power |
| Simple download            | Downloading objects to a desitnation                                                                      |
| Streaming download         | Downloading data to a process                                                                             |
| Sliced object download     | Slice and download large objects                                                                          |
|                            |                                                                                                           |

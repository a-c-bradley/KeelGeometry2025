# KeelGeometry2025
Code supporting Eilers and Bradley, 2025


Two datasets are necessary for this, both available from NSDIC:

Submarine Upward Looking Sonar Ice Draft Profile Data and Statistics, Version 1
Data set id:
G01360
DOI: 10.7265/N54Q7RWK

EASE-Grid Sea Ice Age, Version 4
Data set id:
NSIDC-0611
DOI: 10.5067/UTAV7490FEPB

Run scripts in the following order:

SubmarineDataReader
FeatureDetectionAndShapeClassification
CompileAllFeatures
FindeIceAgeEstimates
TableOfDistributions


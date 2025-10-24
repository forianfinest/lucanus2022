######AS EXPLAINED IN: https://ipyrad.readthedocs.io/en/master/API-analysis/cookbook-pca.html

import ipyrad.analysis as ipa
import pandas as pd
import toyplot

data = "all_outputs_6.snps.hdf5"
imap = {
    "HC": ["LMHC1", "LMHC10", "LMHC11", "LMHC12", "LMHC17", "LMHC18", "LMHC19", "LMHC2", "LMHC20", "LMHC21", "LMHC22", "LMHC23", "LMHC24", "LMHC25", "LMHC26", "LMHC27", "LMHC29", "LMHC3", "LMHC31", "LMHC32", "LMHC33", "LMHC34", "LMHC35", "LMHC36", "LMHC37", "LMHC5", "LMHC6", "LMHC8", "LMHC9"],
    "ML": ["LMML10", "LMML11", "LMML12", "LMML13", "LMML17", "LMML18", "LMML19", "LMML20", "LMML21", "LMML22", "LMML23", "LMML24", "LMML25", "LMML26", "LMML27", "LMML28", "LMML30", "LMML31", "LMML32", "LMML33", "LMML34", "LMML35", "LMML37", "LMML38", "LMML39", "LMML43"],
    "NT": ["LMNT02", "LMNT03", "LMNT04", "LMNT05", "LMNT06", "LMNT07", "LMNT08", "LMNT09", "LMNT10", "LMNT11", "LMNT12", "LMNT13", "LMNT14", "LMNT15", "LMNT16", "LMNT17", "LMNT18", "LMNT19", "LMNT20", "LMNT21", "LMNT22", "LMNT23", "LMNT24", "LMNT25", "LMNT26", "LMNT27", "Lwc14", "Lwc15", "Lwc17", "Lwc2", "Lwc6", "Lwc8"],}
minmap = {i: 0.5 for i in imap}
pca3 = ipa.pca(
    data=data,
    imap=imap,
    minmap=minmap,
    mincov=0.5,
    impute_method=3,
)
pca3.run(nreplicates=100, seed=123)
pca3.draw(0, 2);
pca3.draw(outfile="100replicateskmeanspca.pdf")

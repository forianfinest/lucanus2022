####AS IN: https://ipyrad.readthedocs.io/en/master/API-analysis/cookbook-structure.html


import ipyrad.analysis as ipa
import toyplot
data="all_output_6.snps.hdf5"
struct = ipa.structure(
    name="test",
    data=data,
    imap=imap,
    minmap=minmap,
    mincov=0.9,
)
struct.mainparams.burnin = 100000
struct.mainparams.numreps = 300000
struct.run(nreps=10, kpop=[2, 3, 4, 5], auto=True)
etable = struct.get_evanno_table([2, 3, 4, 5])
etable
canvas = toyplot.Canvas(width=400, height=300)
axes = canvas.cartesian(ylabel="estLnProbMean")
axes.plot(etable.estLnProbMean * -1, color="darkred", marker="o")
axes.y.spine.style = {"stroke": "darkred"}
axes = axes.share("x", ylabel="deltaK", ymax=etable.deltaK.max() + etable.deltaK.max() * .25)
axes.plot(etable.deltaK, color="steelblue", marker="o");
axes.y.spine.style = {"stroke": "steelblue"}
axes.x.ticks.locator = toyplot.locator.Explicit(range(len(etable.index)), etable.index)
axes.x.label.text = "K (N ancestral populations)"
toyplot.pdf.render(canvas, "probstructure.pdf")
k = 3
table = struct.get_clumpp_table(k)
import itertools
onames = list(itertools.chain(*imap.values()))
table = table.loc[onames]
canvas = toyplot.Canvas(width=500, height=250)
axes = canvas.cartesian(bounds=("10%", "90%", "10%", "45%"))
axes.bars(table)
<toyplot.mark.BarMagnitudes object at 0x7f4045143e20>
ticklabels = [i for i in table.index.tolist()]
axes.x.ticks.locator = toyplot.locator.Explicit(labels=ticklabels)
axes.x.ticks.labels.angle = -60
axes.x.ticks.show = True
axes.x.ticks.labels.offset = 10
axes.x.ticks.labels.style = {"font-size": "6px"}
toyplot.pdf.render(canvas, "3kstacksstruct.pdf")


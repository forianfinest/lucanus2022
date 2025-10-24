###SCRIPTS FOR BOOTSTRAPPING

###ORIGINALS FROM: https://speciationgenomics.github.io/fastsimcoal2/

for i in {1..100}
do
mkdir bs$i
cp easySFS.py ML.txt bs$i"/"
cd bs$i
cat ../header > $PREFIX.bs.$i.vcf
for r in {1..100}
do
cat `shuf -n1 -e ../$PREFIX.sites.*` >> ${PREFIX}.bs.$i.vcf
done
gzip ${PREFIX}.bs.$i.vcf
./easySFS.py -i ${PREFIX}.bs.$i.vcf.gz -p ML.txt --proj 40 -a
cd output
cd fastsimcoal2
cp ${PREFIX}_MAFpop0.obs  ${PREFIX}.bs.${i}_oneevent_MAFpop0.obs
echo bs$i" ready"
cd ..
cd ..
cd ..
done

# Get all lines with genomic data
zgrep -v "^#" $PREFIX.vcf > $PREFIX.allSites

# Get the header
zgrep "^#" $PREFIX.vcf > header

# get 100 files 


split -l 6667 $PREFIX.allSites $PREFIX.sites.
for i in {1..100}
do
mkdir bs$i
cp easySFS.py ML.txt bs$i"/"
cd bs$i
cat ../header > $PREFIX.bs.$i.vcf
for r in {1..100}
do
cat `shuf -n1 -e ../$PREFIX.sites.*` >> ${PREFIX}.bs.$i.vcf
done
gzip ${PREFIX}.bs.$i.vcf
./easySFS.py -i ${PREFIX}.bs.$i.vcf.gz -p ML.txt --proj 40 -a
cd output
cd fastsimcoal2
cp ${PREFIX}_MAFpop0.obs  ${PREFIX}.bs.${i}_oneevent_MAFpop0.obs
echo bs$i" ready"
cd ..
cd ..
cd ..
done


for bs in {1..100}
do
cd bs$bs
for i in {1..100}
do 
mkdir run$i
cp output/fastsimcoal2/${PREFIX}.bs.${bs}_oneevent_MAFpop0.obs output/fastsimcoal2/${PREFIX}.bs.${bs}_oneevent.est output/fastsimcoal2/${PREFIX}.bs.${bs}_oneevent.tpl run$i"/"
cd run$i
"/Users/dynastes/Desktop/Mattia/fsc27_mac64/fsc2709" -t ${PREFIX}.bs.${bs}_oneevent.tpl -e ${PREFIX}.bs.${bs}_oneevent.est -m -C 10 -n 200000 -L 50 -s0 -M -c 4
cd ..
done
cd ..
done

for bs in {1..100}
do
cd bs$bs
cp output/fastsimcoal2/${PREFIX}.bs.${bs}_oneevent_MAFpop0.obs ${PREFIX}.bs.${bs}_oneevent_MAFpop0.obs
cp output/fastsimcoal2/${PREFIX}.bs.${bs}_oneevent.est ${PREFIX}.bs.${bs}_oneevent.est
cp output/fastsimcoal2/${PREFIX}.bs.${bs}_oneevent.tpl ${PREFIX}.bs.${bs}_oneevent.tpl
cd ..
done

for bs in {1..100}
do
cd bs$bs
"/Users/dynastes/Desktop/Mattia/fsc27_mac64/scripts-2/fsc-selectbestrun.sh"
cd ..
done
cd ..
done

###FOR NT, SOME RUNS WERE PROBLEMATIC BECAUSE OF SIMILAR LIKELYHOOD; THEREFORE

for i in {25, 26, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99}
do
mkdir bs$i 
for e in {1..100}
do
cp /Users/dynastes/Desktop/Mattia/fsc27_mac64/NT_parttest/bs$i/run$e/NT.bs.${i}_oneevent/NT.bs.${i}_oneevent.bestlhoods bs$i/bs.${i}.run${e}.txt
done

##AND WE MANUALLy CHECKED WHICH RUN WAS THE BEST ACCORDING TO BEST OBSERVED LIKELIHOOD

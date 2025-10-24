 ###ADAPTED FROM: https://speciationgenomics.github.io/fastsimcoal2/
 ###the FSC-BESTRUN.SH SCRIPT IS AVAILABLE AT THE SAME SITE LINKED ABOVE
 
 
 for i in {1..100}
 do
   mkdir run$i
   cp ${PREFIX}.tpl ${PREFIX}.est ${PREFIX}_MAFpop0.obs run$i"/"
   cd run$i
    "fsc2709" -t ${PREFIX}.tpl -e ${PREFIX}.est -m -C 10 -n 200000 -L 50 -s0 -M -c 4
   cd ..
 done



cp ${PREFIX}_MAFpop0.obs ${PREFIX}_maxL_MAFpop0.obs

for iter in {1..100}
do
"fsc2709" -i ${PREFIX}_maxL.par -n 1000000 -m -c 4
 sed -n '2,3p' ${PREFIX}_maxL/${PREFIX}_maxL.lhoods  >> ${PREFIX}.lhoods
done

for i in *.AIC
do
echo -e `basename $i`"\t"`head $i` >> allmodels.AIC
done

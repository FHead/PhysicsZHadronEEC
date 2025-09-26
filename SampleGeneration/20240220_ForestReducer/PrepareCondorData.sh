mkdir -p Log

SubmitFile=SubmitData.condor

echo "Universe              = vanilla" > $SubmitFile
echo "Executable            = /afs/cern.ch/user/c/chenyi/PhysicsWorkspace/HIZHadronEEC/SampleGeneration/20240220_ForestReducer/Condor.sh" >> $SubmitFile
echo "should_transfer_files = NO" >> $SubmitFile
echo "+JobFlavour           = \"microcentury\"" >> $SubmitFile
echo "MY.WantOS             = \"el9\"" >> $SubmitFile
echo >> $SubmitFile

for i in `ls $PWD/Samples/PbPbData/*/*root | Reformat 1 | sed "s/ /,/g" | sed "s/,[,]*$//"`
do
   Base=`basename $i`

   echo "Arguments = PbPbData ${i} $PWD/Output/PbPbData/Reco${Base} Dummy" >> $SubmitFile
   echo "Output    = Log/PbPbData${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/PbPbData${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/PbPbData${Base/.root}.log" >> $SubmitFile
   # echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done

for i in `ls $PWD/Samples/MinBiasData/*root | Reformat 1 | sed "s/ /,/g" | sed "s/,[,]*$//"`
do
   Base=`basename $i`

   echo "Arguments = MinBiasData ${i} $PWD/Output/MinBiasData2Inf/Reco${Base} Dummy" >> $SubmitFile
   echo "Output    = Log/MinBiasData${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/MinBiasData${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/MinBiasData${Base/.root}.log" >> $SubmitFile
   # echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done

for i in `ls $PWD/Samples/PPData/*/*root | Reformat 1 | sed "s/ /,/g" | sed "s/,[,]*$//"`
do
   Base=`basename $i`

   echo "Arguments = PPData ${i} $PWD/Output/PPData/Reco${Base} Dummy" >> $SubmitFile
   echo "Output    = Log/PPData${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/PPData${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/PPData${Base/.root}.log" >> $SubmitFile
   echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done

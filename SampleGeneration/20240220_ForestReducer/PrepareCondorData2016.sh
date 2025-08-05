mkdir -p Log

SubmitFile=SubmitData2016.condor

echo "Universe              = vanilla" > $SubmitFile
echo "Executable            = /afs/cern.ch/user/c/chenyi/PhysicsWorkspace/HIZHadronEEC/SampleGeneration/20240220_ForestReducer/Condor.sh" >> $SubmitFile
echo "should_transfer_files = NO" >> $SubmitFile
echo "+JobFlavour           = \"microcentury\"" >> $SubmitFile
echo "MY.WantOS             = \"el9\"" >> $SubmitFile
echo >> $SubmitFile

for i in `ls $PWD/Samples/PPbData/*/*root | Reformat 25 | sed "s/ /,/g" | sed "s/,[,]*$//"`
do
   Base=`basename $i`

   echo "Arguments = PPbData ${i} $PWD/Output/PPbData/Reco${Base} Dummy" >> $SubmitFile
   echo "Output    = Log/PPbData${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/PPbData${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/PPbData${Base/.root}.log" >> $SubmitFile
   echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done


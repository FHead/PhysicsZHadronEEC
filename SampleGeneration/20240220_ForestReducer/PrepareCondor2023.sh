mkdir -p Log

SubmitFile=Submit.condor

echo "Universe              = vanilla" > $SubmitFile
echo "Executable            = /afs/cern.ch/user/c/chenyi/PhysicsWorkspace/HIZHadronEEC/SampleGeneration/20240220_ForestReducer/Condor.sh" >> $SubmitFile
echo "should_transfer_files = NO" >> $SubmitFile
echo "+JobFlavour           = \"espresso\"" >> $SubmitFile
echo "MY.WantOS             = \"el9\"" >> $SubmitFile
echo >> $SubmitFile

for i in Samples/DYLLMC2023/*root
do
   Base=`basename $i`

   echo "Arguments = EmbeddedMC2023 $PWD/Samples/DYLLMC2023/${Base} $PWD/Output/DYLLMC2023/Reco${Base} $PWD/Output/DYLLMC2023/Gen${Base}" >> $SubmitFile
   echo "Output    = Log/DYLLMC2023${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/DYLLMC2023${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/DYLLMC2023${Base/.root}.log" >> $SubmitFile
   echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done



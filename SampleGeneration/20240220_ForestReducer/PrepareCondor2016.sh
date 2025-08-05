mkdir -p Log

SubmitFile=Submit2016.condor

echo "Universe              = vanilla" > $SubmitFile
echo "Executable            = /afs/cern.ch/user/c/chenyi/PhysicsWorkspace/HIZHadronEEC/SampleGeneration/20240220_ForestReducer/Condor.sh" >> $SubmitFile
echo "should_transfer_files = NO" >> $SubmitFile
echo "+JobFlavour           = \"espresso\"" >> $SubmitFile
echo "MY.WantOS             = \"el9\"" >> $SubmitFile
echo >> $SubmitFile

for i in Samples/PPbMC/*root
do
   Base=`basename $i`

   echo "Arguments = PPbMC $PWD/Samples/PPbMC/${Base} $PWD/Output/PPbMC/Reco${Base} $PWD/Output/PPbMC/Gen${Base}" >> $SubmitFile
   echo "Output    = Log/PPbMC${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/PPbMC${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/PPbMC${Base/.root}.log" >> $SubmitFile
   echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done

for i in Samples/PbPMC/*root
do
   Base=`basename $i`

   echo "Arguments = PPbMC $PWD/Samples/PbPMC/${Base} $PWD/Output/PbPMC/Reco${Base} $PWD/Output/PbPMC/Gen${Base}" >> $SubmitFile
   echo "Output    = Log/PbPMC${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/PbPMC${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/PbPMC${Base/.root}.log" >> $SubmitFile
   echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done


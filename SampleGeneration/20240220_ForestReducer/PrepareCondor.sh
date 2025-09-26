mkdir -p Log

SubmitFile=Submit.condor

echo "Universe              = vanilla" > $SubmitFile
echo "Executable            = /afs/cern.ch/user/c/chenyi/PhysicsWorkspace/HIZHadronEEC/SampleGeneration/20240220_ForestReducer/Condor.sh" >> $SubmitFile
echo "should_transfer_files = NO" >> $SubmitFile
echo "+JobFlavour           = \"espresso\"" >> $SubmitFile
echo "MY.WantOS             = \"el9\"" >> $SubmitFile
echo >> $SubmitFile

for i in Samples/DYLLMC/*root
do
   Base=`basename $i`

   echo "Arguments = EmbeddedMC $PWD/Samples/DYLLMC/${Base} $PWD/Output/DYLLMC/Reco${Base} $PWD/Output/DYLLMC/Gen${Base}" >> $SubmitFile
   echo "Output    = Log/DYLLMC${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/DYLLMC${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/DYLLMC${Base/.root}.log" >> $SubmitFile
   echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done

for i in Samples/MinBiasMC/*root
do
   Base=`basename $i`

   echo "Arguments = HydjetMC $PWD/Samples/MinBiasMC/${Base} $PWD/Output/MinBiasMC/Reco${Base} $PWD/Output/MinBiasMC/Gen${Base}" >> $SubmitFile
   echo "Output    = Log/MinBiasMC${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/MinBiasMC${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/MinBiasMC${Base/.root}.log" >> $SubmitFile
   echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done

for i in Samples/PPMC/*root
do
   Base=`basename $i`

   echo "Arguments = PPMC $PWD/Samples/PPMC/${Base} $PWD/Output/PPMC/Reco${Base} $PWD/Output/PPMC/Gen${Base}" >> $SubmitFile
   echo "Output    = Log/PPMC${Base/.root}.out" >> $SubmitFile
   echo "Error     = Log/PPMC${Base/.root}.out" >> $SubmitFile
   echo "Log       = Log/PPMC${Base/.root}.log" >> $SubmitFile
   echo "Queue" >> $SubmitFile
   echo >> $SubmitFile
done

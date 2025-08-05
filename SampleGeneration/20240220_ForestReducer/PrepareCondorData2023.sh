mkdir -p Log

SubmitFile=SubmitData.condor

echo "Universe              = vanilla" > $SubmitFile
echo "Executable            = /afs/cern.ch/user/c/chenyi/PhysicsWorkspace/HIZHadronEEC/SampleGeneration/20240220_ForestReducer/Condor.sh" >> $SubmitFile
echo "should_transfer_files = NO" >> $SubmitFile
echo "+JobFlavour           = \"microcentury\"" >> $SubmitFile
echo "MY.WantOS             = \"el9\"" >> $SubmitFile
echo >> $SubmitFile

for j in `seq 0 31`
do
   for i in `ls $PWD/Samples/PbPbData2023Base/HIPhysicsRawPrime${j}/*/*/*/20241011_*/*/000*/* \
      | Reformat 25 | sed "s/ /,/g" | sed "s/,[,]*$//"`
   do
      Base=PD${j}_`basename $i`

      echo "Arguments = PbPbData2023 ${i} $PWD/Output/PbPbData2023/Reco${Base} Dummy" >> $SubmitFile
      echo "Output    = Log/PbPbData2023${Base/.root}.out" >> $SubmitFile
      echo "Error     = Log/PbPbData2023${Base/.root}.out" >> $SubmitFile
      echo "Log       = Log/PbPbData2023${Base/.root}.log" >> $SubmitFile
      echo "Queue" >> $SubmitFile
      echo >> $SubmitFile
   done
done


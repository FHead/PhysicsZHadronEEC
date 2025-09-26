#!/bin/bash

echo Yay

cd /afs/cern.ch/work/c/chenyi/CMSSW/CMSSW_13_3_0/src/
eval `scramv1 runtime -sh`
cd -

export ProjectBase=/afs/cern.ch/user/c/chenyi/PhysicsWorkspace/HIZHadronEEC
export PATH=$PATH:/afs/cern.ch/user/c/chenyi/RootMacros/

# TrackResidualPP="${ProjectBase}/CommonCode/root/20230531_TrackResidualCorrection_V12_pp.root"
# TrackResidualPbPb="${ProjectBase}/CommonCode/root/20230522_TrackResidualCorrection_V9_0_20.root,${ProjectBase}/CommonCode/root/20230522_TrackResidualCorrection_V9_20_60.root,${ProjectBase}/CommonCode/root/20230522_TrackResidualCorrection_V9_60_100.root,${ProjectBase}/CommonCode/root/20230522_TrackResidualCorrection_V9_100_200.root"

TrackResidualPP="${ProjectBase}/CommonCode/root/20240807_TrackResidualCorrection_V13_pp.root"
TrackResidualPbPb="${ProjectBase}/CommonCode/root/20240807_TrackResidualCorrection_V13_0_20.root,${ProjectBase}/CommonCode/root/20240807_TrackResidualCorrection_V13_20_60.root,${ProjectBase}/CommonCode/root/20240807_TrackResidualCorrection_V13_60_100.root,${ProjectBase}/CommonCode/root/20240807_TrackResidualCorrection_V13_100_200.root"

cp /afs/cern.ch/work/c/chenyi//PhysicsWorkspace/HIZHadronEEC/SampleGeneration/20240220_ForestReducer/Execute .

echo Running job with argument = "$@"

Type=$1
InputFile=$2
RecoOutputFile=$3
GenOutputFile=$4

MinZPT=0
MinTrackPT=0.5

if [[ "$Type" == "EmbeddedMC" ]];
then
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2016 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData false \
      --IsPP true \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${RecoOutputFile}"

   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2016 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoGenLevel true \
      --IsData false \
      --IsPP true \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${GenOutputFile}"

elif [[ "$Type" == "PPbMC" ]];
then
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2016 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData false \
      --IsPP true \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${RecoOutputFile}"

   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2016 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoGenLevel true \
      --IsData false \
      --IsPP true \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${GenOutputFile}"

elif [[ "$Type" == "EmbeddedMC2023" ]];
then
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2023 \
      --RedoHiBin true \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual false \
      --DoGenLevel false \
      --IsData false \
      --IsPP false \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${RecoOutputFile}"

   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2023 \
      --RedoHiBin true \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoGenLevel true \
      --IsData false \
      --IsPP false \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${GenOutputFile}"

elif [[ "$Type" == "HydjetMC" ]]; then
   
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2018 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData false \
      --IsPP false \
      --IsBackground true \
      --CheckZ false \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${RecoOutputFile}"

   ./Execute --Input "${InputFile}" \
      --Output "${GenOutputFile}" \
      --Year 2018 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoGenLevel true \
      --IsData false \
      --IsPP false \
      --IsBackground true \
      --CheckZ false \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${GenOutputFile}"

elif [[ "$Type" == "PPMC" ]]; then
   
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2017 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPP" \
      --DoGenLevel false \
      --IsData false \
      --IsPP true \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight true
   mv Output.root "${RecoOutputFile/.root}_Nominal.root"

   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2017 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoGenLevel true \
      --IsData false \
      --IsPP true \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight true
   mv Output.root "${GenOutputFile}"

elif [[ "$Type" == "PbPbData" ]];
then
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2018 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData true \
      --IsPP false \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${RecoOutputFile/.root}_Nominal.root"
   
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2018 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData true \
      --IsPP false \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false \
      --DoAlternateTrackSelection true \
      --AlternateTrackSelection 1
   mv Output.root "${RecoOutputFile/.root}_Tight.root"

   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2018 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData true \
      --IsPP false \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false \
      --DoAlternateTrackSelection true \
      --AlternateTrackSelection 2
   mv Output.root "${RecoOutputFile/.root}_Loose.root"

elif [[ "$Type" == "PPbData" ]];
then
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2016 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData true \
      --IsPP true \
      --IsBackground false \
      --CheckZ true \
      --IgnoreEventWeight true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${RecoOutputFile/.root}_Nominal.root"
   
elif [[ "$Type" == "PbPbData2023" ]];
then
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2023 \
      --RedoHiBin true \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual false \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData true \
      --IsPP false \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false
   mv Output.root "${RecoOutputFile/.root}_Nominal.root"
   
   # ./Execute --Input "${InputFile}" \
   #    --Output Output.root \
   #    --Year 2023 \
   #    --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
   #    --DoTrackResidual true \
   #    --TrackResidualPath "$TrackResidualPbPb" \
   #    --DoGenLevel false \
   #    --IsData true \
   #    --IsPP false \
   #    --IsBackground false \
   #    --CheckZ true \
   #    --MinZPT $MinZPT \
   #    --MinTrackPT $MinTrackPT \
   #    --DoInterSampleZWeight false \
   #    --DoAlternateTrackSelection true \
   #    --AlternateTrackSelection 1
   # mv Output.root "${RecoOutputFile/.root}_Tight.root"

   # ./Execute --Input "${InputFile}" \
   #    --Output Output.root \
   #    --Year 2023 \
   #    --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
   #    --DoTrackResidual true \
   #    --TrackResidualPath "$TrackResidualPbPb" \
   #    --DoGenLevel false \
   #    --IsData true \
   #    --IsPP false \
   #    --IsBackground false \
   #    --CheckZ true \
   #    --MinZPT $MinZPT \
   #    --MinTrackPT $MinTrackPT \
   #    --DoInterSampleZWeight false \
   #    --DoAlternateTrackSelection true \
   #    --AlternateTrackSelection 2
   # mv Output.root "${RecoOutputFile/.root}_Loose.root"

elif [[ "$Type" == "MinBiasData" ]]; then
   
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2018 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData true \
      --IsPP false \
      --IsBackground true \
      --CheckZ false \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false \
      --MinTrackPT 2
   mv Output.root "${RecoOutputFile/.root/}_Nominal.root"
   
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2018 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData true \
      --IsPP false \
      --IsBackground true \
      --CheckZ false \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false \
      --DoAlternateTrackSelection true \
      --AlternateTrackSelection 1 \
      --MinTrackPT 2
   mv Output.root "${RecoOutputFile/.root/}_Tight.root"
   
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2018 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPbPb" \
      --DoGenLevel false \
      --IsData true \
      --IsPP false \
      --IsBackground true \
      --CheckZ false \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false \
      --DoAlternateTrackSelection true \
      --AlternateTrackSelection 2 \
      --MinTrackPT 2
   mv Output.root "${RecoOutputFile/.root/}_Loose.root"

elif [[ "$Type" == "PPData" ]]; then
   
   # ./Execute --Input "${InputFile}" \
   #    --Output Output.root \
   #    --Year 2017 \
   #    --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
   #    --DoTrackResidual true \
   #    --TrackResidualPath "$TrackResidualPP" \
   #    --DoGenLevel false \
   #    --IsData true \
   #    --IsPP true \
   #    --IsBackground false \
   #    --CheckZ true \
   #    --MinZPT $MinZPT \
   #    --MinTrackPT $MinTrackPT \
   #    --DoInterSampleZWeight false
   # mv Output.root "${RecoOutputFile/.root}_Nominal.root"
   # 
   # ./Execute --Input "${InputFile}" \
   #    --Output Output.root \
   #    --Year 2017 \
   #    --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
   #    --DoTrackResidual true \
   #    --TrackResidualPath "$TrackResidualPP" \
   #    --DoGenLevel false \
   #    --IsData true \
   #    --IsPP true \
   #    --IsBackground false \
   #    --CheckZ true \
   #    --MinZPT $MinZPT \
   #    --MinTrackPT $MinTrackPT \
   #    --DoInterSampleZWeight false \
   #    --DoAlternateTrackSelection true \
   #    --AlternateTrackSelection 1
   # mv Output.root "${RecoOutputFile/.root}_Tight.root"
   
   ./Execute --Input "${InputFile}" \
      --Output Output.root \
      --Year 2017 \
      --TrackEfficiencyPath ${ProjectBase}/CommonCode/root/ \
      --DoTrackResidual true \
      --TrackResidualPath "$TrackResidualPP" \
      --DoGenLevel false \
      --IsData true \
      --IsPP true \
      --IsBackground false \
      --CheckZ true \
      --MinZPT $MinZPT \
      --MinTrackPT $MinTrackPT \
      --DoInterSampleZWeight false \
      --DoAlternateTrackSelection true \
      --AlternateTrackSelection 2
   mv Output.root "${RecoOutputFile/.root}_Loose.root"

fi

rm Execute



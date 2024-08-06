./Execute   --Output Paper20240731/PbPbDataxPbPbData_Centrality030HiBinUp_4Inf_Reco.root  --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0  --CheckSignalHiBin 1  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  60 --AlternateHiBin  1  --SignalHFShiftFile None  --HFShiftFile  None  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxMinBiasData_Centrality030HiBinUp_4Inf_Reco.root  --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root --CheckBackgroundZ   0  --CheckSignalHiBin   1  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  60 --AlternateHiBin 1  --SignalHFShiftFile  None  --HFShiftFile  SumHF/DataWeight_Centrality030_HiBinUp.root  --IsPP   0  --IsReco  1  --Fraction  1  --OverSample   200   --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1  --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality030HiBinUp_4Inf_Reco.root  --Signal Input/MinBiasData4Inf_Reco1.root  --CheckZ 0  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0   --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin 1  --SignalHFShiftFile  SumHF/DataWeight_Centrality030_HiBinUp.root  --HFShiftFile  None  --IsPP   0  --IsReco  1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality030HiBinUp_4Inf_Reco_Different1.root   --Signal Input/MinBiasData4Inf_Reco1.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco2.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  1  --SignalHFShiftFile  SumHF/DataWeight_Centrality030_HiBinUp.root  --HFShiftFile  SumHF/DataWeight_Centrality030_HiBinUp.root  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality030HiBinUp_4Inf_Reco_Different2.root   --Signal Input/MinBiasData4Inf_Reco2.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  1  --SignalHFShiftFile  SumHF/DataWeight_Centrality030_HiBinUp.root  --HFShiftFile  SumHF/DataWeight_Centrality030_HiBinUp.root  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxPbPbData_Centrality3050HiBinUp_4Inf_Reco.root --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0  --CheckSignalHiBin 1  --CheckBackgroundHiBin  0  --HiBinMin  60 --HiBinMax  100   --AlternateHiBin  1  --SignalHFShiftFile None  --HFShiftFile  None  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxMinBiasData_Centrality3050HiBinUp_4Inf_Reco.root --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root --CheckBackgroundZ   0  --CheckSignalHiBin   1  --CheckBackgroundHiBin  0  --HiBinMin  60 --HiBinMax  100   --AlternateHiBin 1  --SignalHFShiftFile  None  --HFShiftFile  SumHF/DataWeight_Centrality3050_HiBinUp.root --IsPP   0  --IsReco  1  --Fraction  1  --OverSample   200   --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1  --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality3050HiBinUp_4Inf_Reco.root --Signal Input/MinBiasData4Inf_Reco1.root  --CheckZ 0  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0   --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin 1  --SignalHFShiftFile  SumHF/DataWeight_Centrality3050_HiBinUp.root --HFShiftFile  None  --IsPP   0  --IsReco  1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality3050HiBinUp_4Inf_Reco_Different1.root  --Signal Input/MinBiasData4Inf_Reco1.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco2.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  1  --SignalHFShiftFile  SumHF/DataWeight_Centrality3050_HiBinUp.root --HFShiftFile  SumHF/DataWeight_Centrality3050_HiBinUp.root --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality3050HiBinUp_4Inf_Reco_Different2.root  --Signal Input/MinBiasData4Inf_Reco2.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  1  --SignalHFShiftFile  SumHF/DataWeight_Centrality3050_HiBinUp.root --HFShiftFile  SumHF/DataWeight_Centrality3050_HiBinUp.root --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxPbPbData_Centrality5090HiBinUp_4Inf_Reco.root --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0  --CheckSignalHiBin 1  --CheckBackgroundHiBin  0  --HiBinMin  100   --HiBinMax  180   --AlternateHiBin  1  --SignalHFShiftFile None  --HFShiftFile  None  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxMinBiasData_Centrality5090HiBinUp_4Inf_Reco.root --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root --CheckBackgroundZ   0  --CheckSignalHiBin   1  --CheckBackgroundHiBin  0  --HiBinMin  100   --HiBinMax  180   --AlternateHiBin  1  --SignalHFShiftFile  None  --HFShiftFile  SumHF/DataWeight_Centrality5090_HiBinUp.root --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   200   --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent   -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality5090HiBinUp_4Inf_Reco.root --Signal Input/MinBiasData4Inf_Reco1.root  --CheckZ 0  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0   --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin 1  --SignalHFShiftFile  SumHF/DataWeight_Centrality5090_HiBinUp.root --HFShiftFile  None  --IsPP   0  --IsReco  1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality5090HiBinUp_4Inf_Reco_Different1.root  --Signal Input/MinBiasData4Inf_Reco1.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco2.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  1  --SignalHFShiftFile  SumHF/DataWeight_Centrality5090_HiBinUp.root --HFShiftFile  SumHF/DataWeight_Centrality5090_HiBinUp.root --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality5090HiBinUp_4Inf_Reco_Different2.root  --Signal Input/MinBiasData4Inf_Reco2.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  1  --SignalHFShiftFile  SumHF/DataWeight_Centrality5090_HiBinUp.root --HFShiftFile  SumHF/DataWeight_Centrality5090_HiBinUp.root --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxPbPbData_Centrality030HiBinDown_4Inf_Reco.root   --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0  --CheckSignalHiBin 1  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  60 --AlternateHiBin  -1 --SignalHFShiftFile None  --HFShiftFile  None  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxMinBiasData_Centrality030HiBinDown_4Inf_Reco.root   --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root --CheckBackgroundZ   0  --CheckSignalHiBin   1  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  60 --AlternateHiBin -1 --SignalHFShiftFile  None  --HFShiftFile  SumHF/DataWeight_Centrality030_HiBinDown.root   --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   200   --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent   -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality030HiBinDown_4Inf_Reco.root   --Signal Input/MinBiasData4Inf_Reco1.root  --CheckZ 0  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0   --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin -1 --SignalHFShiftFile  SumHF/DataWeight_Centrality030_HiBinDown.root   --HFShiftFile  None  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent   -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality030HiBinDown_4Inf_Reco_Different1.root --Signal Input/MinBiasData4Inf_Reco1.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco2.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  -1 --SignalHFShiftFile  SumHF/DataWeight_Centrality030_HiBinDown.root   --HFShiftFile  SumHF/DataWeight_Centrality030_HiBinDown.root   --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality030HiBinDown_4Inf_Reco_Different2.root --Signal Input/MinBiasData4Inf_Reco2.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  -1 --SignalHFShiftFile  SumHF/DataWeight_Centrality030_HiBinDown.root   --HFShiftFile  SumHF/DataWeight_Centrality030_HiBinDown.root   --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxPbPbData_Centrality3050HiBinDown_4Inf_Reco.root  --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0  --CheckSignalHiBin 1  --CheckBackgroundHiBin  0  --HiBinMin  60 --HiBinMax  100   --AlternateHiBin  -1 --SignalHFShiftFile None  --HFShiftFile  None  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxMinBiasData_Centrality3050HiBinDown_4Inf_Reco.root  --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root --CheckBackgroundZ   0  --CheckSignalHiBin   1  --CheckBackgroundHiBin  0  --HiBinMin  60 --HiBinMax  100   --AlternateHiBin -1 --SignalHFShiftFile  None  --HFShiftFile  SumHF/DataWeight_Centrality3050_HiBinDown.root  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   200   --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent   -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality3050HiBinDown_4Inf_Reco.root  --Signal Input/MinBiasData4Inf_Reco1.root  --CheckZ 0  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0   --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin -1 --SignalHFShiftFile  SumHF/DataWeight_Centrality3050_HiBinDown.root  --HFShiftFile  None  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent   -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality3050HiBinDown_4Inf_Reco_Different1.root   --Signal Input/MinBiasData4Inf_Reco1.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco2.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  -1 --SignalHFShiftFile  SumHF/DataWeight_Centrality3050_HiBinDown.root  --HFShiftFile  SumHF/DataWeight_Centrality3050_HiBinDown.root  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality3050HiBinDown_4Inf_Reco_Different2.root   --Signal Input/MinBiasData4Inf_Reco2.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  -1 --SignalHFShiftFile  SumHF/DataWeight_Centrality3050_HiBinDown.root  --HFShiftFile  SumHF/DataWeight_Centrality3050_HiBinDown.root  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxPbPbData_Centrality5090HiBinDown_4Inf_Reco.root  --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0  --CheckSignalHiBin 1  --CheckBackgroundHiBin  0  --HiBinMin  100   --HiBinMax  180   --AlternateHiBin  -1 --SignalHFShiftFile None  --HFShiftFile  None  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/PbPbDataxMinBiasData_Centrality5090HiBinDown_4Inf_Reco.root  --Signal Input/PbPbData_Reco.root --CheckZ 1  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root --CheckBackgroundZ   0  --CheckSignalHiBin   1  --CheckBackgroundHiBin  0  --HiBinMin  100   --HiBinMax  180   --AlternateHiBin  -1 --SignalHFShiftFile  None  --HFShiftFile  SumHF/DataWeight_Centrality5090_HiBinDown.root  --IsPP 0  --IsReco 1  --Fraction  1  --OverSample   200   --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality5090HiBinDown_4Inf_Reco.root  --Signal Input/MinBiasData4Inf_Reco1.root  --CheckZ 0  --DoZReweight  0  --SelfMixing   1  --Background   None  --CheckBackgroundZ   0   --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin -1 --SignalHFShiftFile  SumHF/DataWeight_Centrality5090_HiBinDown.root  --HFShiftFile  None  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   1  --MinPT  4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent   -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality5090HiBinDown_4Inf_Reco_Different1.root   --Signal Input/MinBiasData4Inf_Reco1.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco2.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  -1 --SignalHFShiftFile  SumHF/DataWeight_Centrality5090_HiBinDown.root  --HFShiftFile  SumHF/DataWeight_Centrality5090_HiBinDown.root  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &
./Execute   --Output Paper20240731/MinBiasDataxMinBiasData_Centrality5090HiBinDown_4Inf_Reco_Different2.root   --Signal Input/MinBiasData4Inf_Reco2.root --CheckZ 0  --DoZReweight  0  --SelfMixing   0  --Background   Input/MinBiasData4Inf_Reco1.root   --CheckBackgroundZ   0  --CheckSignalHiBin   0  --CheckBackgroundHiBin  0  --HiBinMin  0  --HiBinMax  200   --AlternateHiBin  -1 --SignalHFShiftFile  SumHF/DataWeight_Centrality5090_HiBinDown.root  --HFShiftFile  SumHF/DataWeight_Centrality5090_HiBinDown.root  --IsPP   0  --IsReco 1  --Fraction  1  --OverSample   5  --MinPT 4  --MaxPT  -1 --MinZPT 40 --DoDiHadron   1  --SubEvent  -1,-1 --ExtraZ -1 --MaxAbsEta -1 --IgnorePU  0  &

wait

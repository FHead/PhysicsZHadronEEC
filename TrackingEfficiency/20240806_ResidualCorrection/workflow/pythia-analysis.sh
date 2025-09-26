./finalAnalysis.sh output/$1DY RECO  $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} --MinZPT 40 --MaxZPT 200 -MinTrackPT 1 --MaxTrackPT 500  --MinHiBin 0 --MaxHiBin 20  --Input mergedSample/pythia-v6.root     --IsGen false --IsPP true --IsGenZ true
./finalAnalysis.sh output/$1DY GEN   $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} --MinZPT 40 --MaxZPT 200 -MinTrackPT 1 --MaxTrackPT 500  --MinHiBin 0 --MaxHiBin 20  --Input mergedSample/pythia-gen-v6.root --IsGen true --IsPP true --IsGenZ true
root -l -q -b correction.C
mv correction.root output/correction_1.root
./finalAnalysis.sh output/$1DY RECO  $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} --MinZPT 40 --MaxZPT 200 -MinTrackPT 1 --MaxTrackPT 500  --MinHiBin 0 --MaxHiBin 20  --Input mergedSample/pythia-v6.root     --residualFile output/correction_1.root --IsGen false --IsPP true --IsGenZ true
root -l -q -b correction.C
mv correction.root output/correction_2.root
root -l -q -b "merge_corrections.C(\"output/correction_1.root\",\"output/correction_2.root\",\"output/correction_12.root\")"
./finalAnalysis.sh output/$1DY RECO  $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} --MinZPT 40 --MaxZPT 200 -MinTrackPT 1 --MaxTrackPT 500  --MinHiBin 0 --MaxHiBin 20  --Input mergedSample/pythia-v6.root     --residualFile output/correction_12.root --IsGen false --IsPP true --IsGenZ true
root -l -q -b correction.C
mv correction.root output/correction_3.root

root -l -q -b plot_corrections.C
mv corrections.pdf corrections_pp.pdf

root -l -q -b "merge_corrections.C(\"output/correction_12.root\",\"output/correction_3.root\",\"output/20240807_TrackResidualCorrection_V13_pp.root\")"



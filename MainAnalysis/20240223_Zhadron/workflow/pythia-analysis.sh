./finalAnalysis.sh output/$1pythia 1_2   $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}   --MinZPT 40 --MaxZPT 350 --MinTrackPT 1 --MaxTrackPT 2  --Input mergedSample/pythia-v6.root --MixFile mergedSample/pythia-v6.root  --IsPP true --IsGenZ false --nMix 1
./finalAnalysis.sh output/$1pythia 2_4   $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}   --MinZPT 40 --MaxZPT 350 --MinTrackPT 2 --MaxTrackPT 4  --Input mergedSample/pythia-v6.root --MixFile mergedSample/pythia-v6.root  --IsPP true --IsGenZ false --nMix 1
./finalAnalysis.sh output/$1pythia 4_10  $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}   --MinZPT 40 --MaxZPT 350 --MinTrackPT 4 --MaxTrackPT 10 --Input mergedSample/pythia-v6.root --MixFile mergedSample/pythia-v6.root  --IsPP true --IsGenZ false --nMix 1
hadd -f plots/$1pythia-result.root output/$1pythia-1_2-result.root output/$1pythia-2_4-result.root output/$1pythia-4_10-result.root
hadd -f plots/$1pythia-nosub.root output/$1pythia-1_2-nosub.root output/$1pythia-2_4-nosub.root output/$1pythia-4_10-nosub.root



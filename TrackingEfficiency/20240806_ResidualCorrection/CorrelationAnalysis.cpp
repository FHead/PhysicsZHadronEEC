#include <TCanvas.h>
#include <TTree.h>
#include <TH1D.h>
#include <TH2D.h>
#include <TH3D.h>
#include <TCut.h>
#include <TLegend.h>
#include <TNtuple.h>
#include <TFile.h>

#include <iostream>

using namespace std;
#include "utilities.h"             // Yen-Jie's random utility functions
#include "helpMessage.h"           // Print out help message
#include "parameter.h"             // The parameters used in the analysis
#include "Messenger.h"             // Yi's Messengers for reading data files
#include "CommandLine.h"           // Yi's Commandline bundle
#include "ProgressBar.h"           // Yi's fish progress bar
#include "TrackResidualCorrector.h" // Residual correction

//============================================================//
// Function to check for configuration errors
//============================================================//
bool checkError(const Parameters& par) {
    if (par.isHiBinUp && par.isHiBinDown) {
        std::cout << "Error! Cannot do hiBinUp and hiBinDown simultaneously!" << std::endl;
        return true;  // Return true indicates an error was found
    }

    // No errors found
    return false;
}

//======= eventSelection =====================================//
// Check if the event mass eventSelection criteria
// MinZPT < zPt < MaxZPT
// MinHiBin , hiBin < MaxHiBin
//============================================================//
bool eventSelection(ZHadronMessenger *b, const Parameters& par) {
   int effectiveHiBin = par.isHiBinUp ? b->hiBinUp : (par.isHiBinDown ? b->hiBinDown : b->hiBin);

   bool foundZ = false;            
   if (par.isPUReject && par.isPP && b->NVertex!=1) return 0;    // Only apply PU rejection (single vertex requirement) in pp analysis
   if (effectiveHiBin< par.MinHiBin) return 0;
   if (effectiveHiBin>=par.MaxHiBin) return 0;
   /*
   if ((par.isGenZ ? b->genZMass->size() : b->zMass->size())==0) return 0;
   if ((par.isGenZ ? (*b->genZMass)[0] : (*b->zMass)[0])<60) return 0;
   if ((par.isGenZ ? (*b->genZMass)[0] : (*b->zMass)[0])>120) return 0;
   if (fabs((par.isGenZ ? (*b->genZY)[0] : (*b->zY)[0]))<=par.MinZY) return 0;
   if (fabs((par.isGenZ ? (*b->genZY)[0] : (*b->zY)[0]))>=par.MaxZY) return 0;
   if ((par.isGenZ ? (*b->genZPt)[0] : (*b->zPt)[0])<par.MinZPT) return 0;
   if ((par.isGenZ ? (*b->genZPt)[0] : (*b->zPt)[0])>par.MaxZPT) return 0;
   */
   if (b->genZMass->size()==0   || b->zMass->size()==0) return 0;
   if ((*b->genZMass)[0]<60 || (*b->zMass)[0]<60) return 0;
   if ((*b->genZMass)[0]>120 || (*b->zMass)[0]>120) return 0;
   if (fabs((*b->genZY)[0])<=par.MinZY || fabs((*b->zY)[0])<=par.MinZY) return 0;
   if (fabs((*b->genZY)[0])>=par.MaxZY || fabs((*b->zY)[0])>=par.MaxZY) return 0;
   if ((*b->genZPt)[0]<par.MinZPT || (*b->zPt)[0]<par.MinZPT) return 0;
   if ((*b->genZPt)[0]>par.MaxZPT || (*b->zPt)[0]>par.MaxZPT) return 0;


   foundZ=1;   
   return foundZ;
}

//======= trackSelection =====================================//
// Check if the track pass selection criteria
//============================================================//
bool trackSelection(ZHadronMessenger *b, Parameters par, int j) {
    if (par.isMuTagged && (*b->trackMuTagged)[j]) return false; 
    if ((*b->trackPt)[j]>par.MaxTrackPT) return false;  
    if ((*b->trackPt)[j]<par.MinTrackPT) return false;
    if ((!par.includeHole)&&(*b->trackWeight)[j]<0) return false;
    return true;
}

// ======= Define mixed event matching criteria
bool matching(ZHadronMessenger *a, ZHadronMessenger *b, double shift) {
    if (a->SignalHF<shift*1.04&&b->SignalHF<shift*1.04) return 1;
    if ((b->SignalHF/(a->SignalHF-shift))<1.04&&b->SignalHF/(a->SignalHF-shift)>0.96) return 1;
    return 0;
}

//============================================================//
// Z hadron dphi calculation
//============================================================//
float get3D(ZHadronMessenger *MZSignal, TH3D *h, const Parameters& par) {
    float nZ = 0;
    h->Sumw2();
    par.printParameters();
    unsigned long nEntry = MZSignal->GetEntries() * par.scaleFactor;
    unsigned long iStart = nEntry * (par.nChunk - 1) / par.nThread;
    unsigned long iEnd = nEntry * par.nChunk / par.nThread;
    unsigned int targetMix = ((par.nMix - 1) * par.mix + 1);

    ProgressBar Bar(cout, iEnd - iStart);
    Bar.SetStyle(1);
    unsigned long mix_i = iStart;
    unsigned long mixstart_i = mix_i;
    int deltaI = (iEnd-iStart)/100+1;
    TrackResidualCorrector corrector(par.residualFile.c_str());              

    for (unsigned long i = iStart; i < iEnd; i++) {
       MZSignal->GetEntry(i);
       
       if (i % deltaI == 0) {
          Bar.Update(i - iStart);
          Bar.Print();
       }
       // Check if the event passes the selection criteria
       if (eventSelection(MZSignal, par)) {
          for (unsigned long j = 0; j < MZSignal->trackPhi->size(); j++) {
             if (!trackSelection(MZSignal, par, j)) continue;
             float trackPhi  = (*MZSignal->trackPhi)[j];
             if (trackPhi<0) trackPhi+= 2 * M_PI;
             float trackEta  = (*MZSignal->trackEta)[j];
             float trackPt   = (*MZSignal->trackPt)[j];
             float residualCorrection = ((par.residualFile=="")||par.isGen==1)? 1 : corrector.GetCorrectionFactor(trackPt, trackEta, trackPhi);
             float weight = 1; //MZSignal->EventWeight; //MZSignal->ZWeight: somehow the Z weight in gen and reco are different.
	                 //weight*= MZSignal->ExtraZWeight[par.ExtraZWeight];
                   weight*= (*MZSignal->trackWeight)[j]/(*MZSignal->trackResidualWeight)[j];
                   weight*= residualCorrection;
             //if (trackPt>20) cout <<"track pt: "<<trackPt<<" "<<residualCorrection<<endl;       
             h->Fill( trackPt, trackEta, trackPhi, weight);
          }
          nZ++;

       }
    }
    return nZ;
}

class DataAnalyzer {
public:
  DataAnalyzer(const char* filename, const char* residualFilename, const char* outFilename, const char *mytitle = "Data") :
     inf(new TFile(filename)), MZHadron(new ZHadronMessenger(*inf,string("Tree"))), title(mytitle), outf(new TFile(outFilename, "recreate"))  {
     outf->cd();
  }

  ~DataAnalyzer() {
    deleteHistograms();
    inf->Close();
    outf->Close();
    delete MZHadron;
  }

  void analyze(Parameters& par) {
    // First histogram with mix=false
    par.mix = false;
    const int nbinsX = 25;
    const double xMin = 1;
    const double xMax = 70;
    std::vector<double> binEdgesX(nbinsX + 1);
    

    for (int i = 0; i <= nbinsX; ++i) binEdgesX[i] = xMin * std::pow(xMax / xMin, double(i) / nbinsX);
    binEdgesX[nbinsX]=200;

    const int nbinsY = 50;
    const double yMin = -2.4;
    const double yMax = 2.4;
    std::vector<double> binEdgesY(nbinsY + 1);

    for (int i = 0; i <= nbinsY; ++i) binEdgesY[i] = yMin + (yMax - yMin) * i / nbinsY;

    const int nbinsZ = 50;
    const double zMin = 0;
    const double zMax = 2 * M_PI;
    std::vector<double> binEdgesZ(nbinsZ + 1);

    for (int i = 0; i <= nbinsZ; ++i) binEdgesZ[i] = zMin + (zMax - zMin) * i / nbinsZ;

    h = new TH3D("h3D", "Histogram Title; p_{T} (GeV/c); #eta; #phi",
                     nbinsX, &binEdgesX[0],
                     nbinsY, &binEdgesY[0],
                     nbinsZ, &binEdgesZ[0]);
    //    h = new TH3D("h3D", "Histogram Title; p_{T} (GeV/c); #eta; #phi", 50,0,10,50,-2.4,2.4,50, 0,2*M_PI);
    hNZ = new TH1D("hNZ","",1,0,100);
    hNZ->Fill(1, get3D(MZHadron, h, par));
  }
  
  void writeHistograms(TFile* outf) {
    outf->cd();
    smartWrite(h);
    smartWrite(hNZ);
  }

  TFile *inf, *residualFile, *residualFileClone, *outf;
  TH3D *h=0;
  TH1D *hNZ=0;
  ZHadronMessenger *MZHadron;
  string title;
  
  private:
  void deleteHistograms() {
    delete h;
  }
};

//============================================================//
// Main analysis
//============================================================//
int main(int argc, char *argv[])
{
   if (printHelpMessage(argc, argv)) return 0;

   CommandLine CL(argc, argv);
   float MinZPT      = CL.GetDouble("MinZPT", 40);         // Minimum Z particle transverse momentum threshold for event selection.
   float MaxZPT      = CL.GetDouble("MaxZPT", 200);        // Maximum Z particle transverse momentum threshold for event selection.
   float MinTrackPT  = CL.GetDouble("MinTrackPT", 1);      // Minimum track transverse momentum threshold for track selection.
   float MaxTrackPT  = CL.GetDouble("MaxTrackPT", 2);      // Maximum track transverse momentum threshold for track selection.
   int   MinHiBin    = CL.GetInt   ("MinHiBin", 0);        // Minimum hiBin value for event selection.
   int   MaxHiBin    = CL.GetInt   ("MaxHiBin", 200);      // Maximum hiBin value for event selection.
   bool  IsData      = CL.GetBool  ("IsData", false);      // Determines whether the analysis is being run on actual data.
   bool  IsPP        = CL.GetBool  ("IsPP", false);        // Flag to indicate if the analysis is for Proton-Proton collisions.
   bool  IsJewel     = CL.GetBool  ("IsJewel", false);     // Flag to indicate if the analysis is for Jewel since the hole for Jewel is not hadronized
   cout <<MinTrackPT<<" "<<MaxTrackPT<<endl;
   if (IsPP) {
      MinHiBin=-2;
      MaxHiBin=0;
   }

   Parameters par(MinZPT, MaxZPT, MinTrackPT, MaxTrackPT, MinHiBin, MaxHiBin);
   par.input         = CL.Get      ("Input",   "mergedSample/HISingleMuon-v5.root");            // Input file
   par.residualFile  = CL.Get      ("residualFile", "");            // Input Mix file
   par.output        = CL.Get      ("Output",  "output.root");                             	// Output file
   par.isGen         = CL.GetBool  ("IsGen", false); // Determine if the analysis is gen level
   par.isGenZ        = CL.GetBool  ("IsGenZ", true);      // Determine if the analysis is using Gen level Z     
   par.isPUReject    = CL.GetBool  ("IsPUReject", true);  // Flag to reject PU sample for systemaitcs.
   par.isMuTagged    = CL.GetBool  ("IsMuTagged", true);   // Default is true
   par.isHiBinUp     = CL.GetBool  ("IsHiBinUp", false);   // Default is false
   par.isHiBinDown   = CL.GetBool  ("IsHiBinDown", false); // Default is false
   par.scaleFactor   = CL.GetDouble("Fraction", 1.00);     // Fraction of event processed in the sample
   par.nThread       = CL.GetInt   ("nThread", 1);         // The number of threads to be used for parallel processing.
   par.nChunk        = CL.GetInt   ("nChunk", 1);          // Specifies which chunk (segment) of the data to process, used in parallel processing.
   par.nMix          = CL.GetInt   ("nMix", 10);           // Number of mixed events to be considered in the analysis.
   par.shift         = CL.GetDouble("Shift", 971.74);       // Shift of sumHF in MB matching
   par.MinZY         = CL.GetDouble("MinZY", 0);           // Minimum Z particle rapidity threshold for event selection.
   par.MaxZY         = CL.GetDouble("MaxZY", 200);         // Maximum Z particle rapidity threshold for event selection.
   par.ExtraZWeight  = CL.GetInt   ("ExtraZWeight",-1);    // Do Muon systematics, -1 means no extraweight.
   par.includeHole   = CL.GetBool  ("includeHole",true);   // Include hole particle or not
   par.mix = 0;
   par.isPP = IsPP;
   par.isJewel = IsJewel;
   
   if (checkError(par)) return -1;
          
   // Analyze Data
   DataAnalyzer analyzer(par.input.c_str(), par.residualFile.c_str(), par.output.c_str(), "Data");
   analyzer.analyze(par);
   analyzer.writeHistograms(analyzer.outf);
   saveParametersToHistograms(par, analyzer.outf);
   cout << "done!" << analyzer.outf->GetName() << endl;
}

#include <TFile.h>
#include <TCanvas.h>
#include <TTree.h>
#include <TH1D.h>
#include <TH2D.h>
#include <TH3D.h>
#include <TCut.h>
#include <TLegend.h>
#include <TNtuple.h>

#include <iostream>

using namespace std;

#include "utilities.h"
#include "Messenger.h"
#include "CommandLine.h"
#include "ProgressBar.h"


//============================================================//
// Define analysis parameters
//============================================================//

class Parameters {
  public:
  Parameters(double MinZPT, double MaxZPT, double MinTrackPT, double MaxTrackPT,
             int MinHiBin = 0, int MaxHiBin = 200, bool mix = false, bool isGen = false,
             double scaleFactor = 1.0, double nMix = 1)
    : MinZPT(MinZPT), MaxZPT(MaxZPT), MinTrackPT(MinTrackPT), MaxTrackPT(MaxTrackPT),
      MinHiBin(MinHiBin), MaxHiBin(MaxHiBin), mix(mix), isGen(isGen), scaleFactor(scaleFactor), nMix(nMix) {}

  double MinZPT;        // Lower limit of zpt
  double MaxZPT;        // Upper limit of zpt
  double MinTrackPT;    // Lower limit of pt
  double MaxTrackPT;    // Upper limit of pt
  int MinHiBin;         // Lower limit of hiBin
  int MaxHiBin;         // Upper limit of hiBin
  bool isGen;           // isGen flag
  double scaleFactor;   // Scale factor
  string input;         // Input file name
  string output;        // Output file name
  int nThread;          // Number of Threads
  int nChunk;           // Process the Nth chunk
  bool mix;             // Mix flag
  int nMix;             // Number of mixed events

  void printParameters() const {
    cout << "MinZPT: " << MinZPT << endl;
    cout << "zPtCfutH: " << MaxZPT << endl;
    cout << "MinTrackPT: " << MinTrackPT << endl;
    cout << "MaxTrackPT: " << MaxTrackPT << endl;
    cout << "MinHiBin: " << MinHiBin << endl;
    cout << "MaxHiBin: " << MaxHiBin << endl;
    cout << "mix: " << mix << endl;
    cout << "isGen: " << isGen << endl;
    cout << "input: " << input << endl;
    cout << "output: " << output << endl;
    cout << "nChunk/nThread: " << nChunk << "/" << nThread << endl;
    if (mix) cout <<"Event mixing!"<<endl;
    cout << "scaleFactor: " << scaleFactor << endl;
  }
};


//======= eventSelection =====================================//
// Check if the event mass eventSelection criteria
// MinZPT < zPt < MaxZPT
// MinHiBin , hiBin < MaxHiBin
//============================================================//
bool eventSelection(ZHadronMessenger *b, const Parameters& par) {
   bool foundZ = false;
   if (b->hiBin< par.MinHiBin) return 0;
   if (b->hiBin>=par.MaxHiBin) return 0;
   if (b->zMass->size()==0) return 0;
   if ((*b->zMass)[0]<60) return 0;
   if ((*b->zMass)[0]>120) return 0;
   if (fabs((*b->zEta)[0])>2) return 0;
   if ((*b->zPt)[0]<par.MinZPT) return 0;
   if ((*b->zPt)[0]>par.MaxZPT) return 0;

   foundZ=1;   
   return foundZ;
}

//======= trackSelection =====================================//
// Check if the track pass selection criteria
// MinZPT < zPt < MaxZPT
// MinHiBin , hiBin < MaxHiBin
//============================================================//
bool trackSelection(ZHadronMessenger *b, Parameters par, int j) {
    //if ((*b->trackMuTagged)[j]) return false;  
    if ((*b->trackPt)[j]>par.MaxTrackPT) return false;  
    if ((*b->trackPt)[j]<par.MinTrackPT) return false;  
    return true;
}


//============================================================//
// Z hadron dphi calculation
//============================================================//
double getDphi(ZHadronMessenger *b, TH2D *h, const Parameters& par) {

    double nZ=0;
    h->Sumw2();
    par.printParameters();
    unsigned long nEntry = b->GetEntries()*par.scaleFactor;
    unsigned long iStart = nEntry*(par.nChunk-1)/par.nThread;
    unsigned long iEnd = nEntry*par.nChunk/par.nThread;
    ProgressBar Bar(cout, iEnd-iStart);
    Bar.SetStyle(-1);

    for (unsigned long i=iStart;i<iEnd;i++) {
       bool foundZ=false;
       b->GetEntry(i);
       if (i%300==0){
          Bar.Update(i-iStart);
          Bar.Print();
       }
       
       // check if the event pass the selection criteria
       if (eventSelection(b, par)) {
          double zPhi = (*b->zPhi)[0];
          double zEta = (*b->zEta)[0];	  

	  double mix_i = i;
	  
	  // find a mixed event
	  for (unsigned int nMix=0;nMix<((par.nMix-1)*par.mix+1);nMix++) {
	     bool foundMix = 0;
	     nZ+=(b->NCollWeight);    // Ncoll reweighting in the event level.
	     if (par.mix) {
	        while (foundMix==0) {
		
	           mix_i = (mix_i+1);
		   if (mix_i>=b->GetEntries()) mix_i=0;
		   if (i==mix_i)  break;
		   b->GetEntry(mix_i);
		   if (eventSelection(b, par)) foundMix=1;
	        }
	     }
	  
	     if (foundMix==0&&par.mix) {
	        cout <<"Can not find a mixed event!!! Event = "<<i<<endl;
	        break;
	     }
	  
	     for (unsigned long j=0;j<b->trackPhi->size();j++) {
                if (!trackSelection(b, par, j)) continue;  
                double trackDphi = DeltaPhi((*b->trackPhi)[j], zPhi);
		double trackDphi2 = DeltaPhi(zPhi, (*b->trackPhi)[j]);
	        double trackDeta = fabs((*b->trackEta)[j]- zEta);
		double weight = (b->NCollWeight)*(*b->trackWeight)[j]*(b->ZWeight); //(*b->trackResidualWeight)[j]*
		
		h->Fill(trackDeta,trackDphi,weight);
 	        h->Fill(-trackDeta,trackDphi,weight);
 	        h->Fill(trackDeta,trackDphi2,weight);
 	        h->Fill(-trackDeta,trackDphi2,weight);
	     }
          }
       }
    }
    cout <<"done"<<nZ<<endl;
    return nZ;
    //h->Scale(1./((double) nZ));
}


class DataAnalyzer {
public:
  DataAnalyzer(const char* filename, const char* treename, const char *mytitle = "Data") :
     inf(new TFile(filename)), MZHadron(new ZHadronMessenger(*inf,string("Tree"))), title(mytitle) {}

  ~DataAnalyzer() {
    deleteHistograms();
    closeFile();
  }

  void analyze(Parameters& par) {
    // First histogram with mix=false
    par.mix = false;
    h = new TH2D(Form("h%s", title.c_str()), "", 20, -4, 4, 20, -M_PI, M_PI);
    hNZ = new TH1D(Form("hNZ%s", title.c_str()),"",1,0,1);
    hNZ->SetBinContent(1,getDphi(MZHadron, h, par));

    // Second histogram with mix=true
    par.mix = true;
    hMix = new TH2D(Form("hMix%s", title.c_str()), "", 20, -4, 4, 20, -M_PI, M_PI);
    hNZMix = new TH1D(Form("hNZMix%s", title.c_str()),"",1,0,1);
    hNZMix->SetBinContent(1,getDphi(MZHadron, hMix, par));
  }
  
  void writeHistograms(TFile* outf) {
    outf->cd();
    smartWrite(h);
    smartWrite(hMix);
    smartWrite(hNZ);
    smartWrite(hNZMix);
  }

  TFile *inf;
  ZHadronMessenger *MZHadron;
  TH2D *h=0;
  TH2D *hMix=0;
  TH1D *hNZ;
  TH1D *hNZMix;
  string title;
  
  private:
  void deleteHistograms() {
    delete h;
    delete hMix;
    delete hNZ;
    delete hNZMix;
  }

  void closeFile() {
    inf->Close();
  }
};



//============================================================//
// Main analysis
//============================================================//

int compareDataMCLoop(Parameters &par)
{
   TCanvas *c = new TCanvas("c", "", 800, 800);

   // Analyze Data
   DataAnalyzer analyzerData(par.input.c_str(), "Tree", "Data");
   analyzerData.analyze(par);


   TFile *outf = new TFile(par.output.c_str(), "recreate");
   analyzerData.writeHistograms(outf);

   cout << "done!" << endl;
   cout << outf->GetName() << endl;
   return 1;
}


int main(int argc, char *argv[])
{
   CommandLine CL(argc, argv);

   string Default = "sample/HISingleMuon.root";
   string Input = CL.Get("Input", Default);
   string Output        = CL.Get("Output", "output.root");
   bool IsData                        = CL.GetBool("IsData", false);
   bool IsPP                          = CL.GetBool("IsPP", false);
   bool IsBackground                  = CL.GetBool("IsBackground", false);
   double Fraction                    = CL.GetDouble("Fraction", 1.00);
   double MinZPT                      = CL.GetDouble("MinZPT", 40);
   double MinTrackPT                  = CL.GetDouble("MinTrackPT", 1);
   double MaxZPT                      = CL.GetDouble("MaxZPT", 120);
   double MaxTrackPT                  = CL.GetDouble("MaxTrackPT", 2);
   int MaxHiBin                       = CL.GetInt("MaxHiBin", 0);
   int MinHiBin                       = CL.GetInt("MinHiBin", 200);
   int nThread                        = CL.GetInt("nThread",1);
   int nChunk                         = CL.GetInt("nChunk",1);
   int nMix                           = CL.GetInt("nMix",10);

   // Parameter sets
   Parameters par(MinZPT, MaxZPT, MinTrackPT, MaxTrackPT, MaxHiBin, MinHiBin);
   par.isGen = 0;
   par.mix = 0;
   par.scaleFactor = Fraction;
   par.input = Input;
   par.output = Output;
   par.nThread = nThread;
   par.nChunk = nChunk;
   par.nMix = nMix;

   compareDataMCLoop(par);
   
}

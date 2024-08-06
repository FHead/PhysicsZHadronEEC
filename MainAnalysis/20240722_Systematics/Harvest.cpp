#include <iostream>
#include <map>
using namespace std;

#include "TH1D.h"
#include "TFile.h"

#include "CommandLine.h"

int main(int argc, char *argv[]);
void AddInQuadrature(TH1D *HB, TH1D *HV, TH1D *GB, TH1D *GV);

int main(int argc, char *argv[])
{
   CommandLine CL(argc, argv);

   string Nominal            = CL.Get("Nominal");

   vector<string> Base       = CL.GetStringVector("Base");
   vector<string> Variant    = CL.GetStringVector("Variant");
   vector<string> Label      = CL.GetStringVector("Label");
   vector<int> Group         = CL.GetIntVector("Group");
   vector<string> GroupLabel = CL.GetStringVector("GroupLabel", vector<string>{"A", "B", "C", "D", "E"});
   GroupLabel.insert(GroupLabel.begin(), "NotGrouped");

   vector<string> Histogram  = CL.GetStringVector("Histogram");

   string OutputFileName     = CL.Get("Output");

   int N = Base.size();
   if(N != (int)Variant.size())
   {
      cerr << "Error: Base count " << N << ", Variant count " << Variant.size() << endl;
      return -1;
   }
   if(N != (int)Label.size())
   {
      cerr << "Error: Base count " << N << ", Label count " << Label.size() << endl;
      return -1;
   }
   if(N != (int)Group.size())
   {
      cerr << "Error: Base count " << N << ", Group count " << Group.size() << endl;
      return -1;
   }

   TFile OutputFile(OutputFileName.c_str(), "RECREATE");

   for(string H : Histogram)
   {
      map<int, TH1D *> Groups;

      // Copy the nominal histogram to output
      TFile FN(Nominal.c_str());
      
      OutputFile.cd();
      
      TH1D *HNSource = (TH1D *)FN.Get(H.c_str());
      TH1D *HN = (TH1D *)HNSource->Clone(Form("Nominal_%s", H.c_str()));
      HN->Write();
   
      // Setup grouped histograms
      for(int iF = 0; iF < N; iF++)
      {
         if(Group[iF] <= 0)
            continue;

         if(Groups.find(Group[iF]) == Groups.end() || Groups[Group[iF]] == nullptr)   // new group encountered!
         {
            OutputFile.cd();
            Groups[Group[iF]] = (TH1D *)HN->Clone(Form("Group%s_Variant_%s", GroupLabel[Group[iF]].c_str(), H.c_str()));
         }
      }

      FN.Close();

      // Now assemble the systematics
      for(int iF = 0; iF < N; iF++)
      {
         TFile FB(Base[iF].c_str());
         TFile FV(Variant[iF].c_str());
   
         TH1D *HB = (TH1D *)FB.Get(H.c_str());
         TH1D *HV = (TH1D *)FV.Get(H.c_str());

         OutputFile.cd();

         HB->Clone(Form("%s_Base_%s", Label[iF].c_str(), H.c_str()))->Write();
         HV->Clone(Form("%s_Variant_%s", Label[iF].c_str(), H.c_str()))->Write();

         // Add to group if applicable
         if(Group[iF] > 0)
            AddInQuadrature(HB, HV, HN, Groups[Group[iF]]);

         FV.Close();
         FB.Close();
      }
   
      OutputFile.cd();

      for(auto iter : Groups)
      {
         if(iter.second != nullptr)
         {
            ((TH1D *)HN->Clone(Form("Group%s_Base_%s", GroupLabel[iter.first].c_str(), H.c_str())))->Write();
            iter.second->Write();
         }
      }
   }

   OutputFile.Close();

   return 0;
}

void AddInQuadrature(TH1D *HB, TH1D *HV, TH1D *GB, TH1D *GV)
{
   int NBin = GB->GetNbinsX();

   for(int i = 1; i <= NBin; i++)
   {
      double E1 = HV->GetBinContent(i) - HB->GetBinContent(i);
      double E2 = GV->GetBinContent(i) - GB->GetBinContent(i);

      GV->SetBinContent(i, GB->GetBinContent(i) + sqrt(E1 * E1 + E2 * E2));
   }
}





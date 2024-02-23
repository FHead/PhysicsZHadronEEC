#include <iostream>
using namespace std;

#include "TFile.h"
#include "TTree.h"
#include "TLorentzVector.h"

#include "CommonFunctions.h"
#include "CommandLine.h"
#include "ProgressBar.h"
#include "Messenger.h"

int main(int argc, char *argv[]);
double GetHFSum(PFTreeMessenger *M);
double GetGenHFSum(GenParticleTreeMessenger *M);

int main(int argc, char *argv[])
{
   CommandLine CL(argc, argv);

   string InputFileName = CL.Get("Input");
   string OutputFileName = CL.Get("Output");

   bool DoGenLevel                    = CL.GetBool("DoGenLevel", true);
   bool IsData                        = CL.GetBool("IsData", false);
   bool IsPP                          = CL.GetBool("IsPP", false);
   bool IsBackground                  = CL.GetBool("IsBackground", false);
   double Fraction                    = CL.GetDouble("Fraction", 1.00);
   double MinZPT                      = CL.GetDouble("MinZPT", 20);
   double MinTrackPT                  = CL.GetDouble("MinTrackPT", 0);
   bool DoAlternateTrackSelection     = CL.GetBool("DoAlternateTrackSelection", false);
   int AlternateTrackSelection        = DoAlternateTrackSelection ? CL.GetInt("AlternateTrackSelection") : 0;
   bool DoSumET                       = CL.GetBool("DoSumET", false);
   double MuonVeto                    = CL.GetDouble("MuonVeto", 0.01);
   bool CheckZ                        = MinZPT > 0 ? true : false;

   string PFTreeName                  = IsPP ? "pfcandAnalyzer/pfTree" : "particleFlowAnalyser/pftree";
   PFTreeName                         = CL.Get("PFTree", PFTreeName);

   TFile InputFile(InputFileName.c_str());

   HiEventTreeMessenger     MEvent(InputFile);
   TrackTreeMessenger       MTrackPP(InputFile);
   PbPbTrackTreeMessenger   MTrack(InputFile);
   GenParticleTreeMessenger MGen(InputFile);
   PFTreeMessenger          MPF(InputFile, PFTreeName);
   MuTreeMessenger          MMu(InputFile);
   SkimTreeMessenger        MSkim(InputFile);
   TriggerTreeMessenger     MTrigger(InputFile);
   
   TFile OutputFile(OutputFileName.c_str(), "RECREATE");
   TTree Tree("Tree", "Tree for ZHadron EEC analysis");
   TTree InfoTree("InfoTree", "Information");

   ZHadronMessenger MZHadron;
   MZHadron.SetBranch(&Tree);

   int EntryCount = MEvent.GetEntries() * Fraction;
   ProgressBar Bar(cout, EntryCount);
   Bar.SetStyle(-1);
   
   /////////////////////////////////
   //////// Main Event Loop ////////
   /////////////////////////////////   

   for(int iE = 0; iE < EntryCount; iE++)
   {
      if(EntryCount < 300 || (iE % (EntryCount / 250)) == 0)
      {
         Bar.Update(iE);
         Bar.Print();
      }
      
      MEvent.GetEntry(iE);
      if(DoGenLevel == true)   MGen.GetEntry(iE);
      if(IsPP == true)         MTrackPP.GetEntry(iE);
      else                     MTrack.GetEntry(iE);
      MPF.GetEntry(iE);
      MMu.GetEntry(iE);
      MSkim.GetEntry(iE);
      MTrigger.GetEntry(iE);

      MZHadron.Clear();

      ////////////////////////////////////////
      ////////// Global event stuff //////////
      ////////////////////////////////////////
      
      MZHadron.Run   = MEvent.Run;
      MZHadron.Lumi  = MEvent.Lumi;
      MZHadron.Event = MEvent.Event;
      MZHadron.hiBin = MEvent.hiBin;
      if(IsPP == false && IsData == true)   // need hiBin shifts!
      {
         MZHadron.hiBinUp   = GetHiBin(MEvent.hiHF, 1);
         MZHadron.hiBinDown = GetHiBin(MEvent.hiHF, -1);
      }
      MZHadron.hiHF  = MEvent.hiHF;
      MZHadron.NPU   = 0;
      if(MEvent.npus->size() == 9)
         MZHadron.NPU = MEvent.npus->at(5);
      else if(MEvent.npus->size() > 1)
         MZHadron.NPU = MEvent.npus->at(0);
      else
         MZHadron.NPU = 0;
      
      ///////////////////////////
      ////////// Muons //////////
      ///////////////////////////

      TLorentzVector VGenZ, VGenMu1, VGenMu2;

      if(DoGenLevel == true && MMu.NGen > 1)
      {
         for(int igen1 = 0; igen1 < MMu.NGen; igen1++)
         {
            // We only want muon from Z's
            if(MMu.GenMom[igen1] != 23)
               continue;
            if(MMu.GenPT[igen1] < 20)
               continue;
            if(fabs(MMu.GenEta[igen1]) > 2.4)
               continue;

            VGenMu1.SetPtEtaPhiM(MMu.GenPT[igen1],
                  MMu.GenEta[igen1],
                  MMu.GenPhi[igen1],
                  M_MU);

            for(int igen2 = igen1 + 1; igen2 < MMu.NGen; igen2++)
            {
               // We only want muon from Z's
               if(MMu.GenMom[igen2] != 23)
                  continue;
               if(MMu.GenPT[igen2] < 20)
                  continue;
               if(fabs(MMu.GenEta[igen2]) > 2.4)
                  continue;

               VGenMu2.SetPtEtaPhiM(MMu.GenPT[igen2],
                     MMu.GenEta[igen2],
                     MMu.GenPhi[igen2],
                     M_MU);

               VGenZ = VGenMu1 + VGenMu2;

               if(VGenZ.M() < 60 || VGenZ.M() > 120)
                  continue;
               if(fabs(VGenZ.Rapidity()) > 2.4)
                  continue;

               MZHadron.genZMass->push_back(VGenZ.M());
               MZHadron.genZPt->push_back  (VGenZ.Pt());
               MZHadron.genZPhi->push_back (VGenZ.Phi());
               MZHadron.genZEta->push_back (VGenZ.Eta());

               MZHadron.genMuPt1->push_back(MMu.GenPT[igen1]);
               MZHadron.genMuPt2->push_back(MMu.GenPT[igen2]);
               MZHadron.genMuEta1->push_back(MMu.GenEta[igen1]);
               MZHadron.genMuEta2->push_back(MMu.GenEta[igen2]);
               MZHadron.genMuPhi1->push_back(MMu.GenPhi[igen1]);
               MZHadron.genMuPhi2->push_back(MMu.GenPhi[igen2]);

               double genDeltaMuEta = MMu.GenEta[igen1] - MMu.GenEta[igen2];
               double genDeltaMuPhi = PhiRangePositive(DeltaPhi(MMu.GenPhi[igen1], MMu.GenPhi[igen2]));

               MZHadron.genMuDeta->push_back(genDeltaMuEta);
               MZHadron.genMuDphi->push_back(genDeltaMuPhi);
               MZHadron.genMuDR->push_back(sqrt(genDeltaMuEta * genDeltaMuEta + genDeltaMuPhi * genDeltaMuPhi));

               double genDeltaPhiStar = tan((M_PI - genDeltaMuPhi) / 2)
                  * sqrt(1 - tanh(genDeltaMuEta / 2) * tanh(genDeltaMuEta / 2));
               MZHadron.genMuDphiS->push_back(genDeltaPhiStar);
            }
         }
      }

      for(int ipair = 0; ipair < MMu.NDi; ipair++)
      {
         // We want opposite-charge muons with some basic kinematic cuts
         if(MMu.DiCharge1[ipair] == MMu.DiCharge2[ipair])        continue;
         if(fabs(MMu.DiEta1[ipair]) > 2.4)                       continue;
         if(fabs(MMu.DiEta2[ipair]) > 2.4)                       continue;
         if(fabs(MMu.DiPT1[ipair]) < 20)                         continue;
         if(fabs(MMu.DiPT2[ipair]) < 20)                         continue;
         if(MMu.DimuonPassTightCut(ipair) == false)              continue;
         if(MMu.DiMass[ipair] < 60 || MMu.DiMass[ipair] > 120)   continue;

         TLorentzVector Mu1, Mu2;
         Mu1.SetPtEtaPhiM(MMu.DiPT1[ipair], MMu.DiEta1[ipair], MMu.DiPhi1[ipair], M_MU);
         Mu2.SetPtEtaPhiM(MMu.DiPT2[ipair], MMu.DiEta2[ipair], MMu.DiPhi2[ipair], M_MU);
         TLorentzVector Z = Mu1 + Mu2;
         if(fabs(Z.Rapidity()) > 2.4)
            continue;

         MZHadron.zMass->push_back(MMu.DiMass[ipair]);
         MZHadron.zEta->push_back(MMu.DiEta[ipair]);
         MZHadron.zPhi->push_back(MMu.DiPhi[ipair]);
         MZHadron.zPt->push_back(MMu.DiPT[ipair]);

         MZHadron.muEta1->push_back(MMu.DiEta1[ipair]);
         MZHadron.muEta2->push_back(MMu.DiEta2[ipair]);
         MZHadron.muPhi1->push_back(MMu.DiPhi1[ipair]);
         MZHadron.muPhi2->push_back(MMu.DiPhi2[ipair]);

         MZHadron.muPt1->push_back(MMu.DiPT1[ipair]);
         MZHadron.muPt2->push_back(MMu.DiPT2[ipair]);

         double deltaMuEta = MMu.DiEta1[ipair] - MMu.DiEta2[ipair];
         double deltaMuPhi = PhiRangePositive(DeltaPhi(MMu.DiPhi1[ipair], MMu.DiPhi2[ipair]));

         MZHadron.muDeta->push_back(deltaMuEta);
         MZHadron.muDphi->push_back(deltaMuPhi);
         MZHadron.muDR->push_back(sqrt(deltaMuEta * deltaMuEta + deltaMuPhi * deltaMuPhi));

         double deltaPhiStar = tan((M_PI - deltaMuPhi) / 2) * sqrt(1 - tanh(deltaMuEta / 2) * tanh(deltaMuEta / 2));

         MZHadron.muDphiS->push_back(deltaPhiStar);
      }

      MZHadron.SignalHF = DoGenLevel ? GetGenHFSum(&MGen) : (DoSumET ? MEvent.hiHF : GetHFSum(&MPF));
      MZHadron.SignalVZ = MEvent.vz;

      bool GoodGenZ = MZHadron.genZPt->size() > 0 && (MZHadron.genZPt->at(0) > MinZPT);
      bool GoodRecoZ = MZHadron.zPt->size() > 0 && (MZHadron.zPt->at(0) > MinZPT);
      if(CheckZ == true)
      {
         if(DoGenLevel == true && GoodGenZ == false)
         {
            MZHadron.FillEntry();
            continue;
         }
         if(DoGenLevel == false && GoodRecoZ == false)
         {
            MZHadron.FillEntry();
            continue;
         }   
      }

      ////////////////////////////
      ////////// Tracks //////////
      ////////////////////////////

      int NTrack = DoGenLevel ? MGen.Mult : (IsPP ? MTrackPP.nTrk : MTrack.TrackPT->size());
      for(int iT = 0; iT < NTrack; iT++)
      {
         if(DoGenLevel == true)
         {
            if(MGen.PT->at(iT) < MinTrackPT)
               continue;
            if(MGen.Eta->at(iT) < -2.4)
               continue;
            if(MGen.Eta->at(iT) > +2.4)
               continue;
            if(MGen.DaughterCount->at(iT) > 0)
               continue;
            if(MGen.Charge->at(iT) == 0)
               continue;
         }
         if(DoGenLevel == false)
         {
            if(IsPP == true)
            {
               if(DoAlternateTrackSelection == false && MTrackPP.PassZHadron2022Cut(iT) == false)
                  continue;
               if(DoAlternateTrackSelection == true && AlternateTrackSelection == 0 && MTrackPP.PassZHadron2022Cut(iT) == false)
                  continue;
               if(DoAlternateTrackSelection == true && AlternateTrackSelection == 1 && MTrackPP.PassZHadron2022CutLoose(iT) == false)
                  continue;
               if(DoAlternateTrackSelection == true && AlternateTrackSelection == 2 && MTrackPP.PassZHadron2022CutTight(iT) == false)
                  continue;
            }
            if(IsPP == false)
            {
               if(DoAlternateTrackSelection == false && MTrack.PassZHadron2022Cut(iT) == false)
                  continue;
               if(DoAlternateTrackSelection == true && AlternateTrackSelection == 0 && MTrack.PassZHadron2022Cut(iT) == false)
                  continue;
               if(DoAlternateTrackSelection == true && AlternateTrackSelection == 1 && MTrack.PassZHadron2022CutLoose(iT) == false)
                  continue;
               if(DoAlternateTrackSelection == true && AlternateTrackSelection == 2 && MTrack.PassZHadron2022CutTight(iT) == false)
                  continue;
            }
         }

         double TrackEta = DoGenLevel ? MGen.Eta->at(iT) : (IsPP ? MTrackPP.trkEta[iT] : MTrack.TrackEta->at(iT));
         double TrackPhi = DoGenLevel ? MGen.Phi->at(iT) : (IsPP ? MTrackPP.trkPhi[iT] : MTrack.TrackPhi->at(iT));
         double TrackPT  = DoGenLevel ? MGen.PT->at(iT) : (IsPP ? MTrackPP.trkPt[iT] : MTrack.TrackPT->at(iT));
         int TrackCharge = DoGenLevel ? MGen.Charge->at(iT) : (IsPP ? MTrackPP.trkCharge[iT] : MTrack.TrackCharge->at(iT));
         int SubEvent    = DoGenLevel ? (MGen.SubEvent->at(iT) + IsBackground) : (IsPP ? 0 : IsBackground);

         double Mu1Eta = DoGenLevel ? MZHadron.genMuEta1->at(0) : MZHadron.muEta1->at(0);
         double Mu1Phi = DoGenLevel ? MZHadron.genMuPhi1->at(0) : MZHadron.muPhi1->at(0);
         double Mu2Eta = DoGenLevel ? MZHadron.genMuEta2->at(0) : MZHadron.muEta2->at(0);
         double Mu2Phi = DoGenLevel ? MZHadron.genMuPhi2->at(0) : MZHadron.muPhi2->at(0);

         double DeltaEtaMu1 = TrackEta - Mu1Eta;
         double DeltaEtaMu2 = TrackEta - Mu2Eta;
         double DeltaPhiMu1 = DeltaPhi(TrackPhi, Mu1Phi);
         double DeltaPhiMu2 = DeltaPhi(TrackPhi, Mu2Phi);

         double DeltaRMu1 = sqrt(DeltaEtaMu1 * DeltaEtaMu1 + DeltaPhiMu1 * DeltaPhiMu1);
         double DeltaRMu2 = sqrt(DeltaEtaMu2 * DeltaEtaMu2 + DeltaPhiMu2 * DeltaPhiMu2);

         bool MuTagged = false;
         if(DeltaRMu1 < MuonVeto)   MuTagged = true;
         if(DeltaRMu2 < MuonVeto)   MuTagged = true;

         double ZEta = DoGenLevel ? MZHadron.genZEta->at(0) : MZHadron.zEta->at(0);
         double ZPhi = DoGenLevel ? MZHadron.genZPhi->at(0) : MZHadron.zPhi->at(0);
         
         MZHadron.trackPhi->push_back(TrackPhi);
         MZHadron.trackEta->push_back(TrackEta);
         MZHadron.trackPt->push_back(TrackPT);
         MZHadron.trackMuTagged->push_back(MuTagged);
         MZHadron.trackMuDR->push_back(min(DeltaRMu1, DeltaRMu2));
         MZHadron.subevent->push_back(SubEvent);

         double TrackCorrection = 1;
         // if(DoTrackEfficiency == true && DoGenLevel == false)
         // {
         //    if(IsPP == true)
         //       TrackCorrection = TrackEfficiencyPP->getCorrection(TrackPT, TrackEta);
         //    else
         //       TrackCorrection = TrackEfficiencyPbPb->getCorrection(TrackPT, TrackEta, MZHadron.hiBin);
         // }
         double TrackResidualCorrection = 1;
         // if(DoTrackResidual == true && DoGenLevel == false)
         // {
         //    TrackResidualCorrection = TrackResidual.GetCorrectionFactor(TrackPT, TrackEta, TrackPhi, MZHadron.h
         //          iBin);
         // }
         MZHadron.trackWeight->push_back(TrackCorrection);
         MZHadron.trackResidualWeight->push_back(TrackResidualCorrection);
      }

      MZHadron.FillEntry();
   }

   Bar.Update(EntryCount);
   Bar.Print();
   Bar.PrintLine();

   OutputFile.cd();
   Tree.Write();
   InfoTree.Write();

   OutputFile.Close();
   InputFile.Close();

   return 0;
}

double GetHFSum(PFTreeMessenger *M)
{
   if(M == nullptr)
      return -1;
   if(M->Tree == nullptr)
      return -1;

   double Sum = 0;
   for(int iPF = 0; iPF < M->ID->size(); iPF++)
      if(fabs(M->Eta->at(iPF)) > 3 && fabs(M->Eta->at(iPF)) < 5)
         Sum = Sum + M->E->at(iPF);

   // cout << Sum << endl;

   return Sum;
}

double GetGenHFSum(GenParticleTreeMessenger *M)
{
   if(M == nullptr)
      return -1;
   if(M->Tree == nullptr)
      return -1;

   double Sum = 0;
   for(int iGen = 0; iGen < M->Mult; iGen++)
   {
      if(fabs(M->Eta->at(iGen)) < 3)
         continue;
      if(fabs(M->Eta->at(iGen)) > 5)
         continue;
      if(M->DaughterCount->at(iGen) > 0)
         continue;
      Sum = Sum + M->PT->at(iGen) * cosh(M->Eta->at(iGen));
   }

   return Sum;
}


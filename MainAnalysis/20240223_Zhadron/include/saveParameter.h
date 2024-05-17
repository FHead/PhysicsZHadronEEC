void saveParametersToHistograms(const Parameters& par, TFile* outf) {
    outf->cd();  // Navigate to the output file directory

    // Create and fill histograms for each parameter
    TH1D* hMinZPT = new TH1D("parMinZPT", "parMinZPT", 1, 0, 1);
    hMinZPT->SetBinContent(1, par.MinZPT);
    
    TH1D* hMaxZPT = new TH1D("parMaxZPT", "parMaxZPT", 1, 0, 1);
    hMaxZPT->SetBinContent(1, par.MaxZPT);
    
    TH1D* hMinTrackPT = new TH1D("parMinTrackPT", "parMinTrackPT", 1, 0, 1);
    hMinTrackPT->SetBinContent(1, par.MinTrackPT);
    
    TH1D* hMaxTrackPT = new TH1D("parMaxTrackPT", "parMaxTrackPT", 1, 0, 1);
    hMaxTrackPT->SetBinContent(1, par.MaxTrackPT);
    
    TH1D* hMinHiBin = new TH1D("parMinHiBin", "parMinHiBin", 1, 0, 1);
    hMinHiBin->SetBinContent(1, par.MinHiBin);
    
    TH1D* hMaxHiBin = new TH1D("parMaxHiBin", "parMaxHiBin", 1, 0, 1);
    hMaxHiBin->SetBinContent(1, par.MaxHiBin);
    
    TH1D* hMix = new TH1D("parMix", "parMix", 1, 0, 1);
    hMix->SetBinContent(1, par.mix);
    
    TH1D* hScaleFactor = new TH1D("parScaleFactor", "parScaleFactor", 1, 0, 1);
    hScaleFactor->SetBinContent(1, par.scaleFactor);
    
    TH1D* hShift = new TH1D("parShift", "parShift", 1, 0, 1);
    hShift->SetBinContent(1, par.shift);
    
    TH1D* hNThread = new TH1D("parNThread", "parNThread", 1, 0, 1);
    hNThread->SetBinContent(1, par.nThread);
    
    TH1D* hNChunk = new TH1D("parNChunk", "parNChunk", 1, 0, 1);
    hNChunk->SetBinContent(1, par.nChunk);
    
    TH1D* hNMix = new TH1D("parNMix", "parNMix", 1, 0, 1);
    hNMix->SetBinContent(1, par.nMix);
    
    TH1D* hIsSelfMixing = new TH1D("parIsSelfMixing", "parIsSelfMixing", 1, 0, 1);
    hIsSelfMixing->SetBinContent(1, par.isSelfMixing);
    
    TH1D* hIsGenZ = new TH1D("parIsGenZ", "parIsGenZ", 1, 0, 1);
    hIsGenZ->SetBinContent(1, par.isGenZ);
    
    TH1D* hIsMuTagged = new TH1D("parIsMuTagged", "parIsMuTagged", 1, 0, 1);
    hIsMuTagged->SetBinContent(1, par.isMuTagged);
    
    TH1D* hIsPUReject = new TH1D("parIsPUReject", "parIsPUReject", 1, 0, 1);
    hIsPUReject->SetBinContent(1, par.isPUReject);
    
    TH1D* hIsHiBinUp = new TH1D("parIsHiBinUp", "parIsHiBinUp", 1, 0, 1);
    hIsHiBinUp->SetBinContent(1, par.isHiBinUp);
    
    TH1D* hIsHiBinDown = new TH1D("parIsHiBinDown", "parIsHiBinDown", 1, 0, 1);
    hIsHiBinDown->SetBinContent(1, par.isHiBinDown);
    
    TH1D* hIsPP = new TH1D("parIsPP", "parIsPP", 1, 0, 1);
    hIsPP->SetBinContent(1, par.isPP);
    
    TH1D* hMinZY = new TH1D("parMinZY", "parMinZY", 1, 0, 1);
    hMinZY->SetBinContent(1, par.MinZY);
    
    TH1D* hMaxZY = new TH1D("parMaxZY", "parMaxZY", 1, 0, 1);
    hMaxZY->SetBinContent(1, par.MaxZY);
    
    // Write histograms to the output file
    hMinZPT->Write();
    hMaxZPT->Write();
    hMinTrackPT->Write();
    hMaxTrackPT->Write();
    hMinHiBin->Write();
    hMaxHiBin->Write();
    hMix->Write();
    hScaleFactor->Write();
    hShift->Write();
    hNThread->Write();
    hNChunk->Write();
    hNMix->Write();
    hIsSelfMixing->Write();
    hIsGenZ->Write();
    hIsMuTagged->Write();
    hIsPUReject->Write();
    hIsHiBinUp->Write();
    hIsHiBinDown->Write();
    hIsPP->Write();
    hMinZY->Write();
    hMaxZY->Write();

    // Clean up
    delete hMinZPT;
    delete hMaxZPT;
    delete hMinTrackPT;
    delete hMaxTrackPT;
    delete hMinHiBin;
    delete hMaxHiBin;
    delete hMix;
    delete hScaleFactor;
    delete hShift;
    delete hNThread;
    delete hNChunk;
    delete hNMix;
    delete hIsSelfMixing;
    delete hIsGenZ;
    delete hIsMuTagged;
    delete hIsPUReject;
    delete hIsHiBinUp;
    delete hIsHiBinDown;
    delete hIsPP;
    delete hMinZY;
    delete hMaxZY;
}
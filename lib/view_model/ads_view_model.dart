import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsViewModel extends ChangeNotifier {
  AdsViewModel();
  BannerAd? bannerAd;
  bool isLoading = false;
  InterstitialAd? interstitialAd;

  getBannerAd() {
    changeLoading();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-4229186619606367/3668507063",
      listener: BannerAdListener(),
      request: AdRequest(),
    );
    bannerAd!.load();
    changeLoading();
    notifyListeners();
  }


  getFullScreenAd(){
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-4229186619606367/5942250958',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));

    interstitialAd!.show();
    changeLoading();

  }

  changeLoading(){
    isLoading=!isLoading;
    notifyListeners();
  }
}

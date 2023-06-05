import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdModService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      // Debug
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      return '';
    }
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      // Debug
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      return '';
    }
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      // Debug
      return 'ca-app-pub-3940256099942544/5224354917';
    } else {
      return '';
    }
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad Loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad load error: $error');
    },
    onAdOpened: (ad) => debugPrint('Ad Opened'),
    onAdClosed: (ad) => debugPrint('Ad Closed'),
  );
}

import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class AdsManager {
  //Unity Ads
  static String get appid {
    return '4213509';
  }

  static String get bannerAdPlacementId {
    return 'Banner_Android';
  }

  static String get bannerAdmob {
    return 'ca-app-pub-8239825341447250/8438899318';
  }

  static String get rewardAdPlacementId {
    return 'Rewarded_Android';
  }

  static String get interAdPlacementId {
    return 'inter_ads';
  }

  static String get interAdmob {
    return 'ca-app-pub-8239825341447250/7448464858';
  }

  static bool get testAds {
    return true;
  }

  static Future<void> loadUnityAds() async {
    await UnityAds.load(
      placementId: interAdPlacementId,
      onComplete: (placementId) {
        print('Load Interstitial UnityAds Complete $placementId');
      },
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  static Future showIntAds() async {
    UnityAds.showVideoAd(
      placementId: interAdPlacementId,
      onComplete: (placementId) {
        print('Video Ad $placementId completed');
      },
      onFailed: (placementId, error, message) {
        print('Video Ad $placementId failed: $error $message');
      },
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) {
        print('Video Ad $placementId skipped');
      },
    );
  }
}

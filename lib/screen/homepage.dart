import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:onepref/onepref.dart';
import 'package:restart_app/restart_app.dart';
import 'package:testing/ads/adsManager.dart';

import 'package:testing/componen/about.dart';
import 'package:testing/componen/carousel_componen.dart';
import 'package:testing/componen/drawer_componen.dart';
import 'package:testing/componen/horizontal_list.dart';
import 'package:testing/componen/masonry_componen.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:testing/screen/language.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../componen/utility.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<ProductDetails> _products = <ProductDetails>[];

  IApEngine iApEngine = IApEngine();

  List<ProductId> storeProductIds = <ProductId>[
    ProductId(id: 'remove_ads', isConsumable: true, reward: 1)
  ];

  void getProduct() async {
    await iApEngine.getIsAvailable().then((value) async {
      if (value) {
        await iApEngine.queryProducts(storeProductIds).then((response) {
          //print(response.notFoundIDs);
          setState(() {
            _products.addAll(response.productDetails);
          });
        });
      }
    });
  }

  Future<void> listenPurchases(List<PurchaseDetails> list) async {
    for (PurchaseDetails purchase in list) {
      if (purchase.status == PurchaseStatus.restored ||
          purchase.status == PurchaseStatus.purchased) {
        if (Platform.isAndroid &&
            iApEngine
                .getProductIdsOnly(storeProductIds)
                .contains(purchase.productID)) {
          final InAppPurchaseAndroidPlatformAddition androidAddition = iApEngine
              .inAppPurchase
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
        }
        if (purchase.pendingCompletePurchase) {
          await iApEngine.inAppPurchase.completePurchase(purchase);
        }
        giveUserCoins(purchase);
      }
    }
  }

  void giveUserCoins(PurchaseDetails purchaseDetails) {
    Utility.reward_remove_ads = OnePref.getInt('coins') ?? 0;
    for (var product in storeProductIds) {
      if (product.id == purchaseDetails.productID) {
        setState(() {
          Utility.reward_remove_ads =
              Utility.reward_remove_ads + product.reward!;
          OnePref.setInt('coins', Utility.reward_remove_ads);
          Restart.restartApp();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    iApEngine.inAppPurchase.purchaseStream.listen((list) {
      listenPurchases(list);
    });
    getProduct();
    Utility.reward_remove_ads = OnePref.getInt('coins') ?? 0;

    if (OnePref.getInt('coins') == 0) {
      UnityAds.init(
        gameId: AdsManager.appid,
        onComplete: () {
          print('Initialization UnityAds Complete');
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await AdsManager.loadUnityAds();
          });
        },
        onFailed: (error, message) =>
            print('Initialization UnityAds Failed: $error $message'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
//SCAFFOLD
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        title: Text(
          "Home",
          style: TextStyle(color: Colors.grey[900]),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () async {
                iApEngine.handlePurchase(_products[0], storeProductIds);
              },
              child: Lottie.asset('assets/removeads_lottie.json')),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Language()));
            },
            child: Container(
              margin: EdgeInsets.all(12),
              child: SvgPicture.asset(
                'assets/language.svg',
                height: 38,
                width: 38,
              ),
            ),
          ),
        ],
        leading: IconButton(
          splashRadius: 25,
          icon: Icon(Icons.menu_rounded),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          color: Colors.grey[900],
          iconSize: 27,
        ),
      ),
      drawer: DrawerComponen(),
      body: Container(
        child: CustomScrollView(
          slivers: [
            // MySliverAppBar(),
            SliverToBoxAdapter(child: CarouselComponen()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Catagory",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            SliverToBoxAdapter(child: HorizontalList()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("About",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            SliverToBoxAdapter(child: About()),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 10, right: 10),
            //     child: UnityBannerAd(
            //         size: BannerSize.leaderboard,
            //         placementId: AdsManager.bannerAdPlacementId,
            //         listener: (state, args) {
            //           print('Banner Listener: $state => $args');
            //         },
            //       ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Photos",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            SliverToBoxAdapter(child: MasonryComponen())
          ],
        ),
      ),
    );
  }
}
